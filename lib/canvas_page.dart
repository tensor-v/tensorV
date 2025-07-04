import 'package:flutter/material.dart';
import 'layer_node.dart';


class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  final Map<String, Offset> nodePositions = {
    'input': const Offset(100, 100),
    'dense': const Offset(300, 200),
  };

  void updateNodePosition(String id, Offset delta) {
    setState(() {
      nodePositions[id] = nodePositions[id]! + delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blueprint Editor")),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(1000),
        minScale: 0.1,
        maxScale: 5.0,
        child: Stack(
          children: nodePositions.entries.map((entry) {
            return Positioned(
              left: entry.value.dx,
              top: entry.value.dy,
              child: DraggableNode(
                id: entry.key,
                title: "${entry.key} Node",
                description: "description",
                parameters: {
                  "units": 64,
                  "activation": "relu",
                },
                onDrag: (delta) => updateNodePosition(entry.key, delta),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


