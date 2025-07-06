import 'package:flutter/material.dart';
import 'draggable_node.dart';
import 'create_node_dialog.dart';
import 'theme/colors.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  final Set<DraggableNode> nodes = {};
  String selectedType = "Dense";

  // 다이얼로그 호출 함수
  void showCreateNodeDialog() {
    showDialog(
      context: context,
      builder: (_) => CreateNodeDialog(
        onConfirm: (data) => {
          setState(() {
            nodes.add(DraggableNode(
              data: data,
              onDrag: (delta) => {
                setState(() {})
              },
              position: Offset(100, 200)
            ));
          })
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: const Text(
          "Keras V",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.add, color: AppColors.textSecondary),
            label: const Text("Create New Node", style: TextStyle(color: AppColors.textSecondary)),
            onPressed: showCreateNodeDialog,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(1000),
        minScale: 0.1,
        maxScale: 5.0,
        child: Stack(
          children: nodes.map((entry) {
            return Positioned(
              left: entry.position.dx,
              top: entry.position.dy,
              child: entry
            );
          }).toList(),
        ),
      ),
    );
  }
}
