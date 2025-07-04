import 'package:flutter/material.dart';

class NodeEditDialog extends StatefulWidget {
  final String initialType;
  final String initialParams;
  final void Function(String type, String params) onConfirm;

  const NodeEditDialog({
    super.key,
    required this.initialType,
    required this.initialParams,
    required this.onConfirm,
  });

  @override
  State<NodeEditDialog> createState() => _NodeEditDialogState();
}

class _NodeEditDialogState extends State<NodeEditDialog> {
  late String selectedType;
  late TextEditingController paramController;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType;
    paramController = TextEditingController(text: widget.initialParams);
  }

  @override
  void dispose() {
    paramController.dispose();
    super.dispose();
  }

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
          const SizedBox(height: 10),
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
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onConfirm(selectedType, paramController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
