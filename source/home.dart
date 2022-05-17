import 'package:flutter/material.dart';
import 'package:tictactoe/players_info.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to TTT' , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
        centerTitle: false,
        backgroundColor: Colors.lightGreen
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Column(
           children : <Widget>[
          Stack(
          alignment: Alignment.center,
          children: <Widget>[
           Expanded(
             child: Image.asset('images/background.jpeg' , height: 450, width: 425,),
            ),
          Expanded(
             child: Image.asset('images/words.jpeg' , width: 150, height: 100,),
          ),
           ]
          ),
           Row(
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(top: 180),
                   child: TextButton(
                       onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => players_info()));
                       },
                       child: Text('Continue >>' ,
                         style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40, color: Colors.green),))
               )
             ],
           )
            ],
          ),
        ]
      )
      );
  }

}

