import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';
import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';

abstract class ClassesRepository {
  Future<List<ClassEntity>> getClasses();

  Future<ClassDetail> getClassDetail(String id);
}
