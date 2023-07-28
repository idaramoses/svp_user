class Post {
  String id;
  String user_status;
  String admin_Status;
  String priority;
  String name;
  String size;
  String due;
  String budget;
  String building_type;
  bool design;
  String site_condition;
  String facilities;
  bool star;
  String date;
  String details;
  String requstFirstName;
  String requstLastName;
  String requstID;
  String assignFirstName;
  String assignLastName;
  String assignID;
  String assignAvata;
  List<Attatment> attactment = [];
  List<Activities> activities = [];

  Post(
      {this.id,
      this.user_status,
      this.admin_Status,
      this.priority,
      this.name,
      this.size,
      this.due,
      this.budget,
      this.details,
      this.building_type,
      this.facilities,
      this.site_condition,
      this.date,
      this.design,
      this.star,
        this.requstFirstName,
        this.requstLastName,
        this.requstID,
        this.assignFirstName,
        this.assignLastName,
        this.assignID,
        this.assignAvata,
        this.attactment,
        this.activities
      });
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    name: json["name"],
      user_status : json['user_status'],
      admin_Status: json["admin_Status"],
      priority: json['priority'],
      size: json['size'],
      due: json['due'],
      budget: json['budget'],
      details: json['details'],
      building_type: json['building_type'],
      facilities: json["facilities"],
      date: json['date'],
      requstFirstName: json['requested_by']['firstname'],
      requstLastName: json['requested_by']['lastname'],
      requstID: json['requested_by']['id'],
      assignFirstName: json['assigned_to']['firstname'],
      assignLastName: json['assigned_to']['lastname'],
      assignID: json['assigned_to']['id'],
      assignAvata: json['assigned_to']['avatar'],
      star: json["star"],
      design: json['design'],
      site_condition: json['site_condition'],
      attactment : List.from(json['attachments']).map((e) => Attatment.fromJson(e)).toList(),
      activities : List.from(json['activities']).map((e) => Activities.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_status ":user_status,
    "admin_Status ":admin_Status,
    "priority ":priority,
    "name ":name,
    "size ":size,
    "due ":due,
    "budget ":budget,
    "details ":details,
    "building_type ":building_type,
    "facilities ":facilities,
    "site_condition ":site_condition,
    "date ":date,
    "design ":design,
    "star ":star,
    "requstFirstName ":requstFirstName,
    "requstLastName ":requstLastName,
    "requstID ":requstID,
    "assignFirstName ":assignFirstName,
    "assignLastName ":assignLastName,
    "assignID ":assignID,
    "assignAvata ":assignAvata,
    'attachments' :attactment.map((e) => e.toJson()).toList(),
    'activities' :activities.map((e) => e.toJson()).toList(),
  };

}

class Attatment {
  Attatment({
    this.name,
    this.size,
    this.type,
    this.send_from,
    this.sent_to,

  });

  String name;
  int size;
  String type;
  String send_from;
  String sent_to;


  factory Attatment.fromJson(Map<String, dynamic> json) => Attatment(
    name: json["name"],
    // size: json["size"],
    // type: json["type"],
    // send_from: json["send_from"],
    // sent_to: json["sent_to"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "type": type,
    "send_from": send_from,
    "sent_to": sent_to,
  };
}

class Activities {
  Activities({
    this.initiator,
    this.action_type,
    this.action,
    this.date,
    this.id,

  });

  String initiator;
  String action_type;
  String action;
  String date;
  String id;


  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
    initiator: json["initiator"],
    action_type: json["action_type"],
    action: json["action"],
    date: json["date"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "initiator": initiator,
    "action_type": action_type,
    "action": action,
    "date": date,
    "_id": id,
  };
}