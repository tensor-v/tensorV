import 'package:flutter/material.dart';


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
                onDrag: (delta) => updateNodePosition(entry.key, delta),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DraggableNode extends StatelessWidget {
  final String id;
  final String title;
  final void Function(Offset delta) onDrag;

  const DraggableNode({
    super.key,
    required this.id,
    required this.title,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => onDrag(details.delta),
      child: Container(
        width: 120,
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.teal.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
