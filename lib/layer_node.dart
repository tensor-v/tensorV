import 'package:flutter/material.dart';
import 'theme/colors.dart';


class DraggableNode extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final Map<String, Object> parameters;
  final void Function(Offset delta) onDrag;

  const DraggableNode({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.parameters,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => onDrag(details.delta),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.nodeBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            // 설명
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const Divider(),
            // 파라미터 테이블
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: parameters.entries.map((entry) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}