import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/core/errors/exceptions.dart';
import 'package:duda_educational_flutter/core/errors/failures.dart';
import 'package:duda_educational_flutter/features/profile/domain/usecases/get_profile.dart';
import 'package:duda_educational_flutter/features/profile/presentation/cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfile) : super(const ProfileState.initial());

  final GetProfile _getProfile;

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    try {
      final profile = await _getProfile();
      emit(ProfileState.success(profile));
    } on ServerException catch (e) {
      emit(ProfileState.failure(e.message));
    } on Failure catch (e) {
      emit(ProfileState.failure(e.message));
    } catch (e) {
      emit(ProfileState.failure(e.toString()));
    }
  }
}
