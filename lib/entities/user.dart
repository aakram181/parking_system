class User {
  final String uid;
  final String email;
  final String username;

  User({required this.uid, required this.email, required this.username});

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid']! as String,
        email: json["email"]! as String,
        username: json['username']! as String,
      );

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "username": username};

  @override
  String toString() {
    return 'Username{username: $username}';
  }
}
