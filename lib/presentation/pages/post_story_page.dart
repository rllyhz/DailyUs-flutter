import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_area.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class PostStoryPage extends StatelessWidget {
  static const valueKey = ValueKey("PostStoryPage");

  const PostStoryPage({
    super.key,
    required this.onUploadSuccess,
  });

  final void Function() onUploadSuccess;

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
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .postPreviewPhotoLabel,
                              style: postPhotoPreviewLabelTextStyle(),
                            ),
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
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: appOutlinedButton(
                              text: AppLocalizations.of(context)!
                                  .buttonPickFromGallery,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      DailyUsTextArea(
                        hintText: AppLocalizations.of(context)!.descriptionHint,
                      ),
                      const SizedBox(
                        height: 72.0,
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
                onPressed: () {
                  onUploadSuccess();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
