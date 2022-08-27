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
  String myAcchi = '';

  /// コンピューターの手を保持する変数
  String computerHand = '✊';
  String computerAcchi = '';

  String result = 'ー－－－';

  int resultWin = 0;
  int resultLose = 0;
  int buttleMax = 5;
  int buttleNow = 0;

  String upHand = '👆';
  String downHand = '👇';
  String leftHand = '👈';
  String rightHand = '👉';

  bool isAcchi = true;

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

    final randomAcchiNumber = Random().nextInt(3);
    computerAcchi = randomAcchi(randomAcchiNumber);
  }

  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
    } else if (myHand == "✊" && computerHand == '✌' ||
        myHand == "✌" && computerHand == '✋' ||
        myHand == "✋" && computerHand == '✊') {
      isAcchi = true;
      if (acchi() == '同じ') {
        result = 'WIN';
        resultWin++;
      } else {
        isAcchi = false;
      }
    } else {
      result = 'LOSE';
      resultLose++;
    }
    buttleNow++;
    isAcchi = false;
  }

  String acchi() {
    if (myAcchi == computerAcchi) {
      return '同じ';
    } else {
      return '違う';
    }
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

  String randomAcchi(int randomAcchi) {
    switch (randomAcchi) {
      case 0:
        return upHand;
      case 1:
        return downHand;
      case 2:
        return leftHand;
      case 3:
        return rightHand;
      default: //上記以外
        return upHand;
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
            buttleNow < buttleMax
                ? isAcchi
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              selectHand(upHand);
                            },
                            child: Text(upHand),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectHand(downHand);
                            },
                            child: Text(downHand),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectHand(leftHand);
                            },
                            child: Text(leftHand),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectHand(rightHand);
                            },
                            child: Text(rightHand),
                          ),
                        ],
                      )
                    : Container()
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
