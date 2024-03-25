class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String location;
  final String meter;
  final String accessToken;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.location,
    required this.meter,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      meter: json['meter'] ?? '',
      accessToken: json['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'location': location,
      'meter': meter,
      'access_token': accessToken,
    };
  }
}
