import 'package:daily_us/domain/usecases/logout.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Logout _logoutUsecase;

  ProfileBloc(this._logoutUsecase) : super(ProfileStateInitial()) {
    on<OnLogoutEvent>((event, emit) {
      final success = _logoutUsecase.execute();

      emit(
        success
            ? ProfileStateLogoutSuccess()
            : ProfileStateLogoutError('Error internally'),
      );
    });
  }
}
