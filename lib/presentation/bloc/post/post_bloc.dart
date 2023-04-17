import 'package:daily_us/common/failure.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/usecases/upload_new_story.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UploadNewStory _uploadNewStoryUseCase;

  PostBloc(this._uploadNewStoryUseCase) : super(PostStateInitial()) {
    on<OnUploadStoryEvent>((event, emit) async {
      emit(PostStateUploading());

      final photo = event.photoXFile;
      final token = event.token;
      final description = event.description;
      final latitude = event.latitude;
      final longitude = event.longitude;

      try {
        var photoBytes = await photo.readAsBytes();
        var compressedBytes = await compressImage(photoBytes);

        final result = await _uploadNewStoryUseCase.execute(
          token,
          compressedBytes,
          description,
          latitude,
          longitude,
        );

        emit(
          result.fold(
            (failure) => PostStateUploadFailed(failure),
            (isSuccess) => isSuccess
                ? PostStateUploadDone(isSuccess)
                : PostStateUploadFailed(const UnknownFailure()),
          ),
        );
      } catch (e) {
        emit(PostStateUploadFailed(const InternalFailure()));
        Logger.logWithTag("Failed to compress bytes", e.toString());
      }
    });
  }
}
