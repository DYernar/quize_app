import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/countries/bloc/game_bloc.dart';
import 'package:quiz_app/countries/home_page.dart';

import 'bloc/game_state.dart';

class QuizResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200.0,
          ),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  'GAME',
                  style: TextStyle(
                    fontSize: 55.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'QUIZ',
                  style: TextStyle(
                    fontSize: 55.0,
                    color: Color.fromRGBO(150, 30, 40, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Card(
            elevation: 5.0,
            child: Container(
              height: 150.0,
              width: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Game Over!',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Your Score: ',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder(
                          bloc: BlocProvider.of<GameBloc>(context),
                          builder: (BuildContext context, GameState state) {
                            return Text(
                              '${state.score}',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                elevation: 5.0,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Icon(
                    Icons.share,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(
                      Icons.rotate_left,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
