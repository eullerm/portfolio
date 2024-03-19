import 'dart:convert';
import 'package:flutter/foundation.dart';

class Projects extends ChangeNotifier {
  List<Project> projects;
  Projects({
    required this.projects,
  });

  Projects copyWith({
    List<Project>? projects,
  }) {
    return Projects(
      projects: projects ?? this.projects,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projects': projects.map((Project project) => project.toMap()).toList(),
    };
  }

  factory Projects.fromMap(List<dynamic> list) {
    List<Project> prj = [];

    prj = list.map((project) => Project.fromMap(project)).toList();
    return Projects(
      projects: prj,
    );
  }

  String toJson() => jsonEncode(
        projects.map((Project project) => project.toJson()).toList(),
      );

  factory Projects.fromJson(String source) {
    List<Project> prj = [];

    if (source.isNotEmpty) {
      List<dynamic> list = jsonDecode(source) as List<dynamic>;
      prj = list.map((project) => Project.fromJson(project)).toList();
    }

    return Projects(projects: prj);
  }
  @override
  String toString() => 'Projects(projects: $projects)';

  @override
  bool operator ==(covariant Projects other) {
    if (identical(this, other)) return true;

    return listEquals(other.projects, projects);
  }

  @override
  int get hashCode => projects.hashCode;
}

class Project extends ChangeNotifier {
  String name;
  String scheme;
  String host;
  String path; // scheme+host+path == https://www.example.com/list
  Project({
    required this.name,
    required this.scheme,
    required this.host,
    required this.path,
  });

  Project copyWith({
    String? name,
    String? scheme,
    String? host,
    String? path,
  }) {
    return Project(
      name: name ?? this.name,
      scheme: scheme ?? this.scheme,
      host: host ?? this.host,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'scheme': scheme,
      'host': host,
      'path': path,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'] as String,
      scheme: map['scheme'] as String,
      host: map['host'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(name: $name, scheme: $scheme, host: $host, path: $path)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.name == name && other.scheme == scheme && other.host == host && other.path == path;
  }

  @override
  int get hashCode {
    return name.hashCode ^ scheme.hashCode ^ host.hashCode ^ path.hashCode;
  }
}
