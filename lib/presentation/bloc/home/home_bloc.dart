import 'package:daily_us/common/failure.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/usecases/get_all_stories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllStories _getAllStoriesUsecase;

  final List<Story> _allStories = List.empty(growable: true);
  bool isLoadingMoreStillOnProgress = false;
  int _pageIndex = 1;

  HomeBloc(this._getAllStoriesUsecase) : super(HomeStateLoading()) {
    on<OnFetchAllStoriesEvent>((event, emit) async {
      emit(HomeStateLoading());

      final token = event.token;
      final result = await _getAllStoriesUsecase.execute(
        token,
        page: _pageIndex,
      );

      emit(
        result.fold(
          (failure) => HomeStateError(failure),
          (initialStories) {
            if (initialStories.isEmpty) {
              return HomeStateDataEmpty();
            } else {
              _allStories.addAll(initialStories);
              _pageIndex += 1;
              return HomeStateHasData(_allStories);
            }
          },
        ),
      );
    });

    on<OnLoadMoreStoriesEvent>((event, emit) async {
      emit(HomeStateLoadMoreProgress(_allStories));

      await Future.delayed(const Duration(seconds: 4));

      isLoadingMoreStillOnProgress = true;

      final token = event.token;
      final result = await _getAllStoriesUsecase.execute(
        token,
        page: _pageIndex,
      );

      emit(
        result.fold(
          (failure) => HomeStateLoadMoreError(failure, _allStories),
          (moreStories) {
            _allStories.addAll(moreStories);
            _pageIndex += 1;
            return HomeStateHasData(_allStories);
          },
        ),
      );

      isLoadingMoreStillOnProgress = false;

      Logger.log("Page index: ${(_pageIndex - 1).toString()}");
      Logger.log("Total stories: ${_allStories.length.toString()}");
    });
  }
}
