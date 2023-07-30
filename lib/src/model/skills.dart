import 'dart:convert';
import 'package:flutter/foundation.dart';

class Skills extends ChangeNotifier {
  List<String> skills;
  Skills({
    required this.skills,
  });

  Skills copyWith({
    List<String>? skills,
  }) {
    return Skills(
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'skills': skills,
    };
  }

  factory Skills.fromMap(List<dynamic> list) {
    return Skills(
      skills: list.map((skill) => skill['skills'] as String).toList(),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Skills.fromJson(String source) {
    List<String> skillsData = ((jsonDecode(source)['skills']) as List<dynamic>).map((skill) => skill as String).toList();
    return Skills(skills: skillsData);
  }

  @override
  String toString() => 'Skills(skills: $skills)';

  @override
  bool operator ==(covariant Skills other) {
    if (identical(this, other)) return true;

    return listEquals(other.skills, skills);
  }

  @override
  int get hashCode => skills.hashCode;
}
