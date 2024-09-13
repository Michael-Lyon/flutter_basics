class Question {
  const Question(this.question, this.answers);

  final String question;
  final List<String> answers;

  List<String> getShuffledAnswer() {
    // final ensures that the shuffleedList can't be reassigned
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
