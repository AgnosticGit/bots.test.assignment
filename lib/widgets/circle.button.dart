import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({this.onTap, this.child});

  final void Function()? onTap;
  final Widget? child;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: child,
      ),
    );
  }
}
