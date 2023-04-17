import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/bloc/detail/detail_bloc.dart';
import 'package:daily_us/presentation/widgets/cards/image_preview_card.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/shimmers/detail_page_shimmer.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    _onRefresh(context);
  }

  void _onRefresh(BuildContext context) {
    if (mounted) {
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
}
