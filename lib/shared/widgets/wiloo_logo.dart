import 'package:flutter/material.dart';

/// Renders the Wiloo brand logo from bundled assets, with a text fallback when
/// the asset cannot be loaded (keeps tests and missing-asset cases safe).
class WilooLogo extends StatelessWidget {
  const WilooLogo({this.height = 36, super.key});

  static const _asset = 'assets/brand/wiloo_logo_horizontal.png';

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _asset,
      height: height,
      fit: BoxFit.contain,
      semanticLabel: 'Wiloo',
      errorBuilder: (context, error, stackTrace) => _Fallback(height: height),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      'Wiloo',
      style: TextStyle(
        fontSize: height * 0.6,
        fontWeight: FontWeight.w800,
        color: cs.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}
