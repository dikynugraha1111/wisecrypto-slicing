import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/user/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(UserState());

  final UserRepository _userRepository;

  Future<void> fetchUser() async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final user = await _userRepository.getUser();
      emit(state.copyWith(
        status: UserStatus.loaded,
        user: user,
      ));
    } on Exception {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}