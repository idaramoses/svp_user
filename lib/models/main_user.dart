class User {
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userId;
  dynamic firstName;
  dynamic lastName;
  dynamic avatar;
  dynamic name;
  dynamic email;
  dynamic token;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.name,
      this.firstName,
      this.lastName,
      this.avatar,
      this.email,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['_id'];
    name = json["name"];
    firstName = json['firstname'];
    lastName = json['lastname'];
    avatar = json['avatar'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['_id'] = this.userId;
    data['firstname'] = this.firstName;
    data['lastname'] = this.lastName;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
