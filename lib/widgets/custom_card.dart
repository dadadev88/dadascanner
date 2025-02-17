import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double padding;
  final Widget child;
  final double borderRadius;
  final double screenWidth;

  const CustomCard({
    super.key,
    this.padding = 15,
    this.borderRadius = 15,
    required this.child,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.screenWidth > 500 ? screenWidth * .7 : double.infinity,
      decoration: _getCardDecoration(),
      child: Padding(
        padding: EdgeInsets.all(this.padding),
        child: this.child,
      ),
    );
  }

  BoxDecoration _getCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
    );
  }
}
