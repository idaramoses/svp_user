class Reports {
  String id;
  String projectid;
  String projectname;
  String projectuser_id;
  String taskid;
  String taskname;
  String date;
  String sent_fromFirstName;
  String sent_fromLastName;
  String sent_fromID;
  String sent_toFirstName;
  String sent_toLastName;
  String sent_toID;
  String sent_toAvata;
  String note_pm;
  List<ReportsAttatment> attactment = [];

  Reports(
      {this.id,
      this.projectid,
      this.projectname,
      this.projectuser_id,
      this.taskid,
      this.taskname,
      this.date,
      this.sent_fromFirstName,
      this.sent_fromLastName,
      this.sent_fromID,
      this.sent_toFirstName,
      this.sent_toLastName,
      this.sent_toID,
      this.sent_toAvata,
      this. note_pm,
      this.attactment,
      });

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
    id: json["_id"],
    projectid: json['project']["id"],
    projectname : json['project']['name'],
    projectuser_id: json['project']['user_id'],
    taskid: json['task']['id'],
    taskname: json['task']['name'],
    date: json['date'],
    sent_fromFirstName: json['sent_from']['firstname'],
    sent_fromID: json['sent_from']['id'],
    sent_fromLastName: json['sent_from']['lastname'],
    sent_toFirstName: json['sent_to']['firstname'],
    sent_toLastName: json['sent_to']['lastname'],
    sent_toID: json['sent_to']['id'],
    sent_toAvata: json['sent_to']['avatar'],
    note_pm: json["notes"]['pm'],
    // attactment : List.from(json['attachments']).map((e) => ReportsAttatment.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectid": projectid,
    "projectname ": projectname,
    "projectuser_id ": projectuser_id,
    "taskid ": taskid,
    "taskname ": taskname,
    "date ": date,
    "sent_fromFirstName ": sent_fromFirstName,
    "sent_fromID ": sent_fromID,
    "sent_fromLastName ": sent_fromLastName,
    "sent_toFirstName ": sent_toFirstName,
    "sent_toID ": sent_toID,
    "sent_toLastName ": sent_toLastName,
    "sent_toID ":sent_toID,
    "sent_toAvata ":sent_toAvata,
    "note_pm ":note_pm,
    // 'attachments' :attactment.map((e) => e.toJson()).toList(),
  };

}
class ReportsAttatment {
  ReportsAttatment({
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


  factory ReportsAttatment.fromJson(Map<String, dynamic> json) => ReportsAttatment(
    name: json["name"],
    size: json["size"],
    type: json["type"],
    send_from: json["send_from"],
    sent_to: json["sent_to"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "type": type,
    "send_from": send_from,
    "sent_to": sent_to,
  };
}

class ReportsActivities {
  ReportsActivities({
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


  factory ReportsActivities.fromJson(Map<String, dynamic> json) => ReportsActivities(
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