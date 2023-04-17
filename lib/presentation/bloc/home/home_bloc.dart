import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/usecases/get_all_stories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllStories _getAllStoriesUsecase;

  HomeBloc(this._getAllStoriesUsecase) : super(HomeStateLoading()) {
    on<OnFetchAllStoriesEvent>((event, emit) async {
      emit(HomeStateLoading());

      final token = event.token;
      final result = await _getAllStoriesUsecase.execute(token);

      emit(
        result.fold(
          (failure) => HomeStateError(failure),
          (stories) => HomeStateHasData(stories),
        ),
      );
    });
  }
}
