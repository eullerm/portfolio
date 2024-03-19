import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

class Thanks with ChangeNotifier {
  String thanksTitle;
  String thanksPhrase;
  Thanks({
    required this.thanksTitle,
    required this.thanksPhrase,
  }) {
    notifyListeners();
  }

  Thanks copyWith({
    String? thanksTitle,
    String? thanksPhrase,
  }) {
    return Thanks(
      thanksTitle: thanksTitle ?? this.thanksTitle,
      thanksPhrase: thanksPhrase ?? this.thanksPhrase,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thanksTitle': thanksTitle,
      'thanksPhrase': thanksPhrase,
    };
  }

  update(Thanks? thanks) {
    this.thanksTitle = thanks?.thanksTitle ?? '';
    this.thanksPhrase = thanks?.thanksPhrase ?? '';
    notifyListeners();
  }

  factory Thanks.fromMap(Map<String, dynamic> map) {
    return Thanks(
      thanksTitle: (map['thanksTitle'] ?? '') as String,
      thanksPhrase: (map['thanksPhrase'] ?? '') as String,
    );
  }

  factory Thanks.fromMapCell(Map<String, Cell> map) {
    return Thanks(
      thanksPhrase: map['thanksPhrase']?.value as String,
      thanksTitle: map['thanksTitle']?.value as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory Thanks.fromJson(String source) => source.isNotEmpty
      ? Thanks.fromMap(json.decode(source) as Map<String, dynamic>)
      : Thanks(
          thanksTitle: '',
          thanksPhrase: '',
        );

  @override
  String toString() => 'Thanks(thanksTitle: $thanksTitle, thanksPhrase: $thanksPhrase)';

  @override
  bool operator ==(covariant Thanks other) {
    if (identical(this, other)) return true;

    return other.thanksTitle == thanksTitle && other.thanksPhrase == thanksPhrase;
  }

  @override
  int get hashCode => thanksTitle.hashCode ^ thanksPhrase.hashCode;
}
