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

  // 다이얼로그 호출 함수
  void showCreateNodeDialog() {
    String selectedType = 'Dense';
    final TextEditingController paramController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Node'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(labelText: 'Node Type'),
                items: ['Dense', 'Conv2D', 'Dropout']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  selectedType = value!;
                },
              ),
              TextField(
                controller: paramController,
                decoration: const InputDecoration(
                  labelText: 'Parameters (e.g., units=64)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 닫기
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // 나중에 이 부분에서 노드 추가 로직 넣을 수 있음
                String nodeType = selectedType;
                String params = paramController.text;

                // print("[DEBUG] Node Type: $nodeType, Params: $params");

                Navigator.of(context).pop(); // 닫기
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blueprint Editor"),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.add, color: Colors.orange),
            label: const Text("Create New Node", style: TextStyle(color: Colors.orange)),
            onPressed: showCreateNodeDialog,
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
