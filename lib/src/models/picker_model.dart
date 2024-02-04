import 'dart:convert';

class PickerModel {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? profileType;

  PickerModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profileType,
  });

  PickerModel copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? profileType,
  }) {
    return PickerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profileType: profileType ?? this.profileType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profileType': profileType,
    };
  }

  factory PickerModel.fromMap(Map<String, dynamic> map) {
    return PickerModel(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profileType:
          map['profileType'] != null ? map['profileType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickerModel.fromJson(String source) =>
      PickerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PickerModel(id: $id, username: $username, email: $email, password: $password, profileType: $profileType)';
  }

  @override
  bool operator ==(covariant PickerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.profileType == profileType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profileType.hashCode;
  }
}
