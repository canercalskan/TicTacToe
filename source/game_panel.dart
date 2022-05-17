import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/home.dart';
import 'package:tictactoe/players_info.dart';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
  static int score = 0;
}

class Game {
  static final boardlength = 9;
  static final blocSize = 100.0;

  List<String>? board;
  static List<String>? initGameBoard() => List.generate(boardlength, (index) => Player.empty);

  bool winnerCheck(String player, int index, List<int> scoreboard, int gridSize) {
    int row = index~/ 3;
    int col = index % 3;
    int score = player == "X"?1:-1;
    scoreboard[row]+=score;
    scoreboard[gridSize + col] += score;
    if(row == col) {
      scoreboard[2*gridSize] += score;
    }
    if(gridSize -1 -col == row) {
      scoreboard[2*gridSize+1] += score;
    }
    if(scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    return false;
  }
}



class game_panel extends StatefulWidget{
  final String name1, name2;
  String turn = "";
  int round = 1;
  //String turn = name1;
  game_panel ({Key? key, required this.name1 , required this.name2}): super(key:key);

  @override
  _game_panel_State createState() => _game_panel_State();
}

class _game_panel_State extends State<game_panel> {
  String lastValue = "X";
  int player1_score = 0;
  int player2_score = 0;
  bool gameOver = false;
  List<int> scoreboard = [0,0,0,0,0,0,0,0];
  int turn = 0;
  String result = "";
  Game game = Game();
  @override
  void initState() {

    super.initState();
    widget.turn = widget.name1 + " (X)";
    game.board = Game.initGameBoard();

  }
  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Panel'),
        centerTitle: false,
        backgroundColor: Colors.lightGreen,
      ),
      body:  Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Center( child: Text(widget.name1 + ' Score : ' + player1_score.toString(), style: TextStyle(color: Colors.blue , fontSize: 25), ),),
            Center( child: Text(widget.name2 + ' Score : ' + player2_score.toString(), style: TextStyle(color: Colors.red , fontSize: 25), ),),
            Divider(
              color: Colors.black,
            ),
            Center(
              child: Text('Round : ' + widget.round.toString()  , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
           Align(
             alignment: Alignment.topLeft,
             child:  Text('Turn : ' + widget.turn , style: TextStyle(fontSize: 20),),
           ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  width: boardWidth - 50,
                  height: boardWidth,
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: EdgeInsets.all(15.0),
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    children:
                    List.generate(Game.boardlength, (index) {
                      return InkWell(
                        onTap: gameOver?null:() {
                          if(game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                              if(gameOver) {
                                result = "$lastValue is the winner!";
                                if(lastValue == "X") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: new Text('Congratilations!!'),
                                        content: new Text(widget.name1 + ' is the winner.(+3 points)'),
                                        actions: <Widget>[
                                          TextButton(
                                          onPressed: () {
                                            widget.round++;
                                            setState(() {
                                              game.board = Game.initGameBoard();
                                              lastValue = "X";
                                              gameOver = false;
                                              turn = 0;
                                              result = "";
                                              scoreboard = [0,0,0,0,0,0,0,0];
                                            });
                                            Navigator.pop(context);
                                          },
                                            child: Text('OK'),
                                          )
                                        ],
                                      ));
                                  player1_score+=3;
                                }
                                else if(lastValue == "O") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: new Text('Congratilations!!'),
                                        content: new Text(widget.name2 + ' is the winner.(+3 points)'),
                                        actions: <Widget>[
                                          TextButton(
                                          onPressed: () {
                                            widget.round++;
                                            setState(() {
                                              game.board = Game.initGameBoard();
                                              lastValue = "X";
                                              gameOver = false;
                                              turn = 0;
                                              result = "";
                                              scoreboard = [0,0,0,0,0,0,0,0];
                                            });
                                            Navigator.pop(context);
                                        },
                                            child: Text('OK'),
                                          )
                                        ],
                                      ));
                                  player2_score+=3;
                                }
                              }
                              else if(!gameOver && turn == 9) {
                                result = "Draw!";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: new Text('Draw!!!'),
                                      content: new Text('1 points added to both players.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            widget.round++;
                                            setState(() {
                                              game.board = Game.initGameBoard();
                                              lastValue = "X";
                                              gameOver = false;
                                              turn = 0;
                                              result = "";
                                              scoreboard = [0,0,0,0,0,0,0,0];
                                            });
                                            Navigator.pop(context);
                                            },
                                          child: Text('OK'),
                                        )
                                      ],
                                    ));
                                player1_score++;
                                player2_score++;
                                gameOver = true;

                              }
                              if(widget.turn == "") {
                                widget.turn = widget.name1 + " (X)";
                              }
                              if(lastValue == "X") {
                                widget.turn = widget.name2 + " (O)";
                                lastValue = "O";
                              }
                              else {
                                widget.turn = widget.name1 + " (X)";
                                lastValue = "X";
                              }
                            });
                          }
                        },
                        child:Container(
                          width: Game.blocSize,
                          height: Game.blocSize,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 2.0),
                          ),
                          child:Center(
                            child: Text(
                              game.board![index],
                              style: TextStyle(
                                color: game.board![index] == "X"? Colors.blue:Colors.red,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
                    onPressed: () {
                      setState(() {
                        game.board = Game.initGameBoard();
                        lastValue = "X";
                        gameOver = false;
                        turn = 0;
                        result = "";
                        scoreboard = [0,0,0,0,0,0,0,0];
                        player1_score = 0;
                        player2_score = 0;
                        widget.round = 1;
                      });
                    },
                    child:Padding(
                      padding: EdgeInsets.all(2),
                      child: Text('RESET' , style: TextStyle(color: Colors.black , fontSize: 25),),
                    ),
                  ),
                ),
                 Align(
                  alignment: Alignment.bottomRight,
                  child:Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: new Text('Quit'),
                                content: new Text('Are you sure to exit?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                      },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              ));
                        },
                        child:Padding(
                          padding: EdgeInsets.fromLTRB(18, 3, 18, 3),
                          child: Text('EXIT' , style: TextStyle(color: Colors.black , fontSize: 25),),
                        ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

/*
_buildElement(int i, int j) {
return GestureDetector(
  onTap: (){
    print('123');
  },
  child:Container(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(
        color: Colors.black,
      ),
    ),
    child:Padding(padding: EdgeInsets.all(40),child:Text('x' , style: TextStyle(fontSize: 60),),),
  )

);
}
*/
