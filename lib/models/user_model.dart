// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String banner;
  final bool isAuthenticated;
  final int karma;
  final List<String> awards;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.banner,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? banner,
    bool? isAuthenticated,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      banner: banner ?? this.banner,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'banner': banner,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      banner: map['banner'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      karma: map['karma'] as int,
      awards: List<String>.from((map['awards'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, photoUrl: $photoUrl, banner: $banner, isAuthenticated: $isAuthenticated, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.banner == banner &&
        other.isAuthenticated == isAuthenticated &&
        other.karma == karma &&
        listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        banner.hashCode ^
        isAuthenticated.hashCode ^
        karma.hashCode ^
        awards.hashCode;
  }
}
