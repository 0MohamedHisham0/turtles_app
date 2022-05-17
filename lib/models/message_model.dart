class MessageModel {
  String message;
  String senderId;
  String time;

  MessageModel( this.message, this.senderId, this.time,);

  fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderId = json['senderId'];
    time = json['time'];
  }

 toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['senderId'] = senderId;
    data['time'] = time;
    return data;
  }

}
