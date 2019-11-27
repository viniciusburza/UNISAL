import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lol_do_milhao/models/questions.dart';

class Service {
  static Future<List<Question>> getAllQuestions() async {
    List<Question> questions = [];

    await Firestore.instance
        .collection("questions")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((document) {
        final question = Question.fromMap(document.data);
        questions.add(question);
      });
    });

    return questions;
  }
}
