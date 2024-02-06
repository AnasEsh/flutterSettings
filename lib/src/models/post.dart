class Post {
  String content, creatorId, id;
  DateTime modified;
  Post(
      {required this.creatorId,
      this.id = "",
      required this.content,
      DateTime? modified})
      : modified = modified ?? DateTime.now();

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      creatorId: json['creatorId'],
      content: json['content'],
      modified: DateTime.parse(json['modified']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creatorId': creatorId,
      'content': content,
      'modified': modified.toIso8601String(),
    };
  }
}
