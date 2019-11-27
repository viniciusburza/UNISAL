import 'dart:convert';

class Question {
    String question;
    String answer1;
    String answer2;
    String answer3;
    String answer4;
    String correct;

    Question({
        this.question,
        this.answer1,
        this.answer2,
        this.answer3,
        this.answer4,
        this.correct,
    });

    factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Question.fromMap(Map<String, dynamic> json) => Question(
        question: json["question"] == null ? null : json["question"],
        answer1: json["answer1"] == null ? null : json["answer1"],
        answer2: json["answer2"] == null ? null : json["answer2"],
        answer3: json["answer3"] == null ? null : json["answer3"],
        answer4: json["answer4"] == null ? null : json["answer4"],
        correct: json["correct"] == null ? null : json["correct"],
    );

    Map<String, dynamic> toMap() => {
        "question": question == null ? null : question,
        "answer1": answer1 == null ? null : answer1,
        "answer2": answer2 == null ? null : answer2,
        "answer3": answer3 == null ? null : answer3,
        "answer4": answer4 == null ? null : answer4,
        "correct": correct == null ? null : correct,
    };
}
