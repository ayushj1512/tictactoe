import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: TicTacToe());
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();

  static var customfont = GoogleFonts.coiny(
      textStyle:
          const TextStyle(fontSize: 28, letterSpacing: 2, color: Colors.white));
}

class _TicTacToeState extends State<TicTacToe> {
  bool oTurn = true;

  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchedIndexex = [];
  String result = "";
  int attempts = 0;
  bool winnerfound = false;
  int seconds = maxseconds;
  static const maxseconds = 30;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stoptimer();
        }
      });
    });
  }

  void stoptimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxseconds;
  }

  int oscore = 0;
  int xscore = 0;
  int filledboxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            " Player O ",
                            style: TicTacToe.customfont,
                          ),
                          Text(
                            oscore.toString(),
                            style: TicTacToe.customfont,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            " Player X ",
                            style: TicTacToe.customfont,
                          ),
                          Text(
                            xscore.toString(),
                            style: TicTacToe.customfont,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            border: Border.all(width: 5, color: Colors.white),
                            color: matchedIndexex.contains(index)
                                ? Colors.limeAccent
                                : Colors.grey),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 64,
                                    color: Colors.tealAccent[400])),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      result,
                      style: GoogleFonts.coiny(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    builtTimer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning == true) {
      setState(() {
        if (oTurn && displayXO[index] == "") {
          displayXO[index] = 'O';
          filledboxes++;
          print("filledboxes ")
        } else if (!oTurn && displayXO[index] == "") {
          displayXO[index] = "X";
          filledboxes++;
        }

        oTurn = !oTurn;
        _checkwinner();
      });
    }
  }

  void _checkwinner() {
    //check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      setState(() {
        result = ' Player ${displayXO[0]} wins!';
        matchedIndexex.addAll([0, 1, 2]);
        stoptimer();
        _updatescore(displayXO[0]);
      });
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      setState(() {
        result = ' Player ${displayXO[3]} wins!';
        matchedIndexex.addAll([3, 4, 5]);
        stoptimer();
        _updatescore(displayXO[3]);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      setState(() {
        result = ' Player ${displayXO[6]} wins!';
        matchedIndexex.addAll([6, 7, 8]);
        stoptimer();
        _updatescore(displayXO[6]);
      });
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      setState(() {
        result = ' Player ${displayXO[0]} wins!';
        matchedIndexex.addAll([0, 3, 6]);
        stoptimer();
        _updatescore(displayXO[0]);
      });
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      setState(() {
        result = ' Player ${displayXO[1]} wins!';
        matchedIndexex.addAll([1, 4, 7]);
        stoptimer();
        _updatescore(displayXO[1]);
      });
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      setState(() {
        result = ' Player ${displayXO[2]} wins!';
        matchedIndexex.addAll([2, 5, 8]);
        stoptimer();
        _updatescore(displayXO[2]);
      });
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      setState(() {
        result = ' Player ${displayXO[0]} wins!';
        matchedIndexex.addAll([0, 4, 8]);
        stoptimer();
        _updatescore(displayXO[0]);
      });
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != "") {
      setState(() {
        result = ' Player ${displayXO[2]} wins!';
        matchedIndexex.addAll([2, 4, 6]);
        stoptimer();
        _updatescore(displayXO[2]);
      });
    } else if (filledboxes == 9 && !winnerfound) {
      setState(() {
        result = " NOBODY Wins!";
        timer?.cancel();
      });
    }
  }

  void _updatescore(String winner) {
    if (winner == "O") {
      oscore++;
    } else if (winner == "X") {
      xscore++;
    }
    winnerfound = true;
  }

  _cleartherows() {
    setState(() {
      matchedIndexex = [];
      print(matchedIndexex);
      displayXO = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      print(displayXO);
      result = " ";
      filledboxes = 0;
    });
  }

  Widget builtTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxseconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: Colors.blue.shade200,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.amber.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              _cleartherows();
              startTimer();
              attempts++;
            },
            child: Text(
              attempts == 0 ? " Start" : "Play Again",
              style: GoogleFonts.coiny(
                  fontSize: 35,
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.w300),
            ),
          );
  }
}
