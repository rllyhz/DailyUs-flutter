import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/usecases/get_detail_story.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailStory _getDetailStoryUsecase;

  DetailBloc(this._getDetailStoryUsecase) : super(DetailStateLoading()) {
    on<OnFetchDetailStoryEvent>((event, emit) async {
      emit(DetailStateLoading());

      final token = event.token;
      final id = event.storyId;
      final result = await _getDetailStoryUsecase.execute(token, id);

      emit(
        result.fold(
          (failure) => DetailStateError(failure),
          (story) => story == null
              ? DetailStateError(const UnknownFailure())
              : DetailStateHasData(story),
        ),
      );
    });
  }
}
