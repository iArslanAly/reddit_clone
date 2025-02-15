// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommunityModels {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final String createdAt;
  final List<String> members;
  final List<String> mods;

  CommunityModels({
    required this.id,
    required this.name,
    required this.banner,
    required this.avatar,
    required this.createdAt,
    required this.members,
    required this.mods,
  });

  CommunityModels copyWith({
    String? id,
    String? name,
    String? banner,
    String? avatar,
    List<String>? members,
    List<String>? mods,
  }) {
    return CommunityModels(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt,
      members: members ?? this.members,
      banner: banner ?? this.banner,
      avatar: avatar ?? this.avatar,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'members': members,
      'avatar': avatar,
      'mods': mods,
    };
  }

  factory CommunityModels.fromMap(Map<String, dynamic> map) {
    return CommunityModels(
      id: map['id']?.toString() ?? '', // Prevents null crash
      name: map['name']?.toString() ?? 'Unknown',
      banner: map['banner']?.toString() ?? '', // Ensures it's always a String
      avatar: map['avatar']?.toString() ?? '', // Ensures it's always a String
      createdAt:
          map['createdAt']?.toString() ?? '', // Ensures it's always a String
      members: (map['members'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [], // Prevents null crash
      mods:
          (map['mods'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              [], // Prevents null crash
    );
  }

  factory CommunityModels.fromJson(String source) =>
      CommunityModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityModels(id: $id, name: $name, banner: $banner, avatar: $avatar, members: $members, mods: $mods, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant CommunityModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.banner == banner &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        listEquals(other.members, members) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        banner.hashCode ^
        avatar.hashCode ^
        members.hashCode ^
        createdAt.hashCode ^
        mods.hashCode;
  }
}
