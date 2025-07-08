
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:equatable/equatable.dart'; // 동일성 비교를 위한 패키지
import 'package:uuid/uuid.dart'; // 고유 ID 생성을 위한 패키지

Future<Map<String, NodeData>> loadNodeData() async {
  final jsonString = await rootBundle.loadString('assets/nodes.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return jsonMap.map((key, value) {
    return MapEntry(key, NodeData.fromJson(value));
  });
}

enum ParamType { int, double, string, bool, options }

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
    case "options":
      return ParamType.options;
    default:
      throw Exception("Unknown type: $type");
  }
}

class ParamInfo {
  final String name;
  final ParamType type;
  final bool required;
  final String description;
  final List<Object?>? options;
  final Object? defaultValue;
  Object? value;

  ParamInfo({
    required this.name,
    required this.type,
    required this.required,
    required this.description,
    this.options,
    this.defaultValue
  });

  factory ParamInfo.fromJson(Map<String, dynamic> json) {
    return ParamInfo(
      name: json['name'],
      type: parseParamType(json['type']),
      required: json['required'],
      description: json['description'],
      options: json['options'],
      defaultValue: json['defaultValue']
    );
  }
}

class NodeData extends Equatable {
  static Map<String, NodeData> nodeDataMap = {};
  final Uuid id = Uuid();
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

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  NodeData copy() => NodeData(
    name: name,
    description: description,
    parameters: parameters
  );
}
