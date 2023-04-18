import 'dart:convert';

List<ProjectModel> ProjectModelFromJson(String str) =>
    List<ProjectModel>.from(json.decode(str).map((x) => ProjectModel.fromJson(x)));

// String ProjectModelToJson(List<ProjectModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectModel {
  ProjectModel({
     this.id,
     // this.name,
     // this.user_status,
     // this.admin_Status,
     // this.requested_by,
     // this.priority,
     // this.details,
  });

  int id;
  // String name;
  // String user_status;
  // String admin_Status;
  // Address requested_by;
  // String priority;
  // String details;


  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["_id"],
    // name: json["name"],
    // user_status: json["user_status"],
    // admin_Status: json["admin_Status"],
    // requested_by: Address.fromJson(json["requested_by"]),
    // priority: json["priority"],
    // details: json["details"],

  );

  Map<String, dynamic> toJson() => {

    "_id": id,
    // "name": name,
    // "user_status": user_status,
    // "admin_Status": admin_Status,
    // "requested_by": requested_by.toJson(),
    // "priority": priority,
    // "details": details,

  };
}

class Address {
  Address({
    this.id,
    this.firstname,
    this.lastname,
  });

  String id;
  String firstname;
  String lastname;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
  };
}

class Geo {
  Geo({
     this.lat,
     this.lng,
  });

  String lat;
  String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Company {
  Company({
     this.name,
     this.catchPhrase,
     this.bs,
  });

  String name;
  String catchPhrase;
  String bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json["name"],
    catchPhrase: json["catchPhrase"],
    bs: json["bs"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}