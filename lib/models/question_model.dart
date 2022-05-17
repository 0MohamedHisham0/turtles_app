class QuestionModel {
  String? id;
  String? question;
  String? answer;
  String? senderId;
  String? time;

  QuestionModel({this.id, this.question, this.answer, this.senderId, this.time});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    senderId: json["senderId"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "senderId": senderId,
    "time": time,
  };
}
