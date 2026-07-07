import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClassEntity extends Equatable {
  const ClassEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.course,
    required this.studentCount,
    required this.schedule,
    required this.status,
    required this.accentColor,
    required this.instructors,
  });

  final String id;
  final String code;
  final String name;
  final String course;
  final int studentCount;
  final String schedule;
  final String status;
  final Color accentColor;
  final String instructors;

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        course,
        studentCount,
        schedule,
        status,
        accentColor,
        instructors,
      ];
}
