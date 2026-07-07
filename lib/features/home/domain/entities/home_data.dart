import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  const HomeData({
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

  final String professorName;
  final String initials;
  final String welcomeMessage;
  final List<HomeSubject> subjects;
  final List<QuickAccessItem> quickAccess;
  final int pendingAssignments;
  final int unreadNotifications;
  final String? nextClassSubject;
  final String? nextClassTime;
  final String? nextClassRoom;

  @override
  List<Object?> get props => [
        professorName,
        initials,
        welcomeMessage,
        subjects,
        quickAccess,
        pendingAssignments,
        unreadNotifications,
        nextClassSubject,
        nextClassTime,
        nextClassRoom,
      ];
}

class HomeSubject extends Equatable {
  const HomeSubject({
    required this.id,
    required this.name,
    required this.classCount,
  });

  final String id;
  final String name;
  final int classCount;

  @override
  List<Object?> get props => [id, name, classCount];
}

class QuickAccessItem extends Equatable {
  const QuickAccessItem({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String title;
  final String subtitle;

  @override
  List<Object?> get props => [id, title, subtitle];
}
