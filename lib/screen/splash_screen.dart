import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _size = 100.0;
  final Tween<double> _animationTween = Tween(begin: 0, end: pi * 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: _animationTween,
          duration: const Duration(seconds: 2),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: value,
              child: Container(color: Colors.blue, height: _size, width: _size),
            );
          },
        ),
      ),
    );
  }
}
