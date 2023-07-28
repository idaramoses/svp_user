class User {
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic role;
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
      this.role,
      this.name,
      this.firstName,
      this.lastName,
      this.avatar,
      this.email,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    name = json["firstname"]+' '+ json['lastname'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    avatar = json['avatar'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['firstname'] = this.name;
    data['role'] = this.role;
    data['firstname'] = this.firstName;
    data['lastname'] = this.lastName;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
