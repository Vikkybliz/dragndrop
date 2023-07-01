import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DragnDrop(),
    );
  }
}

class DragnDrop extends StatefulWidget {
  const DragnDrop({super.key});

  @override
  State<DragnDrop> createState() => _DragnDropState();
}

class _DragnDropState extends State<DragnDrop> {
  final params = {'flutter': 'Dart', 'Bootstrap': 'CSS', 'Django': 'Python'};
  bool isDropped = false;
  final Map<String, bool> score = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: params.keys
                  .map((e) => Draggable(
                      data: e,
                      child: Cont(text: e, color: Colors.red, fontSize: 20),
                      feedback: Cont(text: e, color: Colors.red, fontSize: 20)))
                  .toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: params.keys
                  .map((e) => DragTarget(
                        builder: (context, accepted, rejected) {
                          if (e == params[e]) {
                            return Cont(
                                text: 'Correct',
                                color: Colors.red,
                                fontSize: 20);
                          } else {
                            return Cont(
                                text: params[e]!,
                                color: Colors.red,
                                fontSize: 20);
                          }
                        },
                        onWillAccept: (data) {
                          return data == e;
                        },
                        onAccept: (data) {
                          setState(() {
                            score[e] == true;
                          });
                        },
                        onLeave: (data) {
                          print(data);
                          print(e);
                        },
                      ))
                  .toList(),
            )
          ],
        ));
  }
}

class Cont extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  Cont(
      {super.key,
      required this.text,
      required this.color,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
