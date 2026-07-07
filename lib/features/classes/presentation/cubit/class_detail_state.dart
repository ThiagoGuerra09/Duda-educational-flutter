import 'package:equatable/equatable.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';

enum ClassDetailStatus { initial, loading, success, failure }

class ClassDetailState extends Equatable {
  const ClassDetailState({
    this.status = ClassDetailStatus.initial,
    this.detail,
    this.errorMessage,
  });

  const ClassDetailState.initial() : this();

  const ClassDetailState.loading() : this(status: ClassDetailStatus.loading);

  const ClassDetailState.success(ClassDetail detail)
      : this(status: ClassDetailStatus.success, detail: detail);

  const ClassDetailState.failure(String message)
      : this(status: ClassDetailStatus.failure, errorMessage: message);

  final ClassDetailStatus status;
  final ClassDetail? detail;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, detail, errorMessage];
}
