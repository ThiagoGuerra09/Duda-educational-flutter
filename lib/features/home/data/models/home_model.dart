import 'package:duda_educational_flutter/features/home/domain/entities/home_data.dart';

class HomeModel {
  HomeModel({
    required this.professorName,
    required this.initials,
    required this.welcomeMessage,
    required this.subjects,
    required this.quickAccess,
    required this.pendingAssignments,
    required this.unreadNotifications,
    this.nextClassSubject,
    this.nextClassTime,
    this.nextClassRoom,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final professor = json['professor'] as Map<String, dynamic>;
    final nextClass = json['nextClass'] as Map<String, dynamic>?;
    return HomeModel(
      professorName: professor['name'] as String,
      initials: professor['initials'] as String,
      welcomeMessage: json['welcomeMessage'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => HomeSubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quickAccess: (json['quickAccess'] as List<dynamic>)
          .map((e) => QuickAccessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingAssignments: json['pendingAssignments'] as int,
      unreadNotifications: json['unreadNotifications'] as int,
      nextClassSubject: nextClass?['subject'] as String?,
      nextClassTime: nextClass?['time'] as String?,
      nextClassRoom: nextClass?['room'] as String?,
    );
  }

  final String professorName;
  final String initials;
  final String welcomeMessage;
  final List<HomeSubjectModel> subjects;
  final List<QuickAccessModel> quickAccess;
  final int pendingAssignments;
  final int unreadNotifications;
  final String? nextClassSubject;
  final String? nextClassTime;
  final String? nextClassRoom;

  HomeData toEntity() => HomeData(
        professorName: professorName,
        initials: initials,
        welcomeMessage: welcomeMessage,
        subjects: subjects.map((s) => s.toEntity()).toList(),
        quickAccess: quickAccess.map((q) => q.toEntity()).toList(),
        pendingAssignments: pendingAssignments,
        unreadNotifications: unreadNotifications,
        nextClassSubject: nextClassSubject,
        nextClassTime: nextClassTime,
        nextClassRoom: nextClassRoom,
      );
}

class HomeSubjectModel {
  HomeSubjectModel({
    required this.id,
    required this.name,
    required this.classCount,
  });

  factory HomeSubjectModel.fromJson(Map<String, dynamic> json) => HomeSubjectModel(
        id: json['id'] as String,
        name: json['name'] as String,
        classCount: json['classCount'] as int,
      );

  final String id;
  final String name;
  final int classCount;

  HomeSubject toEntity() => HomeSubject(id: id, name: name, classCount: classCount);
}

class QuickAccessModel {
  QuickAccessModel({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory QuickAccessModel.fromJson(Map<String, dynamic> json) => QuickAccessModel(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
      );

  final String id;
  final String title;
  final String subtitle;

  QuickAccessItem toEntity() =>
      QuickAccessItem(id: id, title: title, subtitle: subtitle);
}
