class Users {
  String id;
  String name;
  String email;
  String picture;
  String token;
  Users({this.id, this.email, this.name, this.picture,this.token});

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
        id: data["id"],
      name: data["name"],
        email: data["email"],
      picture: data["picture"],
        token: data["token"],
    );
  }
}
