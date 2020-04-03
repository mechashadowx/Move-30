import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dx = [1, -1, 0, 0];
  final dy = [0, 0, 1, -1];
  List<List<bool>> isFree;
  List<List<int>> value;
  String status;

  @override
  void initState() {
    super.initState();
    isFree = List.generate(5, (i) {
      return List.generate(5, (j) {
        return false;
      });
    });
    value = List.generate(5, (i) {
      return List.generate(5, (j) {
        return 0;
      });
    });
    List<int> helpIsRandom = List();
    for (int i = 0; i < 8; i++) {
      helpIsRandom.add(i + 1);
    }
    for (int i = 1; i <= 3; i++) {
      for (int j = 1; j <= 3; j++) {
        if (i != 2 || j != 2) {
          int rand = Random().nextInt(helpIsRandom.length);
          value[i][j] = helpIsRandom[rand];
          helpIsRandom.removeAt(rand);
        }
      }
    }
    isFree[2][2] = true;
    status = 'SOLVE';
  }

  check() {
    bool res = true;
    for (int i = 1; i <= 3; i++) {
      for (int j = 1; j <= 3; j++) {
        if (i != 3 || j != 3) {
          if (value[i][j] != 3 * (i - 1) + j) {
            res = false;
            break;
          }
        }
      }
    }
    setState(() {
      if (res) {
        status = 'YOU WON';
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size.width * 0.25;
    final margin = data.size.width * 0.025;

    return Scaffold(
      backgroundColor: Color(0xFF353A40),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                status,
                style: TextStyle(
                  color: Color(0xFFD6E1EF),
                  fontSize: data.size.width * 0.1,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(3, (j) {
                      int val = value[i + 1][j + 1];
                      if (isFree[i + 1][j + 1]) {
                        return Container(
                          height: size,
                          width: size,
                          margin: EdgeInsets.all(margin),
                          color: Color(0xFF353A40),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          for (int d = 0; d < dx.length; d++) {
                            if (isFree[i + 1 + dx[d]][j + 1 + dy[d]]) {
                              setState(() {
                                int temp = value[i + 1 + dx[d]][j + 1 + dy[d]];
                                value[i + 1 + dx[d]][j + 1 + dy[d]] =
                                    value[i + 1][j + 1];
                                value[i + 1][j + 1] = temp;
                                isFree[i + 1 + dx[d]][j + 1 + dy[d]] = false;
                                isFree[i + 1][j + 1] = true;
                              });
                              break;
                            }
                          }
                          check();
                        },
                        child: Container(
                          height: size,
                          width: size,
                          margin: EdgeInsets.all(margin),
                          decoration: BoxDecoration(
                            color: Color(0xFF353A40),
                            borderRadius: BorderRadius.circular(
                              size * 0.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF3F454B),
                                offset: Offset(-5, -5),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                              BoxShadow(
                                color: Color(0xFF292E33),
                                offset: Offset(5, 5),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              val.toString(),
                              style: TextStyle(
                                color: Color(0xFFD6E1EF),
                                fontSize: data.size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
