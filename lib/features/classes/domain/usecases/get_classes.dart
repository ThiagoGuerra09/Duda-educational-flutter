import 'package:injectable/injectable.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';
import 'package:duda_educational_flutter/features/classes/domain/repositories/classes_repository.dart';

@injectable
class GetClasses {
  const GetClasses(this._repository);

  final ClassesRepository _repository;

  Future<List<ClassEntity>> call() => _repository.getClasses();
}
