class Event {
  int id;
  String title;
  String description;
  String dateTime;
  String photo;
  String location;
  String isPromoted;
  String userName;
  int groupId;
  int userId;
  int schoolId;

  Event(
      {this.id,
        this.title,
        this.description,
        this.dateTime,
        this.photo,
        this.location,
        this.isPromoted,
        this.userName,
        this.groupId,
        this.userId,
        this.schoolId});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dateTime = json['dateTime'];
    photo = json['photo'];
    location = json['location'];
    isPromoted = json['isPromoted'];
    userName = json['username'];
    groupId = json['group_id'];
    userId = json['user_id'];
    schoolId = json['school_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['dateTime'] = this.dateTime;
    data['photo'] = this.photo;
    data['location'] = this.location;
    data['isPromoted'] = this.isPromoted;
    data['username'] = this.userName;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['school_id'] = this.schoolId;
    return data;
  }
}
