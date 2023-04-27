import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class GetLocationPage extends StatefulWidget {
  static const valueKey = ValueKey("PostStoryPage");

  const GetLocationPage({
    super.key,
    required this.onCancel,
    required this.onSuccessGetLocation,
  });

  final void Function() onCancel;
  final void Function(LatLng, Map<String, String>) onSuccessGetLocation;

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeInOpacityAnimValue;
  final _animDuration = const Duration(seconds: 1);

  late GoogleMapController _mapController;

  bool _isMapReady = false;
  LatLng? _selectedCoordinate;
  Map<String, String>? _placeInfo;
  final Set<Marker> _markers = {};

  final _showConfirmButton = ValueNotifier<bool>(false);

  void _onValuChanged() {
    if (_showConfirmButton.value) {
      _animController.forward();
    } else {
      _animController.animateBack(0.0);
    }
  }

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: _animDuration,
    );
    _fadeInOpacityAnimValue =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animController);

    _showConfirmButton.addListener(_onValuChanged);
    _showConfirmButton.value = _selectedCoordinate != null;
  }

  @override
  void dispose() {
    _showConfirmButton.removeListener(_onValuChanged);
    _showConfirmButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: screenPaddingSize,
                right: screenPaddingSize,
              ),
              child: DailyUsAppBar(
                onBack: () {
                  if (_isMapReady) {
                    _mapController.dispose();
                    widget.onCancel();
                  }
                },
                title: AppLocalizations.of(context)!.titleLocation,
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-6.8957473, 107.6337669), // dicoding space
                      zoom: 18.0,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    onMapCreated: (controller) {
                      if (mounted) {
                        setState(() {
                          _isMapReady = true;
                          _mapController = controller;
                        });
                      }
                    },
                    onLongPress: (longClickedCoordinate) {
                      _addMarker(longClickedCoordinate);
                    },
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: FloatingActionButton(
                      child: const Icon(CupertinoIcons.location),
                      onPressed: () {
                        _onMyLocationButtonPressed();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: FadeTransition(
                      opacity: _fadeInOpacityAnimValue,
                      child: appButton(
                        text:
                            AppLocalizations.of(context)!.buttonSelectLocation,
                        onPressed: () {
                          if (_selectedCoordinate == null) {
                            showToast(
                              AppLocalizations.of(context)!
                                  .locationNotSelectedYetMessage,
                            );
                          } else if (_placeInfo == null) {
                            return;
                          } else {
                            widget.onSuccessGetLocation(
                              _selectedCoordinate!,
                              _placeInfo!,
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // dummy loading indicator
                  if (!_isMapReady)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMyLocationButtonPressed() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled && mounted) {
        showToast(
          AppLocalizations.of(context)!.locationServiceIsNotAvailableMessage,
        );
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted && mounted) {
        showToast(
          AppLocalizations.of(context)!.locationPermissionIsDeniedMessage,
        );
        return;
      }
    }

    try {
      locationData = await location.getLocation();
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);

      await _addMarker(latLng);
      //
    } catch (e) {
      if (mounted) {
        showToast(
          AppLocalizations.of(context)!
              .locationFailedToGetMyLocationDataMessage,
        );
      }
      Logger.log(e.toString());
    }
  }

  Future<void> _addMarker(LatLng latLng) async {
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final info = getInfoFromPlacemark(placemarks[0]);

      final marker = Marker(
        markerId: const MarkerId('source-location'),
        position: latLng,
        infoWindow: InfoWindow(
          title: info['street'],
          snippet: info['address'],
        ),
      );

      if (mounted) {
        setState(() {
          _markers.clear();
          _markers.add(marker);
          _selectedCoordinate = latLng;
          _placeInfo = info;
        });
      }

      _mapController.animateCamera(
        CameraUpdate.newLatLng(latLng),
      );

      _showConfirmButton.value = true;
      //
    } catch (e) {
      if (mounted) {
        showToast(
          AppLocalizations.of(context)!.locationFailedToMarkPlaceMessage,
        );
      }

      if (_selectedCoordinate == null) {
        _showConfirmButton.value = false;
      } else {
        _showConfirmButton.value = false;
      }
      Logger.log(e.toString());
    }
  }
}
