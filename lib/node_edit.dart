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
  late Map<String, TextEditingController> _paramControllers;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.data.name);

    _paramControllers = {
      for (final entry in widget.data.parameters.entries)
        entry.key: TextEditingController(text: entry.value.defaultValue.toString() ?? "")
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _paramControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.editable
              ? TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Node Name'),
          )
              : Text(widget.data.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(widget.data.description, style: const TextStyle(color: Colors.grey)),

          const Divider(height: 32),

          ...widget.data.parameters.entries.map((entry) {
            final param = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _paramControllers[param.name],
                  decoration: InputDecoration(
                    labelText: param.name,
                    helperText: param.description,
                    suffixText: param.required ? '*' : null,
                  ),
                  keyboardType: _getKeyboardType(param.type),
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType(ParamType type) {
    switch (type) {
      case ParamType.int:
      case ParamType.double:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}

