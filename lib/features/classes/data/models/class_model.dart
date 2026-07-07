import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/features/classes/domain/entities/class_entity.dart';

Color _parseColor(String hex) {
  final value = hex.replaceFirst('#', '');
  return Color(int.parse('FF$value', radix: 16));
}

class ClassModel {
  ClassModel({
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

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json['id'] as String,
        code: json['code'] as String,
        name: json['name'] as String,
        course: json['course'] as String,
        studentCount: json['studentCount'] as int,
        schedule: json['schedule'] as String,
        status: json['status'] as String,
        accentColor: json['accentColor'] as String,
        instructors: json['instructors'] as String,
      );

  final String id;
  final String code;
  final String name;
  final String course;
  final int studentCount;
  final String schedule;
  final String status;
  final String accentColor;
  final String instructors;

  ClassEntity toEntity() => ClassEntity(
        id: id,
        code: code,
        name: name,
        course: course,
        studentCount: studentCount,
        schedule: schedule,
        status: status,
        accentColor: _parseColor(accentColor),
        instructors: instructors,
      );
}

class ClassesResponseModel {
  ClassesResponseModel({required this.classes});

  factory ClassesResponseModel.fromJson(Map<String, dynamic> json) =>
      ClassesResponseModel(
        classes: (json['classes'] as List<dynamic>)
            .map((e) => ClassModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<ClassModel> classes;
}
