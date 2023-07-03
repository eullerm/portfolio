import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

class Experiences extends ChangeNotifier {
  List<Experience> experiences;
  Experiences({
    required this.experiences,
  });

  Experiences copyWith({
    List<Experience>? experiences,
  }) {
    return Experiences(
      experiences: experiences ?? this.experiences,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'experiences': experiences.map((Experience experience) => experience.toMap()),
    };
  }

  factory Experiences.fromMap(List<dynamic> list) {
    List<Experience> exp = [];

    exp = list.map((experience) => Experience.fromMap(experience)).toList();
    return Experiences(
      experiences: exp,
    );
  }

  String toJson() => jsonEncode(
        experiences.map((Experience experience) => experience.toJson()).toList(),
      );

  factory Experiences.fromJson(String source) {
    List<Experience> exp = [];

    if (source.isNotEmpty) {
      List<dynamic> list = jsonDecode(source) as List<dynamic>;
      exp = list.map((experience) => Experience.fromJson(experience)).toList();
    }

    return Experiences(experiences: exp);
  }

  @override
  String toString() => 'Experiences(experiences: $experiences)';

  @override
  bool operator ==(covariant Experiences other) {
    if (identical(this, other)) return true;

    return listEquals(other.experiences, experiences);
  }

  @override
  int get hashCode => experiences.hashCode;

  void update(Experiences? experiences) {
    this.experiences = experiences?.experiences ?? [];
    notifyListeners();
  }
}

class Experience extends ChangeNotifier {
  String language;
  String company;
  String description;
  List<String> listOfDescription;
  String startDate;
  String endDate;
  String seeMore;
  Experience({
    required this.language,
    required this.company,
    required this.description,
    required this.listOfDescription,
    required this.startDate,
    required this.endDate,
    required this.seeMore,
  });

  Experience copyWith({
    String? language,
    String? company,
    String? description,
    List<String>? listOfDescription,
    String? startDate,
    String? endDate,
    String? seeMore,
  }) {
    return Experience(
      language: language ?? this.language,
      company: company ?? this.company,
      description: description ?? this.description,
      listOfDescription: listOfDescription ?? this.listOfDescription,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      seeMore: seeMore ?? this.seeMore,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'company': company,
      'description': description,
      'listOfDescription': listOfDescription.join(r'\n'),
      'startDate': startDate,
      'endDate': endDate,
      'seeMore': seeMore,
    };
  }

  update(Experience? experience) {
    this.language = experience?.language ?? '';
    this.company = experience?.company ?? '';
    this.description = experience?.description ?? '';
    this.listOfDescription = experience?.listOfDescription ?? [];
    this.startDate = experience?.startDate ?? '';
    this.endDate = experience?.endDate ?? '';
    this.seeMore = experience?.seeMore ?? '';
    notifyListeners();
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      language: (map['language'] ?? '') as String,
      company: (map['company'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      listOfDescription: List<String>.from((map['listOfDescription'] as String).split(r'\n')),
      startDate: (map['startDate'] ?? '') as String,
      endDate: (map['endDate'] ?? '') as String,
      seeMore: (map['seeMore'] ?? '') as String,
    );
  }

  factory Experience.fromMapCell(Map<String, Cell> map) {
    return Experience(
      language: map['language']?.value as String,
      company: map['company']?.value as String,
      description: map['description']?.value as String,
      listOfDescription: List<String>.from((map['listOfDescription']?.value.split(r'\n') as List<String>)),
      startDate: map['startDate']?.value as String,
      endDate: map['endDate']?.value as String,
      seeMore: map['seeMore']?.value as String,
    );
  }
  String toJson() => jsonEncode(toMap());

  factory Experience.fromJson(String source) {
    return source.isNotEmpty
        ? Experience.fromMap(jsonDecode(source) as Map<String, dynamic>)
        : Experience(
            language: '',
            company: '',
            description: '',
            listOfDescription: [],
            startDate: '',
            endDate: '',
            seeMore: '',
          );
  }

  @override
  String toString() {
    return 'Experiences(language: $language, company: $company, description: $description, listOfDescription: $listOfDescription, startDate: $startDate, endDate: $endDate, seeMore: $seeMore)';
  }

  @override
  bool operator ==(covariant Experience other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.company == company &&
        other.description == description &&
        listEquals(other.listOfDescription, listOfDescription) &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.seeMore == seeMore;
  }

  @override
  int get hashCode {
    return language.hashCode ^
        company.hashCode ^
        description.hashCode ^
        listOfDescription.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        seeMore.hashCode;
  }
}
