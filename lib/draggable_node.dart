import 'package:flutter/material.dart';
import 'node_data.dart';
import 'node_edit.dart';
import 'theme/colors.dart';

class DraggableNode extends StatelessWidget {
  final void Function(Offset delta) onDrag;
  final VoidCallback onTap;
  final NodeData data;
  final Offset position;

  const DraggableNode({
    super.key,
    required this.data,
    required this.onDrag,
    required this.onTap,
    required this.position
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: position,
      child: GestureDetector(
        onPanUpdate: (details) {
          onDrag(details.delta);
        },
        onTap: onTap,
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
      ),
    );
  }
}