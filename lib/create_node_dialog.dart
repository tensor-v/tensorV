import 'package:flutter/material.dart';
import 'node_data.dart';
import 'node_edit.dart';

class CreateNodeDialog extends StatefulWidget {
  final void Function(NodeData data) onConfirm;

  const CreateNodeDialog({
    super.key,
    required this.onConfirm
  });

  @override
  State<StatefulWidget> createState() => _CreateNodeDialogState();
}


class _CreateNodeDialogState extends State<CreateNodeDialog> {
  String selectedType = "Dense";
  NodeData selectedData = NodeData.nodeDataMap['Dense']!;

  @override
  Widget build(BuildContext context) {
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
              if (value != null) {
                setState(() {
                  selectedType = value;
                });
              }
            },
          ),
          SizedBox(
            height: 300,
            child: NodeEdit(
              data: selectedData,
              editable: true
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(selectedData);
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}