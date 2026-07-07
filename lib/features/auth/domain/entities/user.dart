import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.token,
    this.name,
    this.email,
  });

  final String id;
  final String token;
  final String? name;
  final String? email;

  @override
  List<Object?> get props => [id, token, name, email];
}
