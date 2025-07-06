import 'package:flutter/material.dart';
import 'canvas_page.dart';
import 'node_data.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    NodeData.nodeDataMap = await loadNodeData();
  } catch (e, stack) {
    print("❌ Failed to load node data: $e");
    print(stack);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TensorV Demo',
      home: CanvasPage()
    );
  }
}

