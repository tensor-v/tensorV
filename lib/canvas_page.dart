import 'package:flutter/material.dart';
import 'layer_node.dart';
import 'node_edit.dart';
import 'theme/colors.dart';

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

  // 다이얼로그 호출 함수
  void showCreateNodeDialog() {
    String selectedType = 'Dense';
    final TextEditingController paramController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => NodeEditDialog(),
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
            color: AppColors.textPrimary, // 원하는 텍스트 색상으로 지정
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
              backgroundColor: Colors.white, // 원하는 배경색
              // 필요하면 패딩이나 모서리 둥글게 등 추가 가능
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
          children: nodePositions.entries.map((entry) {
            return Positioned(
              left: entry.value.dx,
              top: entry.value.dy,
              child: DraggableNode(
                id: entry.key,
                data: NodeData(
                  title: "${entry.key} Node",
                  description: "description",
                  parameters: {
                    "units": 64,
                    "activation": "relu",
                  }),
                onDrag: (delta) => updateNodePosition(entry.key, delta),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
