class Country {
  final String code;
  final String uniCode;
  final String name;
  final String emoji;

  Country(this.code, this.name, this.emoji, this.uniCode);
}

class Question {
  final String emoji;
  final List<String> answers;
  final int correctInd;

  Question(this.emoji, this.answers, this.correctInd);
}
