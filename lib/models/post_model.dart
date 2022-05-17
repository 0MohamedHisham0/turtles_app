import 'package:html/dom.dart';

class PostModel {
  String? id;
  String? question;
  String? answer;
  int? likes;
  int? unLikes;
  List<Comment>? comments;
  String? time;
  String? postCreator;
  String? postCreatorId;

  PostModel(this.id, this.question, this.answer, this.likes, this.unLikes,
      this.comments, this.time, this.postCreator, this.postCreatorId);

  // fromJason
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    likes = json['likes'];
    unLikes = json['unLikes'];
    comments = json['comments'];
    time = json['time'];
    postCreator = json['postCreator'];
    postCreatorId = json['postCreatorId'];
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['likes'] = likes;
    data['unLikes'] = unLikes;
    data['comments'] = comments;
    data['time'] = time;
    data['postCreator'] = postCreator;
    data['postCreatorId'] = postCreatorId;

    return data;
  }

}
