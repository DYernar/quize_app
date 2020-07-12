import 'package:equatable/equatable.dart';
import 'package:quiz_app/countries/model/country.dart';

abstract class GameState extends Equatable {
  final int lives;
  final int score;
  const GameState(this.lives, this.score);
}

class LoadingState extends GameState {
  LoadingState() : super(0, 0);

  @override
  List<Object> get props => [];
}

class AskingQuestionState extends GameState {
  final Question question;

  AskingQuestionState(this.question, int lives, int score)
      : super(lives, score);

  @override
  List<Object> get props => [question];
}

class ShowRightAnswerWhenCorrect extends GameState {
  final Question question;

  ShowRightAnswerWhenCorrect(this.question, int lives, int score)
      : super(lives, score);
  @override
  List<Object> get props => [];
}

class ShowRightAnswerWhenWrong extends GameState {
  final Question question;
  final int userSelected;
  ShowRightAnswerWhenWrong(
      this.question, this.userSelected, int lives, int score)
      : super(lives, score);

  @override
  List<Object> get props => [question];
}

class GameIsFinishedState extends GameState {
  final int score;
  GameIsFinishedState(this.score) : super(0, 0);
  @override
  List<Object> get props => [score];
}
