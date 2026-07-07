import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';

enum ClassesStatus { initial, loading, success, failure }

class ClassesState extends Equatable {
  const ClassesState({
    this.status = ClassesStatus.initial,
    this.classes = const [],
    this.errorMessage,
  });

  const ClassesState.initial() : this();

  const ClassesState.loading() : this(status: ClassesStatus.loading);

  const ClassesState.success(List<ClassEntity> classes)
      : this(status: ClassesStatus.success, classes: classes);

  const ClassesState.failure(String message)
      : this(status: ClassesStatus.failure, errorMessage: message);

  final ClassesStatus status;
  final List<ClassEntity> classes;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, classes, errorMessage];
}
