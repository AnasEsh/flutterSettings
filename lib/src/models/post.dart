class Post {
  String content, UserId;
  DateTime modified;
  Post({required this.UserId, required this.content, DateTime? modified})
      : this.modified = modified ?? DateTime.now();
}
