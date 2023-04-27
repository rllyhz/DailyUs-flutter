import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/bloc/detail/detail_bloc.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/shimmers/detail_page_shimmer.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailPage extends StatefulWidget {
  static const valueKey = ValueKey("DetailPage");

  const DetailPage({
    super.key,
    required this.storyId,
    required this.onNavigateBack,
    required this.authInfo,
  });

  final String storyId;
  final void Function() onNavigateBack;
  final AuthInfo authInfo;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late GoogleMapController _mapController;
  late LatLng _storyPos;
  final Set<Marker> _markers = {};
  MapType _selectedMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _onRefresh(context);
  }

  void _onRefresh(BuildContext context) {
    if (context.mounted) {
      context.read<DetailBloc>().add(
            OnFetchDetailStoryEvent(
              widget.authInfo.user.token,
              widget.storyId,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardwidth = totalWidth;
    var previewCardHeight = totalWidth * 1 / 2;
    if (totalWidth > 620.0) {
      previewCardHeight = totalWidth * 1 / 3;
    }
    var googleMapsHeight = totalWidth * 1.3;
    if (totalWidth > 620.0) {
      googleMapsHeight = totalWidth * 1 / 2;
    }

    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailStateLoading) {
          return const Scaffold(
            body: DetailPageShimmer(
              fadeTheme: FadeTheme.light,
            ),
          );
        } else if (state is DetailStateError) {
          var failure = state.failure;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: screenPaddingSize),
                child: Column(
                  children: <Widget>[
                    DailyUsAppBar(
                      onBack: widget.onNavigateBack,
                      title: AppLocalizations.of(context)!.titleDetail,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 32.0,
                          ),
                          Center(
                            child: Text(
                              getFailureMessage(context, failure),
                              style: detailDescriptionTextStyle(),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          appOutlinedButton(
                            text: AppLocalizations.of(context)!.buttonRefresh,
                            onPressed: () {
                              _onRefresh(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          var detailStory = (state as DetailStateHasData).detailStory;
          bool shouldShowMaps = false;
          _storyPos = LatLng(detailStory.latitude, detailStory.longitude);

          if (validateLatitude(_storyPos.latitude) &&
              validateLongitude(_storyPos.longitude)) {
            Logger.log(_storyPos.latitude.toString());
            Logger.log(_storyPos.longitude.toString());
            Logger.log("show google maps!");
            shouldShowMaps = true;
          }

          return Scaffold(
            body: SizedBox.expand(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: screenPaddingSize),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DailyUsAppBar(
                          onBack: widget.onNavigateBack,
                          title: AppLocalizations.of(context)!.titleDetail,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        ImagePreviewCard(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.network(
                            detailStory.photoUrl,
                            width: previewCardwidth,
                            height: previewCardHeight,
                            errorBuilder: (context, err, track) => Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: primaryColor,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              getFormattedName(detailStory.name),
                              style: detailFullNameTextStyle(),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 8.0,
                              height: 8.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              getFormattedDate(context, detailStory.createdAt),
                              style: detailDateTextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          detailStory.description,
                          style: detailDescriptionTextStyle(),
                        ),
                        if (shouldShowMaps)
                          const SizedBox(
                            height: 32.0,
                          ),
                        if (shouldShowMaps)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: SizedBox(
                              height: googleMapsHeight,
                              child: Stack(
                                children: <Widget>[
                                  GoogleMap(
                                    gestureRecognizers: {
                                      Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
                                      )
                                    },
                                    markers: _markers,
                                    mapType: _selectedMapType,
                                    initialCameraPosition: CameraPosition(
                                      zoom: 18.0,
                                      target: _storyPos,
                                    ),
                                    myLocationButtonEnabled: false,
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    onMapCreated: (controller) {
                                      _onMapReady(controller);
                                      _showMarkerOnStoryPos(detailStory.id);
                                    },
                                  ),
                                  // Zoom Controller
                                  Positioned(
                                    bottom: 16.0,
                                    right: 16.0,
                                    child: Column(
                                      children: [
                                        FloatingActionButton.small(
                                          backgroundColor: Colors.white,
                                          heroTag: "zoom-in",
                                          onPressed: () {
                                            _mapController.animateCamera(
                                                CameraUpdate.zoomIn());
                                          },
                                          child:
                                              const Icon(CupertinoIcons.plus),
                                        ),
                                        FloatingActionButton.small(
                                          backgroundColor: Colors.white,
                                          heroTag: "zoom-out",
                                          onPressed: () {
                                            _mapController.animateCamera(
                                                CameraUpdate.zoomOut());
                                          },
                                          child:
                                              const Icon(CupertinoIcons.minus),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Map Type Menu
                                  Positioned(
                                    top: 16.0,
                                    right: 16.0,
                                    child: FloatingActionButton.small(
                                      onPressed: null,
                                      backgroundColor: Colors.white,
                                      child: PopupMenuButton<MapType>(
                                        offset: const Offset(0, 54),
                                        icon: const Icon(CupertinoIcons.layers),
                                        onSelected: _onSelectedMapType,
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<MapType>>[
                                          PopupMenuItem<MapType>(
                                            value: MapType.normal,
                                            child: Text(
                                              'Normal',
                                              style: detailDescriptionTextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem<MapType>(
                                            value: MapType.satellite,
                                            child: Text(
                                              'Satellite',
                                              style: detailDescriptionTextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem<MapType>(
                                            value: MapType.terrain,
                                            child: Text(
                                              'Terrain',
                                              style: detailDescriptionTextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem<MapType>(
                                            value: MapType.hybrid,
                                            child: Text(
                                              'Hybrid',
                                              style: detailDescriptionTextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ], // GoogleMap Stack Container
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _onMapReady(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        _mapController = controller;
      });
    }
  }

  void _onSelectedMapType(MapType selectedType) {
    if (mounted) {
      setState(() {
        _selectedMapType = selectedType;
      });
    }
  }

  Future<void> _showMarkerOnStoryPos(String id) async {
    final info = await geo.placemarkFromCoordinates(
      _storyPos.latitude,
      _storyPos.longitude,
    );

    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    final marker = Marker(
      markerId: MarkerId(id),
      position: _storyPos,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    if (mounted) {
      setState(() {
        _markers.add(marker);
      });
    }
  }
}
