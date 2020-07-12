import 'package:equatable/equatable.dart';
import 'package:quiz_app/countries/model/country.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameStartedEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class RequestQuestionEvent extends GameEvent {
  @override
  List<Object> get props => [];
}

class QuestionAnswered extends GameEvent {
  final Question question;
  final String answer;

  QuestionAnswered(this.question, this.answer);
  @override
  List<Object> get props => [question, answer];
}
