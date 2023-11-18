
class MessageModel {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  const MessageModel({
      required this.senderId,
      required this.receiverId,
      required this.content,
      required this.sentTime,
      required this.messageType,
  });

  Map<String, dynamic> toJson()=>{
'receiverId':receiverId,
  'senderId':senderId,
  'content':content,
  'sentTime':sentTime,
  'messageType':messageType.toJson()
  };
  
}
enum MessageType {
  text,
  image;
  String toJson()=>name;
}

