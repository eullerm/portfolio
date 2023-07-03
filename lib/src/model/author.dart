import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

class Author extends ChangeNotifier {
  String name;
  String role;
  String description;
  String photo;
  String language;
  String cvPath;

  Author({required this.name, required this.role, required this.description, required this.photo, required this.language, required this.cvPath}) {
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'role': role,
      'description': description,
      'photo': photo,
      'language': language,
      'cvPath': cvPath,
    };
  }

  update(Author? author) {
    this.name = author?.name ?? '';
    this.role = author?.role ?? '';
    this.description = author?.description ?? '';
    this.photo = author?.photo ?? '';
    this.language = author?.language ?? '';
    this.cvPath = author?.cvPath ?? '';
    notifyListeners();
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      name: (map['name'] ?? '') as String,
      role: (map['role'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      photo: (map['photo'] ?? '') as String,
      language: (map['language'] ?? '') as String,
      cvPath: (map['cvPath'] ?? '') as String,
    );
  }

  factory Author.fromMapCell(Map<String, Cell> map) {
    return Author(
      name: map['name']?.value as String,
      role: map['role']?.value as String,
      description: map['description']?.value as String,
      photo: map['photo']?.value as String,
      language: map['language']?.value as String,
      cvPath: map['cvPath']?.value as String,
    );
  }
  String toJson() => jsonEncode(toMap());

  factory Author.fromJson(String source) {
    return source.isNotEmpty
        ? Author.fromMap(jsonDecode(source) as Map<String, dynamic>)
        : Author(
            name: '',
            role: '',
            description: '',
            photo: '',
            language: '',
            cvPath: '',
          );
  }
  @override
  String toString() {
    return 'Author(name: $name, role: $role, description: $description, photo: $photo, language: $language, cvPath: $cvPath)';
  }

  @override
  bool operator ==(covariant Author other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.role == role &&
        other.description == description &&
        other.photo == photo &&
        other.language == language &&
        other.cvPath == cvPath;
  }

  @override
  int get hashCode {
    return name.hashCode ^ role.hashCode ^ description.hashCode ^ photo.hashCode ^ language.hashCode ^ cvPath.hashCode;
  }
}
