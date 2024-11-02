import 'package:flutter/material.dart';

class SignsSection extends StatelessWidget {
  final double screenHeight;
  final double width;

  const SignsSection({
    super.key,
    required this.screenHeight,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: Colors.green,
            child: SizedBox(
              width: width,
            ),
          ),
        ),
        ColoredBox(
          color: Colors.indigo,
          child: SizedBox(
            width: width,
            height: screenHeight * 0.08,
          ),
        ),
      ],
    );
  }
}
