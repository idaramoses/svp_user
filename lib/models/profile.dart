class Profile {
  dynamic id;
  dynamic firstname;
  dynamic lastname;
  dynamic email;
  dynamic password;
  dynamic avatar;
  dynamic role;
  dynamic date;
  dynamic v;

  Profile(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.avatar,
      this.role,
      this.date,
      this.v});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    role = json['role'];
    date = json['date'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    data['date'] = this.date;
    data['__v'] = this.v;
    return data;
  }
}
