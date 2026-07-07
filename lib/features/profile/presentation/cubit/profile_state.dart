import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/profile/domain/entities/profile.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  const ProfileState.initial() : this();

  const ProfileState.loading() : this(status: ProfileStatus.loading);

  const ProfileState.success(Profile profile)
      : this(status: ProfileStatus.success, profile: profile);

  const ProfileState.failure(String message)
      : this(status: ProfileStatus.failure, errorMessage: message);

  final ProfileStatus status;
  final Profile? profile;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
