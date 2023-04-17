import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const valueKey = ValueKey("DetailPage");

  const DetailPage({
    super.key,
    required this.storyId,
    required this.onNavigateBack,
  });

  final String storyId;
  final void Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardwidth = totalWidth;
    var previewCardHeight = totalWidth * 1 / 2;
    if (totalWidth > 620.0) {
      previewCardHeight = totalWidth * 1 / 3;
    }

    var story = Story(
      id: storyId,
      name: 'Rully Ihza M',
      description: 'Hari yang sangat indah untuk membagikan suasana hati.',
      photoUrl: 'https://picsum.photos/id/210/300/200',
      createdAt: AppLocalizations.of(context)!.dateInDays(3),
      latitude: 233.03453,
      longitude: 21.05453,
    );

    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: screenPaddingSize),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DailyUsAppBar(
                    onBack: onNavigateBack,
                    title: AppLocalizations.of(context)!.titleDetail,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ImagePreviewCard(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.network(
                      story.photoUrl,
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
                        story.name,
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
                        story.createdAt,
                        style: detailDateTextStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    story.description,
                    style: detailDescriptionTextStyle(),
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
}
