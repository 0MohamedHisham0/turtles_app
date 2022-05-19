
class PostModel {
  String? id;
  String? question;
  String? answer;
  int? likes;
  int? unLikes;
  List<Comment>? comments;
  List<String>? raters;
  String? time;
  String? postCreator;
  String? postCreatorId;

  PostModel(
    this.id,
    this.question,
    this.answer,
    this.likes,
    this.unLikes,
    this.comments,
    this.raters,
    this.time,
    this.postCreator,
    this.postCreatorId,
  );

  // fromJason
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    likes = json['likes'];
    unLikes = json['unLikes'];
    time = json['time'];
    postCreator = json['postCreator'];
    postCreatorId = json['postCreatorId'];

    if (json['raters'] != null) {
      raters = <String>[];
      json['raters'].forEach((v) {
        raters!.add(v.toString());
      });
    }

    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }

  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['likes'] = likes;
    data['unLikes'] = unLikes;
    data['comments'] = comments ?? [];
    data['raters'] = raters ?? [];
    data['time'] = time;
    data['postCreator'] = postCreator;
    data['postCreatorId'] = postCreatorId;

    return data;
  }

}
class Comment {
  String? id;
  String? comment;
  String? time;
  String? commentCreator;
  String? commentCreatorId;

  Comment(this.id, this.comment, this.time, this.commentCreator,
      this.commentCreatorId);

  // fromJason
  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    time = json['time'];
    commentCreator = json['commentCreator'];
    commentCreatorId = json['commentCreatorId'];
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['time'] = time;
    data['commentCreator'] = commentCreator;
    data['commentCreatorId'] = commentCreatorId;

    return data;
  }
}
