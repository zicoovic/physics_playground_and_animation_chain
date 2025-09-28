import 'dart:async';

import 'package:flutter/material.dart';

class AnimationChainScreen extends StatefulWidget {
  const AnimationChainScreen({super.key});

  @override
  State<AnimationChainScreen> createState() => _AnimationChainScreenState();
}

class _AnimationChainScreenState extends State<AnimationChainScreen> {
  double dot1 = 1;
  double dot2 = 1;
  double dot3 = 1;
  int counter = 0;
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  bool isStarted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Chain')),
      body: Center(
        child: Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: dot1),
              duration: const Duration(milliseconds: 500),
              builder: (_, value, child) {
                return Transform.scale(scale: value, child: child);
              },
            ),
          ],
        ),
      ),
    );
  }
}
