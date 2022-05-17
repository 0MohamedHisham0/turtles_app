class ChatModel {
  String id;
  String message;
  String senderId;
  String time;

  ChatModel(this.id, this.message, this.senderId, this.time,);

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    senderId = json['senderId'];
    time = json['time'];
  }

 toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = this.message;
    data['senderId'] = senderId;
    data['time'] = time;
    return data;
  }

}
