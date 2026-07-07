import 'package:duda_educational_flutter/features/profile/domain/entities/profile.dart';

class ProfileModel {
  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final professor = json['professor'] as Map<String, dynamic>;
    return ProfileModel(
      id: professor['id'] as String,
      name: professor['name'] as String,
      initials: professor['initials'] as String,
      email: professor['email'] as String,
      photoUrl: professor['photoUrl'] as String?,
      department: professor['department'] as String,
      campus: professor['campus'] as String,
      subjects: (professor['subjects'] as List<dynamic>).cast<String>(),
      bio: professor['bio'] as String,
    );
  }

  final String id;
  final String name;
  final String initials;
  final String email;
  final String? photoUrl;
  final String department;
  final String campus;
  final List<String> subjects;
  final String bio;

  Profile toEntity() => Profile(
        id: id,
        name: name,
        initials: initials,
        email: email,
        photoUrl: photoUrl,
        department: department,
        campus: campus,
        subjects: subjects,
        bio: bio,
      );
}
