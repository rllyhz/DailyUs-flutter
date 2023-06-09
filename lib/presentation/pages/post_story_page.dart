import 'dart:io';

import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/flavor_config.dart';
import 'package:daily_us/presentation/bloc/post/post_bloc.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_area.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PostStoryPage extends StatefulWidget {
  static const valueKey = ValueKey("PostStoryPage");

  const PostStoryPage({
    super.key,
    required this.onUploadSuccess,
    required this.onGoGetLocation,
    required this.authInfo,
    this.controller,
  });

  final void Function() onUploadSuccess;
  final void Function() onGoGetLocation;
  final PostStoryPageController? controller;
  final AuthInfo authInfo;

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage> {
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _result;
  String? _pathFile;

  bool _isLocationAdded = false;
  LatLng? _selectedCoordinate;
  Map<String, String>? _placeInfo;

  late bool _isUploadLocationAvailable;

  @override
  void initState() {
    super.initState();

    _isUploadLocationAvailable =
        FlavorConfig.instance.values.uploadWithLocationAvailable;

    if (widget.controller != null) {
      widget.controller!.onLatLngChange = (newLatLng, placeInfo) async {
        await Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _placeInfo = placeInfo;
              _selectedCoordinate = newLatLng;
              _isLocationAdded = newLatLng != null;
            });
          }
        });
      };
    }

    context.read<PostBloc>().stream.listen((state) {
      if (state is PostStateUploadDone && mounted) {
        showToast(
          AppLocalizations.of(context)!.uploadSuccessMessage,
          isError: false,
        );
        //
        widget.onUploadSuccess();
        //
      } else if (state is PostStateUploadFailed && mounted) {
        showToast(
          AppLocalizations.of(context)!.uploadFailedMessage,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardHeight = totalWidth * 2 / 4;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: screenPaddingSize,
          right: screenPaddingSize,
        ),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: previewCardHeight,
                        child: ImagePreviewCard(
                          padding: const EdgeInsets.all(0.0),
                          child: _result == null
                              ? Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .postPreviewPhotoLabel,
                                    style: postPhotoPreviewLabelTextStyle(),
                                  ),
                                )
                              : kIsWeb
                                  ? Image.network(
                                      _pathFile!.toString(),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_pathFile.toString()),
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: appOutlinedButton(
                              text: AppLocalizations.of(context)!
                                  .buttonTakePicture,
                              onPressed: context.watch<PostBloc>().state
                                      is PostStateUploading
                                  ? null
                                  : _onCameraView,
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: appOutlinedButton(
                              text: AppLocalizations.of(context)!
                                  .buttonPickFromGallery,
                              onPressed: context.watch<PostBloc>().state
                                      is PostStateUploading
                                  ? null
                                  : _onGalleryView,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      DailyUsTextArea(
                        controller: _descriptionController,
                        hintText: AppLocalizations.of(context)!.descriptionHint,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      if (_isUploadLocationAvailable)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.addLocationHint,
                              style: postDescriptionTextStyle(),
                            ),
                            Switch.adaptive(
                              activeColor: secondaryColor,
                              value: _isLocationAdded,
                              onChanged: (newValue) async {
                                if (mounted) {
                                  setState(() {
                                    _isLocationAdded = newValue;
                                    if (!_isLocationAdded) _placeInfo = null;
                                  });

                                  if (_isLocationAdded) {
                                    // go to set location pages
                                    await Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      widget.onGoGetLocation();
                                    });
                                  } else {
                                    _selectedCoordinate = null;
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      // selected place result
                      if (_placeInfo != null && _isUploadLocationAvailable)
                        const SizedBox(
                          height: 16.0,
                        ),
                      if (_placeInfo != null && _isUploadLocationAvailable)
                        Text(
                          _placeInfo!['street']!,
                          style: postDescriptionTextStyle(
                              fontSize: 16, color: purple200Color),
                        ),
                      if (_placeInfo != null && _isUploadLocationAvailable)
                        Text(
                          _placeInfo!['address']!,
                          style: postDescriptionTextStyle(
                            fontSize: 14,
                            color: purple200Color.withOpacity(
                              0.7,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 120.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenPaddingSize,
              left: 0,
              right: 0,
              child: appButton(
                text: AppLocalizations.of(context)!.buttonUpload,
                showLoadingState:
                    context.watch<PostBloc>().state is PostStateUploading,
                onPressed: () {
                  _onUpload(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGalleryView() async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;

    const isWeb = kIsWeb;
    if (!isWeb) {
      if (isMacOS || isLinux) return;
    }

    var file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) {
      return;
    }

    _result = file;

    if (_result != null) {
      _pathFile = _result!.path;
    }
    setState(() {});
  }

  void _onCameraView() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    var file = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (file == null) {
      return;
    }

    _result = file;

    if (_result != null) {
      _pathFile = _result!.path;
    }
    setState(() {});
  }

  void _onUpload(BuildContext context) async {
    if (_result == null || _pathFile == null && mounted) {
      showToast(
        AppLocalizations.of(context)!.photoEmptyMessage,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    var description = _descriptionController.value.text.toString();

    if (description.isEmpty && mounted) {
      showToast(
        AppLocalizations.of(context)!.descriptionEmptyMessage,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (mounted) {
      Logger.log("lat: ${_selectedCoordinate?.latitude.toString() ?? 'null'}");
      Logger.log("lon: ${_selectedCoordinate?.longitude.toString() ?? 'bull'}");

      context.read<PostBloc>().add(
            OnUploadStoryEvent(
              photoXFile: _result!,
              token: widget.authInfo.user.token,
              description: description,
              latitude: _selectedCoordinate?.latitude,
              longitude: _selectedCoordinate?.longitude,
            ),
          );
    }
  }
}

class PostStoryPageController {
  late void Function(LatLng?, Map<String, String>? placeInfo) onLatLngChange;
}
