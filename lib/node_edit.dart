import 'package:flutter/material.dart';
import 'node_data.dart';

class NodeEdit extends StatefulWidget {
  final NodeData data;
  final bool editable;

  const NodeEdit({
    super.key,
    required this.data,
    required this.editable
  });

  @override
  State<NodeEdit> createState() => _NodeEditState();
}

class _NodeEditState extends State<NodeEdit> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.editable ?
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Node Name'),
          ):
          Text(
            widget.data.name
          ),
        const SizedBox(height: 16),
        Text(
          widget.data.description
        )
      ],
    );
  }
}
