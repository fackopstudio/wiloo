import 'package:flutter/material.dart';

class WilooScaffold extends StatelessWidget {
  const WilooScaffold({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(24), children: children),
      ),
    );
  }
}
