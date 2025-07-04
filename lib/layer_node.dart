import 'package:flutter/material.dart';


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