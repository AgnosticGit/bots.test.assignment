import 'package:flutter/widgets.dart';

class TasksPiechartIndicator extends StatelessWidget {
  const TasksPiechartIndicator({
    required this.title,
    this.size = 15.0,
    this.color,
  });

  final double size;
  final Color? color;
  final Widget title;

  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
        const SizedBox(width: 10.0),
        title,
      ],
    );
  }
}
