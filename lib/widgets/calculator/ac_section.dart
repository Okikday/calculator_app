import 'package:flutter/material.dart';

class AcSection extends StatelessWidget {
  final double height;
  final double width;
  const AcSection({
    super.key, 
    required this.height, 
    required this.width,
  
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.orange,
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
