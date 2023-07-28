class Notifications {

  String id;
  String type;
  String user;
  String ref;
  bool read;
  bool task_completed;
  String date;
  String from_userFirstName;
  String from_userLastName;

  Notifications(
      {this.id,
        this.date,
        this.read,
        this.task_completed,
        this.user,
        this.ref,
        this.from_userFirstName,
        this.from_userLastName,
        this.type,

      });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    id: json["id"],
    type: json["type"],
    user : json['user'],
    ref: json['ref'],
    read: json['read'],
    date: json['date'],
    task_completed: json['task_completed'],
    from_userFirstName: json['from_user']['firstname'],
    from_userLastName: json['from_user']['lastname'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    'id': id,
    'type': type,
    'user ': user,
    'ref': ref,
    'read': read,
    'date': date,
    'task_completed': task_completed,
    'from_userFirstName': from_userFirstName,
    'from_userLastName': from_userLastName,
    // 'attachments' :attactment.map((e) => e.toJson()).toList(),
  };

}
