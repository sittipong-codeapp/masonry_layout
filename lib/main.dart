import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const s = 3;
  static const m = 4;
  static const l = 5;

  double get displayWidth => MediaQuery.of(context).size.width;
  double get baseHeight {
    const horizontalSpacing = 20 * 2;
    const itemSpacing = 16;
    const spacing = itemSpacing + horizontalSpacing;
    final columnWidth = (displayWidth - spacing) / 2;

    return columnWidth / s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MasonryGridView.count(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemBuilder: (context, index) {
          int itemSize(int index) {
            switch (index) {
              case 0:
                return l;
              case 1:
                return m;
              case 2:
                return s;
              default:
                if (index % 3 == 0) {
                  return l;
                } else if ((((index - 3) % 12) ~/ 3) % 2 == 0) {
                  return m;
                } else {
                  return s;
                }
            }
          }

          String sizeLabel(int size) {
            switch (size) {
              case s:
                return 'S';
              case m:
                return 'M';
              case l:
                return 'L';
              default:
                return 'UNDEFINED';
            }
          }

          double itemHeight(int index) => itemSize(index) * baseHeight;

          return Container(
            decoration: const BoxDecoration(color: Colors.amber),
            height: itemHeight(index),
            child: Center(
              child: Text(
                '$index\n${sizeLabel(itemSize(index))}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
