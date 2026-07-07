import 'package:equatable/equatable.dart';

class ClassMaterial extends Equatable {
  const ClassMaterial({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final String icon;

  @override
  List<Object?> get props => [id, title, icon];
}

class ClassStudent extends Equatable {
  const ClassStudent({
    required this.id,
    required this.name,
    required this.registration,
  });

  final String id;
  final String name;
  final String registration;

  @override
  List<Object?> get props => [id, name, registration];
}

class ClassActivity extends Equatable {
  const ClassActivity({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
  });

  final String id;
  final String title;
  final String dueDate;
  final String status;

  @override
  List<Object?> get props => [id, title, dueDate, status];
}

class ClassGrade extends Equatable {
  const ClassGrade({
    required this.studentName,
    required this.grade,
  });

  final String studentName;
  final double grade;

  @override
  List<Object?> get props => [studentName, grade];
}

class ClassAttendance extends Equatable {
  const ClassAttendance({
    required this.studentName,
    required this.rate,
  });

  final String studentName;
  final String rate;

  @override
  List<Object?> get props => [studentName, rate];
}

class ClassDetail extends Equatable {
  const ClassDetail({
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
  final List<ClassMaterial> materials;
  final List<ClassStudent> students;
  final List<ClassActivity> activities;
  final List<ClassGrade> grades;
  final List<ClassAttendance> attendance;

  @override
  List<Object?> get props => [
        id,
        name,
        offerId,
        schedule,
        location,
        averageGrade,
        classGroup,
        semester,
        studentCount,
        attendanceRate,
        materials,
        students,
        activities,
        grades,
        attendance,
      ];
}
