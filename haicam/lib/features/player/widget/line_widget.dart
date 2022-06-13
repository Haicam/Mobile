import 'package:flutter/material.dart';

class LineGen extends StatelessWidget {
  final List lines;
  const LineGen({Key? key, required this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        4,
        (index) => Container(
          height: 2.0,
          width: lines[index],
          color: Colors.grey,
          margin: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
