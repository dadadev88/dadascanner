import 'package:flutter/material.dart';

class BadgeText extends StatelessWidget {
  final String text;
  final Color bgColor;

  const BadgeText(
    this.text, {
    super.key,
    this.bgColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: this.bgColor,
      ),
      child: Text(
        this.text,
        style: const TextStyle(
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
