import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.name,
    required this.initials,
    required this.email,
    required this.department,
    required this.campus,
    required this.subjects,
    required this.bio,
    this.photoUrl,
  });

  final String id;
  final String name;
  final String initials;
  final String email;
  final String? photoUrl;
  final String department;
  final String campus;
  final List<String> subjects;
  final String bio;

  @override
  List<Object?> get props => [
        id,
        name,
        initials,
        email,
        photoUrl,
        department,
        campus,
        subjects,
        bio,
      ];
}
