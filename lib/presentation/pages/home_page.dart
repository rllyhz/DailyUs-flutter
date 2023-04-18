import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/bloc/home/home_bloc.dart';
import 'package:daily_us/presentation/widgets/daily_us_story_item.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/shimmers/home_page_shimmer.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const valueKey = ValueKey("HomePage");

  const HomePage({
    super.key,
    required this.onDetail,
    required this.authInfo,
    this.controller,
  });

  final void Function(String) onDetail;
  final AuthInfo authInfo;
  final HomePageController? controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!.refresh = _refresh;
      widget.controller!.scrollToTop = _scrollToTop;
    }

    _onRefresh(context);
  }

  void _onRefresh(BuildContext context) {
    if (mounted) {
      context.read<HomeBloc>().add(
            OnFetchAllStoriesEvent(
              widget.authInfo.user.token,
            ),
          );
    }
  }

  void _refresh() {
    _onRefresh(context);
  }

  void _scrollToTop() {
    if (mounted) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;

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
              AppLocalizations.of(context)!.homeGreetingUser(
                getFirstName(widget.authInfo.user.name),
              ),
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
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeStateLoading) {
                  return const Expanded(
                    child: HomePageShimmer(
                      padding: EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      distanceBetweenItems: 12.0,
                      fadeTheme: FadeTheme.light,
                      totalItem: 10,
                    ),
                  );
                } else if (state is HomeStateError) {
                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 32.0,
                      ),
                      Center(
                        child: Text(
                          getFailureMessage(
                            context,
                            state.failure,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      appOutlinedButton(
                        text: AppLocalizations.of(context)!.buttonRefresh,
                        onPressed: () {
                          _onRefresh(context);
                        },
                      ),
                    ],
                  );
                } else {
                  var stories = (state as HomeStateHasData).stories;

                  return Expanded(
                    child: RefreshIndicator(
                      color: secondaryColor,
                      onRefresh: () async {
                        _onRefresh(context);
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: DailyUsStoryItem(
                              padding: const EdgeInsets.all(12.0),
                              story: stories[index],
                              onClick: (story) {
                                widget.onDetail(story.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageController {
  late void Function() refresh;
  late void Function() scrollToTop;
}
