import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const JunkenPage(),
    );
  }
}

class JunkenPage extends StatefulWidget {
  const JunkenPage({Key? key}) : super(key: key);

  @override
  State<JunkenPage> createState() => _JunkenPageState();
}

class _JunkenPageState extends State<JunkenPage> {
  String myHand = "✌";

  /// コンピューターの手を保持する変数
  String computerHand = '✊';

  String result = 'ー－－－';

  int resultWin = 0;
  int resultLose = 0;
  int buttleMax = 5;
  int buttleNow = 0;

  void selectHand(String selectedHund) {
    myHand = selectedHund;
    print(myHand);
    generateComputerHand();
    judge();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    //
    computerHand = randomNumberToHand(randomNumber);
  }

  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
    } else if (myHand == "✊" && computerHand == '✌' ||
        myHand == "✌" && computerHand == '✋' ||
        myHand == "✋" && computerHand == '✊') {
      result = 'WIN';
      resultWin++;
    } else {
      result = 'LOSE';
      resultLose++;
    }
    buttleNow++;
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌';
      case 2:
        return '✋';
      default: //上記以外
        return '✊';
      //return が実行されると、それより後に書かれたコードは実行されないことに注意してください。
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$buttleNow 戦目 ",
                  style: TextStyle(
                    fontSize: 20, // 文字サイズを大きくしたい
                  ),
                ),
                Text(
                  "勝ち $resultWin",
                  style: TextStyle(
                    fontSize: 20, // 文字サイズを大きくしたい
                  ),
                ),
                Text(
                  "負け $resultLose",
                  style: TextStyle(
                    fontSize: 20, // 文字サイズを大きくしたい
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              result,
              style: TextStyle(
                fontSize: 32, // 文字サイズを大きくしたい
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              computerHand,
              style: TextStyle(
                fontSize: 32, // 文字サイズを大きくしたい
              ),
            ),
            Text(
              'VS',
              style: TextStyle(
                fontSize: 32, // 文字サイズを大きくしたい
              ),
            ),
            Text(
              myHand,
              style: TextStyle(
                fontSize: 32, // 文字サイズを大きくしたい
              ),
            ),
            buttleNow < buttleMax
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          selectHand('✊');
                        },
                        child: Text('✊'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          selectHand('✌');
                        },
                        child: Text('✌'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          selectHand('✋');
                        },
                        child: Text('✋'),
                      ),
                    ],
                  )
                : Container(),
            buttleNow == buttleMax
                ? Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: resultWin > resultLose
                                    ? Colors.amber
                                    : Colors.blue,
                                width: 5,
                              )),
                          child: Center(
                              child: Text(
                                  resultWin > resultLose ? "WIN" : "LOSE")),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            resultWin = 0;
                            resultLose = 0;
                            buttleNow = 0;
                            result = '----';
                            setState(() {});
                          },
                          child: Text('もう1回')),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
