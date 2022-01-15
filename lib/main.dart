import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  //สร้างตัวแปร เก็บค่าที่ผู้ใช้กรอกใน textfield
  final _controller = TextEditingController(); //ชื่อตรงcontrolerจะเป็นอะไรก็ได้
  var game = Game();
  bool isCorrect = false;
  String? letguess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // เทียบได้กับแท็ก <div> ของ HTML
          decoration: BoxDecoration(
              color: Colors.deepOrange.shade200,
              border: Border.all(width: 5.0, color: Colors.deepOrange),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  offset: const Offset(2.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ]),
          //alignment: Alignment.center,
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  //สำคัญมาก คือการยืด widget ให้เต็มที่ของwidjetนั้น เอาไปใช้สอบ
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/guess_logo.png', width: 100.0),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GUESS',
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.pink.shade500),
                          ),
                          Text(
                            'THE NUMBER',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.pink.shade300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(),
                      hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      child: Text('GUESS'),
                      onPressed: () {
                        // โค้ดที่จะทำงานเมื่อกดปุ่ม
                        letguess = _controller.text;
                        var guess = int.tryParse(letguess!);
                        if (guess != null) {
                          var count = game.doGuess(guess);
                          var sum = game.guessCount;
                          if (count == 0) {
                            isCorrect = true;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Result'),
                                    content: Text(
                                        '$guess เป็นคำตอบที่ถูกต้อง เก่งมาก กล้ามาก ขอบใจ🎉\n คุณทายทั้งหมด $sum ครั้ง'),
                                  );
                                });
                            _controller.clear();
                          } else if (count == 1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Result'),
                                    content: Text('$guess มากกว่าคำตอบ'),
                                  );
                                });
                            _controller.clear();
                          } else if(count == -1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Result'),
                                    content: Text('$guess น้อยกว่าคำตอบ'),
                                  );
                                });
                            _controller.clear();
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Alert!'),
                                  content: Text('โปรดกรอกตัวเลขเท่านั้น!!!'),
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
