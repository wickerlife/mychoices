import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final DateTime firstDay;
  final String profileImage;

  const User(
      {required this.name, required this.firstDay, required this.profileImage});

  User copyWith({
    String? name,
    DateTime? firstDay,
    String? profileImage,
  }) =>
      User(
          name: name ?? this.name,
          firstDay: firstDay ?? this.firstDay,
          profileImage: profileImage ?? this.profileImage);

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      firstDay: DateTime.parse(json['firstDay']),
      profileImage: json['profileImage']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'firstDay': firstDay.toIso8601String(),
        'profileImage': profileImage,
      };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
