class Quiz {
  String category;
  String type;
  String difficulty;
  List<Question> questions;

  Quiz({this.category, this.type, this.difficulty, this.questions});

  Quiz.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    if (json['data'] != null) {
      questions = new List<Question>();
      json['data'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    if (this.questions != null) {
      data['data'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int id;
  String question;
  List<String> incorrectAnswer;
  String correctAnswer;
  String explanation;

  Question(
      {this.id,
        this.question,
        this.incorrectAnswer,
        this.correctAnswer,
        this.explanation});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    incorrectAnswer = json['incorrect_answer'].cast<String>();
    correctAnswer = json['correct_answer'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['incorrect_answer'] = this.incorrectAnswer;
    data['correct_answer'] = this.correctAnswer;
    data['explanation'] = this.explanation;
    return data;
  }
}