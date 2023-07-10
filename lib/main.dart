import 'package:dragndrop/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<LangFrame> list1;
  late List<LangFrame> list2;
  int score = 0;

  initGame() {
    list1 = [
      LangFrame(
        language: 'Dart',
        framework: 'Flutter',
      ),
      LangFrame(
        language: 'Python',
        framework: 'Django',
      ),
      LangFrame(
        language: 'JavaScript',
        framework: 'React',
      ),
      LangFrame(
        language: 'PHP',
        framework: 'Laravel',
      ),
      LangFrame(
        language: 'Java',
        framework: 'Springboot',
      )
    ];
    list2 = List.from(list1);
    list1.shuffle();
    list2.shuffle();
  }

  @override
  void initState() {
    initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Game, Score = $score'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxis,
            children: [
              Column(
                children: list1
                    .map((item) => Container(
                          margin: const EdgeInsets.all(10),
                          child: Draggable(
                              data: item,
                              feedback: Material(
                                  child: _buildContainer(
                                      item.framework, Colors.blueGrey)),
                              child:
                                  _buildContainer(item.framework, Colors.blue)),
                        ))
                    .toList(),
              ),
              // Spacer(),
              Column(
                children: list2
                    .map((item2) => Container(
                          margin: const EdgeInsets.all(10),
                          child: DragTarget<LangFrame>(
                            onWillAccept: (data) => true,
                            onAccept: (data) {
                              if (item2.language == data.language) {
                                setState(() {
                                  list1.remove(data);
                                  list2.remove(item2);
                                  score += 10;
                                });
                              } else {
                                setState(() {
                                  score -= 5;
                                });
                              }
                            },
                            builder: (BuildContext context,
                                List<Object?> candidateData,
                                List<dynamic> rejectedData) {
                              return _buildContainer(
                                  item2.language, Colors.red);
                            },
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    initGame();
                    score = 0;
                  });
                },
                child: const Text('Restart Game')),
          )
        ],
      ),
    );
  }
}

Widget _buildContainer(text, color) {
  return Container(
    width: 100,
    height: 60,
    color: color,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}
