
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<Map<String, NodeData>> loadNodeData() async {
  final jsonString = await rootBundle.loadString('assets/nodes.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return jsonMap.map((key, value) {
    return MapEntry(key, NodeData.fromJson(value));
  });
}

enum ParamType { int, double, string, bool, list, dict }

ParamType parseParamType(String type) {
  switch (type) {
    case "int":
      return ParamType.int;
    case "double":
      return ParamType.double;
    case "string":
      return ParamType.string;
    case "bool":
      return ParamType.bool;
    case "list":
      return ParamType.list;
    case "dict":
      return ParamType.dict;
    default:
      throw Exception("Unknown type: $type");
  }
}

class ParamInfo {
  final String name;
  final ParamType type;
  final bool required;
  final Object? defaultValue;
  final String description;

  ParamInfo({
    required this.name,
    required this.type,
    required this.required,
    required this.defaultValue,
    required this.description});

  factory ParamInfo.fromJson(Map<String, dynamic> json) {
    return ParamInfo(
      name: json['name'],
      type: parseParamType(json['type']),
      required: json['required'],
      defaultValue: json['default'],
      description: json['description']
    );
  }
}

class NodeData {
  static Map<String, NodeData> nodeDataMap = {};
  final String name;
  final String description;
  final Map<String, ParamInfo> parameters;

  NodeData({required this.name, required this.description, required this.parameters});

  factory NodeData.fromJson(Map<String, dynamic> json) {
    return NodeData(
      name: json['name'],
      description: json['description'],
      parameters: (json['parameters'] as Map<String, dynamic>).map((key, value) {
        return MapEntry(key, ParamInfo.fromJson(value));
      })
    );
  }
}
