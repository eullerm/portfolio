import 'package:flutter/material.dart';

class Responsive {
  BuildContext context;
  late String screen;
  Responsive({
    required this.context,
  }) {
    if (MediaQuery.of(context).size.width <= 600) {
      screen = 'MOBILE';
    } else if (MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.width < 1366) {
      screen = 'TABLET';
    } else if (MediaQuery.of(context).size.width >= 1366 && MediaQuery.of(context).size.width < 3840) {
      screen = 'DESKTOP';
    } else {
      screen = '4K';
    }
  }

  Responsive copyWith({
    BuildContext? context,
  }) {
    return Responsive(
      context: context ?? this.context,
    );
  }

  @override
  String toString() => 'Responsive(context: $context)';

  @override
  bool operator ==(covariant Responsive other) {
    if (identical(this, other)) return true;

    return other.context == context;
  }

  @override
  int get hashCode => context.hashCode;
}
