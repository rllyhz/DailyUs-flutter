import 'dart:async';

import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/presentation/bloc/detail/detail_bloc.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/shimmers/detail_page_shimmer.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController<dynamic>? _bottomSheetController;

  late LatLng _storyPos;
  late Story _story;
  bool _shouldShowMaps = false;

  final Set<Marker> _markers = {};
  final _initialPos = const LatLng(-6.8957473, 107.6337669); // dicoding office

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();

    if (mounted) {
      context
          .read<DetailBloc>()
          .stream
          .skipWhile((state) =>
              state is DetailStateError || state is DetailStateLoading)
          .listen((state) {
        if (state is DetailStateHasData && mounted) {
          _story = state.detailStory;
          _showBottomSheet();
          _validateCoordinate();
        }
      });
    }

    _onRefresh();
  }

  @override
  void dispose() {
    _bottomSheetController = null;
    super.dispose();
  }

  void _onRefresh() {
    context.read<DetailBloc>().add(
          OnFetchDetailStoryEvent(
            widget.authInfo.user.token,
            widget.storyId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: screenPaddingSize),
              child: DailyUsAppBar(
                onBack: widget.onNavigateBack,
                title: AppLocalizations.of(context)!.titleDetail,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: totalWidth,
                    height: double.maxFinite,
                    child: GoogleMap(
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: _initialPos,
                        zoom: 18.0,
                      ),
                      onMapCreated: (controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: screenPaddingSize,
                    left: screenPaddingSize,
                    right: screenPaddingSize,
                    child: appButton(
                      text: AppLocalizations.of(context)!.buttonSelectLocation,
                      onPressed: () {
                        _showBottomSheet();
                      },
                    ),
                  ),
                  if (!_shouldShowMaps)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white,
                        child: BlocBuilder<DetailBloc, DetailState>(
                          builder: (context, state) {
                            if (state is DetailStateLoading) {
                              return const DetailPageShimmer(
                                fadeTheme: FadeTheme.light,
                              );
                            } else if (state is DetailStateError) {
                              var failure = state.failure;
                              return Column(
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
                                    text: AppLocalizations.of(context)!
                                        .buttonRefresh,
                                    onPressed: _onRefresh,
                                  ),
                                ],
                              );
                            } else {
                              return const Center();
                            }
                          },
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

  void _showBottomSheet() {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardwidth = totalWidth;
    var previewCardHeight = totalWidth * 1 / 2;
    if (totalWidth > 620.0) {
      previewCardHeight = totalWidth * 1 / 3;
    }
    var bottomSheetWidth = totalWidth - 16.0;
    var bottomSheetHeight = MediaQuery.of(context).size.height * 0.75;

    _bottomSheetController = null;

    _bottomSheetController = _scaffoldKey.currentState?.showBottomSheet(
      (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _story.photoUrl,
              width: previewCardwidth,
              height: previewCardHeight,
              fit: BoxFit.fitWidth,
              errorBuilder: (ctx, _, err) => Container(
                width: previewCardwidth,
                height: previewCardHeight,
                color: primaryColor,
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: screenPaddingSize,
                right: screenPaddingSize,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    getFormattedName(_story.name),
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
                    getFormattedDate(context, _story.createdAt),
                    style: detailDateTextStyle(),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: screenPaddingSize,
                right: screenPaddingSize,
              ),
              child: Text(
                _story.description,
                style: detailDescriptionTextStyle(),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
      constraints: BoxConstraints.expand(
        width: bottomSheetWidth,
        height: bottomSheetHeight,
      ),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      )),
      elevation: 2.0,
    );

    _bottomSheetController?.closed.then((_) {
      if (!_shouldShowMaps) {
        Future.delayed(const Duration(milliseconds: 600), () {
          widget.onNavigateBack();
        });
      }
    });
  }

  void _validateCoordinate() {
    _storyPos = LatLng(_story.latitude, _story.longitude);

    if (validateLatitude(_storyPos.latitude) &&
        validateLongitude(_storyPos.longitude)) {
      Logger.log(
        "Lat: ${_storyPos.latitude.toString()}\nLon: ${_storyPos.longitude.toString()}\nShould show google maps!",
        showPadding: true,
      );

      if (mounted) {
        setState(() {
          _shouldShowMaps = true;
        });
      }

      _showMarkerOnStoryPos();
    }
  }

  Future<void> _showMarkerOnStoryPos() async {
    Map<String, String> info;
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        _storyPos.latitude,
        _storyPos.longitude,
      );

      info = getInfoFromPlacemark(placemarks[0]);
    } catch (e) {
      info = getInfoFromPlacemark(geo.Placemark());
      Logger.log(e.toString());
      if (mounted) {
        showToast(
          AppLocalizations.of(context)!.locationFailedToMarkPlaceMessage,
        );
      }
    }

    final marker = Marker(
      markerId: MarkerId(_story.id),
      position: _storyPos,
      infoWindow: InfoWindow(
        title: info['street'],
        snippet: info['address'],
      ),
    );

    if (mounted) {
      setState(() {
        _markers.add(marker);
      });
    }

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(_storyPos, 18.0),
    );
  }
}
