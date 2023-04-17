import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/presentation/widgets/cards/daily_us_card.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class DailyUsStoryItem extends StatelessWidget {
  const DailyUsStoryItem({
    super.key,
    this.onClick,
    required this.padding,
    required this.story,
  });

  final Story story;
  final EdgeInsetsGeometry padding;
  final void Function(Story)? onClick;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardwidth = totalWidth;
    var previewCardHeight = totalWidth * 1 / 2;
    if (totalWidth > 620.0) {
      previewCardHeight = totalWidth * 1 / 3;
    }

    return InkWell(
      onTap: () {
        if (onClick != null) {
          onClick!(story);
        }
      },
      child: DailyUsCard(
        padding: padding,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: previewCardwidth,
              height: previewCardHeight,
              child: ImagePreviewCard(
                padding: const EdgeInsets.all(0.0),
                child: Image.network(
                  story.photoUrl,
                  errorBuilder: (contex, err, track) => Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: primaryColor,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  getFormattedName(story.name),
                  style: homeCardFullNameTextStyle(),
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
                  getFormattedDate(context, story.createdAt),
                  style: homeCardDateTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              story.description,
              style: homeCardDescriptionTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
