class User {
  String id;
  String username;
  String password;
  String avatar;
  String address;

  User(
      {this.id, this.username, this.password, this.avatar, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    avatar = json['avatar'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    return data;
  }
}