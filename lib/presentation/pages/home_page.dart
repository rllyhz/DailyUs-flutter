import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/presentation/widgets/daily_us_story_item.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/shimmers/home_page_shimmer.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const valueKey = ValueKey("HomePage");

  const HomePage({super.key, required this.onDetail});

  final void Function(String) onDetail;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var isLoading = false;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: screenPaddingSize,
          right: screenPaddingSize,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 24.0,
            ),
            Text(
              AppLocalizations.of(context)!.homeGreetingUserExample,
              style: homeGreetingUserTextStyle(),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              AppLocalizations.of(context)!.homeGreetingHeadline,
              style: homeGreetingHeadlineTextStyle(),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              width: totalWidth * 1 / 2,
              height: 6.0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            isLoading
                ? const Expanded(
                    child: HomePageShimmer(
                      padding: EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      distanceBetweenItems: 12.0,
                      fadeTheme: FadeTheme.light,
                      totalItem: 10,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: DailyUsStoryItem(
                            padding: const EdgeInsets.all(12.0),
                            story: Story(
                              id: 'index-$index',
                              name: 'Rully Ihza M',
                              createdAt:
                                  AppLocalizations.of(context)!.dateInJustNow,
                              description:
                                  "Hari yang sangat indah untuk membagikan suasana hati.",
                              photoUrl:
                                  'https://picsum.photos/id/${101 + index}/300/200',
                              latitude: 0,
                              longitude: 0,
                            ),
                            onClick: (story) {
                              onDetail(story.id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
