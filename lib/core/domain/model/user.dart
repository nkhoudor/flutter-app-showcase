import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
  });

  const User.empty()
      : id = '',
        username = '';

  final String id;
  final String username;

  @override
  List<Object> get props => [
        id,
        username,
      ];

  User copyWith({String? id, String? username}) => User(
        id: id ?? this.id,
        username: username ?? this.username,
      );
}
