import 'package:duda_educational_flutter/features/classes/domain/entities/class_detail.dart';

class ClassMaterialModel {
  ClassMaterialModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory ClassMaterialModel.fromJson(Map<String, dynamic> json) =>
      ClassMaterialModel(
        id: json['id'] as String,
        title: json['title'] as String,
        icon: json['icon'] as String,
      );

  final String id;
  final String title;
  final String icon;

  ClassMaterial toEntity() =>
      ClassMaterial(id: id, title: title, icon: icon);
}

class ClassStudentModel {
  ClassStudentModel({
    required this.id,
    required this.name,
    required this.registration,
  });

  factory ClassStudentModel.fromJson(Map<String, dynamic> json) =>
      ClassStudentModel(
        id: json['id'] as String,
        name: json['name'] as String,
        registration: json['registration'] as String,
      );

  final String id;
  final String name;
  final String registration;

  ClassStudent toEntity() =>
      ClassStudent(id: id, name: name, registration: registration);
}

class ClassActivityModel {
  ClassActivityModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
  });

  factory ClassActivityModel.fromJson(Map<String, dynamic> json) =>
      ClassActivityModel(
        id: json['id'] as String,
        title: json['title'] as String,
        dueDate: json['dueDate'] as String,
        status: json['status'] as String,
      );

  final String id;
  final String title;
  final String dueDate;
  final String status;

  ClassActivity toEntity() =>
      ClassActivity(id: id, title: title, dueDate: dueDate, status: status);
}

class ClassGradeModel {
  ClassGradeModel({
    required this.studentName,
    required this.grade,
  });

  factory ClassGradeModel.fromJson(Map<String, dynamic> json) =>
      ClassGradeModel(
        studentName: json['studentName'] as String,
        grade: (json['grade'] as num).toDouble(),
      );

  final String studentName;
  final double grade;

  ClassGrade toEntity() =>
      ClassGrade(studentName: studentName, grade: grade);
}

class ClassAttendanceModel {
  ClassAttendanceModel({
    required this.studentName,
    required this.rate,
  });

  factory ClassAttendanceModel.fromJson(Map<String, dynamic> json) =>
      ClassAttendanceModel(
        studentName: json['studentName'] as String,
        rate: json['rate'] as String,
      );

  final String studentName;
  final String rate;

  ClassAttendance toEntity() =>
      ClassAttendance(studentName: studentName, rate: rate);
}

class ClassDetailModel {
  ClassDetailModel({
    required this.id,
    required this.name,
    required this.offerId,
    required this.schedule,
    required this.location,
    required this.averageGrade,
    required this.classGroup,
    required this.semester,
    required this.studentCount,
    required this.attendanceRate,
    required this.materials,
    required this.students,
    required this.activities,
    required this.grades,
    required this.attendance,
  });

  factory ClassDetailModel.fromJson(Map<String, dynamic> json) =>
      ClassDetailModel(
        id: json['id'] as String,
        name: json['name'] as String,
        offerId: json['offerId'] as String,
        schedule: json['schedule'] as String,
        location: json['location'] as String,
        averageGrade: (json['averageGrade'] as num).toDouble(),
        classGroup: json['classGroup'] as String,
        semester: json['semester'] as String,
        studentCount: json['studentCount'] as int,
        attendanceRate: json['attendanceRate'] as String,
        materials: (json['materials'] as List<dynamic>)
            .map((e) => ClassMaterialModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        students: (json['students'] as List<dynamic>)
            .map((e) => ClassStudentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        activities: (json['activities'] as List<dynamic>)
            .map((e) => ClassActivityModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        grades: (json['grades'] as List<dynamic>)
            .map((e) => ClassGradeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        attendance: (json['attendance'] as List<dynamic>)
            .map((e) => ClassAttendanceModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final String id;
  final String name;
  final String offerId;
  final String schedule;
  final String location;
  final double averageGrade;
  final String classGroup;
  final String semester;
  final int studentCount;
  final String attendanceRate;
  final List<ClassMaterialModel> materials;
  final List<ClassStudentModel> students;
  final List<ClassActivityModel> activities;
  final List<ClassGradeModel> grades;
  final List<ClassAttendanceModel> attendance;

  ClassDetail toEntity() => ClassDetail(
        id: id,
        name: name,
        offerId: offerId,
        schedule: schedule,
        location: location,
        averageGrade: averageGrade,
        classGroup: classGroup,
        semester: semester,
        studentCount: studentCount,
        attendanceRate: attendanceRate,
        materials: materials.map((m) => m.toEntity()).toList(),
        students: students.map((s) => s.toEntity()).toList(),
        activities: activities.map((a) => a.toEntity()).toList(),
        grades: grades.map((g) => g.toEntity()).toList(),
        attendance: attendance.map((a) => a.toEntity()).toList(),
      );
}
