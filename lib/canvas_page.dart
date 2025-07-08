// canvas_page.dart
import 'package:flutter/material.dart';
import 'draggable_node.dart';
import 'create_node_dialog.dart'; // CreateNodeDialog가 정의된 파일 경로를 확인해주세요.
import 'theme/colors.dart'; // AppColors가 정의된 파일 경로를 확인해주세요.
import 'node_data.dart'; // NodeData가 정의된 파일 경로를 확인해주세요.

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  // 노드들을 List로 관리하여 순서 제어가 가능하도록 합니다.
  final List<DraggableNode> nodes = [];

  // 다이얼로그를 표시하고 새로운 노드를 생성하는 함수
  void showCreateNodeDialog() {
    showDialog(
        context: context,
        builder: (_) => CreateNodeDialog(
            onConfirm: (data) {
              setState(() {
                final newNode = DraggableNode(
                  data: data,
                  onDrag: (delta) {
                    // DraggableNode 내부에서 position이 업데이트되므로, setState를 호출하여 UI를 갱신합니다.
                    setState(() {});
                  },
                  // ⭐ 중요: 노드가 탭되었을 때 bringNodeToFront 함수를 호출하도록 연결합니다.
                  onTap: () {
                    bringNodeToFront(data);
                  },
                  position: const Offset(100, 200), // 새로 생성될 노드의 초기 위치
                );
                nodes.add(newNode); // 새로운 노드를 리스트에 추가합니다.
              });
            }
        )
    );
  }

  // 특정 노드를 맨 앞으로 가져오는 함수
  void bringNodeToFront(NodeData nodeData) {
    setState(() {
      // 탭된 노드를 찾습니다.
      final tappedNodeIndex = nodes.indexWhere((node) => node.data == nodeData);
      print(tappedNodeIndex);
      if (tappedNodeIndex != -1) {
        final tappedNode = nodes[tappedNodeIndex];
        // 리스트에서 해당 노드를 제거합니다.
        nodes.removeAt(tappedNodeIndex);
        // 리스트의 맨 끝에 다시 추가합니다. Stack은 나중에 추가된 위젯을 더 위에 렌더링합니다.
        nodes.add(tappedNode);
      }
    });
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 버튼 오른쪽에 패딩 추가
            child: TextButton.icon(
              icon: const Icon(Icons.add, color: AppColors.textSecondary),
              label: const Text("Create New Node", style: TextStyle(color: AppColors.textSecondary)),
              onPressed: showCreateNodeDialog, // 노드 생성 다이얼로그 호출
              style: TextButton.styleFrom(
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(1000), // 뷰포트 이동 가능한 여백
        minScale: 0.1, // 최소 확대 배율
        maxScale: 5.0, // 최대 확대 배율
        child: Stack(
          children: nodes.map((node) {
            return Positioned(
              left: node.position.dx,
              top: node.position.dy,
              child: node, // DraggableNode 위젯을 Positioned 위젯의 자식으로 배치
            );
          }).toList(), // List<DraggableNode>를 List<Widget>으로 변환
        ),
      ),
    );
  }
}