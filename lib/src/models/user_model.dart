import 'dart:convert';

class UserModel {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? profileType;
  final int? points;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profileType,
    this.points,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? profileType,
    int? points,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profileType: profileType ?? this.profileType,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profileType': profileType,
      'points': points,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profileType:
          map['profileType'] != null ? map['profileType'] as String : null,
      points: map['points'] != null ? map['points'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, password: $password, profileType: $profileType, points: $points)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.profileType == profileType &&
        other.points == points;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profileType.hashCode ^
        points.hashCode;
  }
}
