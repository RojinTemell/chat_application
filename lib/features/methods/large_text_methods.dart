import 'package:flutter/material.dart';

class TextLargeWidget extends StatelessWidget {
  const TextLargeWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .displayMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
