import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';
import 'package:duda_educational_flutter/features/classes/domain/repositories/classes_repository.dart';

@injectable
class GetClassDetail {
  const GetClassDetail(this._repository);

  final ClassesRepository _repository;

  Future<ClassDetail> call(String id) => _repository.getClassDetail(id);
}
