import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game_panel.dart';

class players_info extends StatefulWidget{
  @override
  _players_info_State createState() => _players_info_State();
}

class _players_info_State extends State<players_info> {
  TextEditingController player1_controller = TextEditingController();
  TextEditingController player2_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.lightGreen,
        title: const Text('Players Panel', style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black),),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(10),
            child: TextField(
              controller: player1_controller,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.grey,),
                  suffixIcon:Padding(padding: EdgeInsets.only(right: 10),child:Icon(Icons.circle , size: 45, color: Colors.blue,)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                  ),
                  labelText: 'Player 1',
                  hintText: 'Enter the name',
                ),
              ),
            ),
              IconButton(
                onPressed: () {switch_names();},
                icon: Icon(Icons.compare_arrows_rounded , size: 40,),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: player2_controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.grey,),
                    suffixIcon: Padding(padding: EdgeInsets.only(right: 10),child:Icon(Icons.circle , size: 45, color: Colors.red,)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)
                    ),
                    labelText: 'Player 2',
                    hintText: 'Enter the name',
                  ),
                ),
              ),
            Divider(
              color: Colors.black,
            ),
            const Center(
              child: Text(
                'Heros List',
                style: TextStyle(fontFamily: 'Ariel' , fontWeight: FontWeight.w300 , fontSize: 30),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(320,350,10 , 0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.lightGreen,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => game_panel(
                        name1: player1_controller.text,
                        name2: player2_controller.text,
                      )));
                    },
                    child: const Icon(Icons.arrow_right_alt_rounded, size: 50, ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  switch_names() {
    String temp_name = player1_controller.text;
    player1_controller.text = player2_controller.text;
    player2_controller.text = temp_name;
  }
}