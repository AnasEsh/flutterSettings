class User {
  String name;
  String email;
  int _id;
  int get id => _id;
  User({required this.name, required int id, required this.email}) : _id = id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json["email"], id: json["id"], name: json["name"]);
  }
}
