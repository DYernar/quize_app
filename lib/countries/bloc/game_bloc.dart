import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/countries/bloc/game_event.dart';
import 'package:quiz_app/countries/bloc/game_state.dart';
import 'package:quiz_app/countries/model/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  List<Country> countries = [];
  List<Question> questions = [];
  var randomizer = math.Random();
  int lives = 3;
  int score = 0;
  GameBloc() : super(LoadingState());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameStartedEvent) {
      yield LoadingState();
      await _getCountries();
      print(this.countries.length);
      _generateQuestions();
      yield AskingQuestionState(
          this.questions[this.randomizer.nextInt(this.questions.length)],
          this.lives,
          this.score);
    }

    if (event is RequestQuestionEvent) {
      if (this.lives == 0) {
        yield LoadingState();
        this.lives = 3;
        int finalScore = this.score;
        await _checkPrefs(finalScore);
        this.score = 0;
        yield GameIsFinishedState(finalScore);
      } else {
        yield AskingQuestionState(
            this.questions[randomizer.nextInt(this.questions.length)],
            this.lives,
            this.score);
      }
    }

    if (event is QuestionAnswered) {
      if (event.question.answers[event.question.correctInd] == event.answer) {
        this.score++;
        yield ShowRightAnswerWhenCorrect(
            event.question, this.lives, this.score);
      } else {
        this.lives--;
        int userSelectedint;
        for (int k = 0; k < 4; k++) {
          if (event.question.answers[k] == event.answer) {
            userSelectedint = k;
            break;
          }
        }
        yield ShowRightAnswerWhenWrong(
            event.question, userSelectedint, this.lives, this.score);
      }
    }
  }

  _getCountries() async {
    String fileText = await rootBundle.loadString('assets/countries.txt');
    var obj = json.decode(fileText);
    for (var v in obj) {
      Country c = Country(v['code'], v['name'], v['emoji'], v['unicode']);
      this.countries.add(c);
    }
  }

  _generateQuestions() {
    for (var i = 0; i < this.countries.length; i++) {
      var random = new math.Random();
      List<String> answers = [];
      answers.add(this.countries[i].name);
      while (answers.length != 4) {
        String n = this.countries[random.nextInt(this.countries.length)].name;
        if (n != this.countries[i].name) {
          answers.add(n);
        }
      }
      num correctInd = 0;

      var currentIndex = answers.length, temporaryVal, randomIndex;
      while (currentIndex != 0) {
        randomIndex = random.nextInt(currentIndex);
        currentIndex--;
        temporaryVal = answers[currentIndex];
        answers[currentIndex] = answers[randomIndex];
        answers[randomIndex] = temporaryVal;
      }

      for (var k = 0; k < answers.length; k++) {
        if (answers[k] == this.countries[i].name) {
          correctInd = k;
          break;
        }
      }
      Question q = Question(this.countries[i].emoji, answers, correctInd);
      this.questions.add(q);
    }
    print(this.questions.length);
  }

  Future<int> _getLastScore() async {
    final prefs = await SharedPreferences.getInstance();

    final lastScore = prefs.getInt('score');
    if (lastScore == null) {
      return 0;
    }
    return lastScore;
  }

  _saveToPrefs(num score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);
  }

  _checkPrefs(num score) async {
    final prefs = await SharedPreferences.getInstance();

    int lastScore = await _getLastScore();

    if (score > lastScore) {
      await _saveToPrefs(score);
    }
  }
}
