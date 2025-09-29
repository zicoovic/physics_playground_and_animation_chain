import 'package:flutter/material.dart';
import 'package:physics_playground_app/animation_chain_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Set<String> completed = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Physics Playground'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDraggable('red', Colors.red),
                  _buildDraggable('green', Colors.green),
                  _buildDraggable('blue', Colors.blue),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTarget('red', Colors.red),
                  _buildTarget('green', Colors.green),
                  _buildTarget('blue', Colors.blue),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => setState(() => completed.clear()),
                icon: Icon(Icons.refresh),
                label: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              Builder(
                builder: (context) {
                  return OutlinedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimationChainScreen(),
                      ),
                    ),
                    icon: Icon(Icons.arrow_forward),
                    label: Text("Go to Animation Chain"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: BorderSide(color: Colors.deepPurple, width: 2),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggable(String data, Color color) {
    return Draggable<String>(
      data: data,
      feedback: _circle(color.withOpacity(0.7)),
      childWhenDragging: _circle(color.withOpacity(0.3)),
      child: _circle(color),
    );
  }

  Widget _buildTarget(String acceptedData, Color color) {
    bool isCompleted = completed.contains(acceptedData);

    return DragTarget<String>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (data) {
        if (data.data == acceptedData) {
          setState(() {
            completed.add(acceptedData);
          });
        }
      },
      builder: (context, candidateItems, rejectedItems) {
        bool isHovering = candidateItems.isNotEmpty;
        bool isCorrect = isHovering && candidateItems.first == acceptedData;
        bool isWrong = isHovering && candidateItems.first != acceptedData;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isWrong ? Colors.red : color,
              width: isHovering ? 8 : 5,
            ),
            color: isCompleted
                ? color
                : isWrong
                ? Colors.red.withOpacity(0.3)
                : isCorrect
                ? color
                : color.withOpacity(0.3),
          ),
          child: Icon(
            isCompleted
                ? Icons.done
                : isWrong
                ? Icons.close
                : isCorrect
                ? Icons.done
                : Icons.crop_square,
            color: isCompleted
                ? Colors.white
                : isWrong
                ? Colors.red
                : isCorrect
                ? Colors.white
                : Colors.transparent,
            size: 30,
          ),
        );
      },
    );
  }

  Widget _circle(Color color) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
