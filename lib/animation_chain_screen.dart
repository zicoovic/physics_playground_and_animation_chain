import 'dart:async';

import 'package:flutter/material.dart';

class AnimationChainScreen extends StatefulWidget {
  const AnimationChainScreen({super.key});

  @override
  State<AnimationChainScreen> createState() => _AnimationChainScreenState();
}

class _AnimationChainScreenState extends State<AnimationChainScreen> {
  double dot1 = .5;
  double dot2 = .5;
  double dot3 = .5;
  int counter = 0;
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  bool isStarted = false;
  void changeSize() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        if (counter == 0) {
          dot1 = 2.5;
          dot2 = 0.5;
          dot3 = 0.5;
        } else if (counter == 1) {
          dot1 = 0.5;
          dot2 = 2.5;
          dot3 = 0.5;
        } else if (counter == 2) {
          dot1 = 0.5;
          dot2 = 0.5;
          dot3 = 2.5;
        }
        counter++;
        if (counter > 2) {
          counter = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Chain')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.5, end: dot1),
                duration: const Duration(milliseconds: 500),
                builder: (_, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Circle(scale: value),
                  );
                },
              ),
              SizedBox(width: 2.5),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: dot2),
                duration: const Duration(milliseconds: 500),
                builder: (_, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Circle(scale: value),
                  );
                },
              ),
              SizedBox(width: 2.5),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: dot3),
                duration: const Duration(milliseconds: 500),
                builder: (_, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Circle(scale: value),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(isStarted ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          isStarted = !isStarted;
          if (isStarted) {
            changeSize();
          } else {
            timer.cancel();
            setState(() {
              dot1 = 0.5;
              dot2 = 0.5;
              dot3 = 0.5;
              counter = 0;
            });
          }
        },
        label: Text(isStarted ? 'Pause' : 'Play'),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double scale;
  const Circle({super.key, this.scale = 0.5});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scale > 1
              ? Colors.blueAccent
              : Colors.blueAccent.withOpacity(0.5),
          boxShadow: const [
            // BoxShadow(
            //   // color: Colors.black,
            //   blurRadius: 17,
            //   spreadRadius: 5,
            //   offset: Offset(0, 3),
            // ),
          ],
        ),
      ),
    );
  }
}
