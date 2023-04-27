import 'package:daily_us/common/constants.dart';
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
  final void Function(LatLng) onSuccessGetLocation;

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  late GoogleMapController _mapController;

  bool _isMapReady = false;
  LatLng? _selectedCoordinate;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    //
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
                onBack: widget.onCancel,
                title: AppLocalizations.of(context)!.titleDetail,
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-6.8957473, 107.6337669),
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
                  Visibility(
                    visible: _selectedCoordinate != null,
                    child: Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: appButton(
                        text: 'Oke',
                        onPressed: () {
                          if (_selectedCoordinate == null) {
                            widget.onCancel();
                          } else {
                            widget.onSuccessGetLocation(_selectedCoordinate!);
                          }
                        },
                      ),
                    ),
                  ),

                  // loading indicator
                  Visibility(
                    visible: _isMapReady,
                    child: Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
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
      if (!serviceEnabled) {
        Logger.log("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Logger.log("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    await _addMarker(latLng);

    _mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  Future<void> _addMarker(LatLng latLng) async {
    final placemarks = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    final place = placemarks[0];

    final street = place.street;
    final address =
        '${place.subLocality ?? '-'}, ${place.locality ?? '-'}, ${place.postalCode ?? '-'}, ${place.country ?? '-'}';

    final marker = Marker(
      markerId: const MarkerId('source-location'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    if (mounted) {
      setState(() {
        _markers.clear();
        _markers.add(marker);
        _selectedCoordinate = latLng;
      });
    }
  }
}
