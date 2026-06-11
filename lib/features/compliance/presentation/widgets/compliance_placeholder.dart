import 'package:flutter/material.dart';

class CompliancePlaceholder extends StatelessWidget {
  const CompliancePlaceholder(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
