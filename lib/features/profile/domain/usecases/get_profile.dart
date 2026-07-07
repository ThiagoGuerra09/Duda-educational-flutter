import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/profile/domain/entities/profile.dart';
import 'package:duda_educational_flutter/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfile {
  const GetProfile(this._repository);

  final ProfileRepository _repository;

  Future<Profile> call() => _repository.getProfile();
}
