import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/countries/bloc/game_bloc.dart';
import 'package:quiz_app/countries/bloc/game_event.dart';
import 'package:quiz_app/countries/home_page.dart';
import 'package:quiz_app/countries/quiz_result.dart';
import 'package:quiz_app/countries/right_choice.dart';
import 'dart:math' as math;

import 'bloc/game_state.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Color> colors = [Colors.purple, Colors.redAccent];
  GameBloc _gameBloc;

  Color _generateRandomColor() {
    var randomColors = math.Random();
    return this.colors[randomColors.nextInt(this.colors.length)];
  }

  @override
  void initState() {
    this._gameBloc = GameBloc();
    this._gameBloc.add(GameStartedEvent());
    super.initState();
  }

  @override
  void dispose() {
    _gameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (BuildContext context) => _gameBloc,
      child: BlocBuilder(
        bloc: _gameBloc,
        builder: (BuildContext context, GameState state) {
          if (state is GameIsFinishedState) {
            return QuizResult();
          }
          return Scaffold(
            body: Column(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 350.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _generateRandomColor(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 23.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Container(
                                  height: 30.0,
                                  width: 100.0,
                                  child: BlocBuilder(
                                    bloc: _gameBloc,
                                    builder: (BuildContext context,
                                        GameState state) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Icon(
                                            Icons.flag,
                                            color: state.lives > index
                                                ? Colors.red
                                                : Colors.black,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 25.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black45,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.show_chart,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Card(
                            elevation: 15.0,
                            child: Container(
                              height: 180.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 270.0),
                                      child: BlocBuilder(
                                        bloc: _gameBloc,
                                        builder: (BuildContext context,
                                            GameState state) {
                                          return Text(
                                            'correct: ${state.score}',
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: BlocBuilder(
                                        bloc: _gameBloc,
                                        builder: (BuildContext context,
                                            GameState state) {
                                          if (state is AskingQuestionState) {
                                            return Text(
                                              '${state.question.emoji}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 90.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }

                                          if (state
                                              is ShowRightAnswerWhenCorrect) {
                                            return Text(
                                              '${state.question.emoji}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 90.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }

                                          if (state
                                              is ShowRightAnswerWhenWrong) {
                                            return Text(
                                              '${state.question.emoji}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 90.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }

                                          return Center(
                                            child: Column(
                                              children: <Widget>[
                                                CircularProgressIndicator(),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text('loading...'),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'Select the correct answer',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 350.0,
                  child: BlocBuilder(
                    bloc: _gameBloc,
                    builder: (BuildContext context, GameState state) {
                      if (state is AskingQuestionState) {
                        return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Choice(
                                context, state.question.answers[index]);
                          },
                        );
                      }

                      if (state is ShowRightAnswerWhenCorrect) {
                        return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.question.correctInd) {
                              return RightChoice(state.question.answers[index]);
                            } else {
                              return WrongChoice(
                                  state.question.answers[index], false);
                            }
                          },
                        );
                      }

                      if (state is ShowRightAnswerWhenWrong) {
                        return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.question.correctInd) {
                              return RightChoice(state.question.answers[index]);
                            } else {
                              if (index == state.userSelected) {
                                return WrongChoice(
                                    state.question.answers[index], true);
                              } else {
                                return WrongChoice(
                                    state.question.answers[index], false);
                              }
                            }
                          },
                        );
                      }

                      return Container();
                    },
                  ),
                ),
                BlocBuilder(
                  bloc: _gameBloc,
                  builder: (BuildContext context, GameState state) {
                    if (state is ShowRightAnswerWhenCorrect ||
                        state is ShowRightAnswerWhenWrong) {
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 26.0,
                              ),
                            ],
                          ),
                          onPressed: () {
                            _gameBloc.add(RequestQuestionEvent());
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Choice extends StatelessWidget {
  final BuildContext context;
  final String answer;

  const Choice(this.context, this.answer) : super();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BlocBuilder<GameBloc, GameState>(
        bloc: BlocProvider.of<GameBloc>(this.context),
        builder: (BuildContext context, GameState state) {
          if (state is AskingQuestionState) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<GameBloc>(context)
                    .add(QuestionAnswered(state.question, this.answer));
              },
              child: Container(
                height: 70.0,
                width: MediaQuery.of(context).size.width - 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border(
                    top: BorderSide(
                        width: 2.0,
                        color: Color(0xFFFFDFDFDF).withOpacity(0.6)),
                    right: BorderSide(
                        width: 2.0,
                        color: Color(0xFFFFDFDFDF).withOpacity(0.6)),
                    left: BorderSide(
                        width: 2.0,
                        color: Color(0xFFFFDFDFDF).withOpacity(0.6)),
                    bottom: BorderSide(
                        width: 2.0,
                        color: Color(0xFFFFDFDFDF).withOpacity(0.6)),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$answer',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 80, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> path) {
    return false;
  }
}
