import 'package:flutter/material.dart';

class NumbersSection extends StatelessWidget {
  final double height;
  final double width;

  const NumbersSection({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.purple,
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
