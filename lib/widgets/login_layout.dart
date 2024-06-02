import 'package:dadascanner/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginLayout extends StatelessWidget {
  final Widget child;

  const LoginLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: [
          _LoginBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _LoginHeaderIcon(),
                  const SizedBox(height: 20),
                  this.child,
                ],
                        ),
            ))
        ],
      ),
    );
  }
}

class _LoginHeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 100),
      child:
          const Icon(Icons.person_pin_rounded, size: 80, color: Colors.white),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.4,
          color: AppColors.primary,
        ),
        Positioned(top: 70, left: 40, child: _Bubble()),
        Positioned(left: 10, bottom: 20, child: _Bubble()),
        Positioned(right: 100, top: 30, child: _Bubble()),
        Positioned(right: 240, top: 160, child: _Bubble()),
        Positioned(right: 20, bottom: -20, child: _Bubble()),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(200))),
    );
  }
}
