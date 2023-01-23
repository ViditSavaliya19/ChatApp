class ChatUserModel {
  String? date, docId, msg, name, phone;
  Map? emails;
  List? uids = [];

  ChatUserModel(
      {this.date,
      this.docId,
      this.emails,
      this.msg,
      this.name,
      this.phone,
      this.uids});
}
