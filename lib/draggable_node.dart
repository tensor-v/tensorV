import 'package:flutter/material.dart';
import 'node_data.dart';
import 'node_edit.dart';
import 'theme/colors.dart';

class DraggableNode extends StatelessWidget {
  final void Function(Offset delta) onDrag;
  final NodeData data;
  Offset position;

  DraggableNode({
    super.key,
    required this.data,
    required this.onDrag,
    required this.position
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        position += details.delta;
        onDrag(details.delta);
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.nodeBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
        ),
        child: NodeEdit(
          data: data,
          editable: false,
        ),
      ),
    );
  }
}