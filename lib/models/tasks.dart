class Tasks {
  String id;
  String user_status;
  String name;
  String size;
  String due;
  bool star;
  String date;
  String projectName;
  String projectUserID;
  String projectID;
  String assignFirstName;
  String assignLastName;
  String assignID;
  String assignAvata;
  String aprovalID;
  List<TasksAttatment> attactment = [];

  Tasks(
      {this.id,
        this.user_status,
        this.name,
        this.size,
        this.due,
        this.date,
        this.star,
        this.projectName,
        this.projectUserID,
        this.projectID,
        this.assignFirstName,
        this.assignLastName,
        this.assignID,
        this.assignAvata,
        this.attactment,
        this.aprovalID,
      });
  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
    id: json["_id"],
    name: json["name"],
    user_status : json['status'],
    size: json['size'],
    due: json['due'],
    date: json['date'],
    projectName: json['project']['name'],
    projectUserID: json['project']['user_id'],
    projectID: json['project']['id'],
    assignFirstName: json['assigned_to']['firstname'],
    assignLastName: json['assigned_to']['lastname'],
    assignID: json['assigned_to']['id'],
    assignAvata: json['assigned_to']['avatar'],
    star: json["star"],
    aprovalID: json["approval_id"],
    attactment : List.from(json['attachments']).map((e) => TasksAttatment.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status ":user_status,
    "name":name,
    "size":size,
    "due":due,
    "date":date,
    "star":star,
    "projectName":projectName,
    "projectUserID":projectUserID,
    "projectID":projectID,
    "assignFirstName":assignFirstName,
    "assignLastName":assignLastName,
    "assignID":assignID,
    "assignAvata":assignAvata,
    "approval_id":aprovalID,
    'attachments' :attactment.map((e) => e.toJson()).toList(),
  };

}

class TasksAttatment {
  TasksAttatment({
    this.name,
    this.size,
    this.type,
    this.date,

  });

  String name;
  int size;
  String type;
  String date;


  factory TasksAttatment.fromJson(Map<String, dynamic> json) => TasksAttatment(
    name: json["name"],
    // size: json["size"],
    // type: json["type"],
    // date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "type": type,
    "date": date,
  };
}

class TasksActivities {
  TasksActivities({
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


  factory TasksActivities.fromJson(Map<String, dynamic> json) => TasksActivities(
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