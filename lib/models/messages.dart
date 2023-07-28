class Messages {

  String id;
  String title;
  String projectname;
  String projectdue;
  String projectuserstatus;
  String projectadminstatus;
  String projectdetails;
  String projectid;
  String username;
  String userid;
  String userparticipants;
  String pmname;
  String pmid;
  String pmparticipants;
  String adminname;
  String adminparticipants;
  String avatar;

  Messages(
      {this.id,
        this.title,
        this.projectname,
        this.projectdue,
        this.projectuserstatus,
        this.projectadminstatus,
        this.projectdetails,
        this.projectid,
        this.username,
        this.userid,
        this.userparticipants,
        this.pmname,
        this.pmid,
        this.pmparticipants,
        this.adminname,
        this.adminparticipants,
        this.avatar,
      });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    id: json["_id"],
    title : json['title'],
    projectname: json['project']['name'],
    projectdue: json['project']['due'],
    projectuserstatus: json['project']['user_status'],
    projectadminstatus: json['project']['admin_Status'],
    projectdetails: json['project']['details'],
    projectid: json['project']['id'],
    username: json['user']['name'],
    userid: json['user']['id'],
    userparticipants: json['user']['participants'],
    pmname: json['pm']['name'],
    pmid: json['pm']['id'],
    pmparticipants: json['pm']['participants'],
    adminname: json['admin']['name'],
    adminparticipants: json['admin']['participants'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    'title': title,
    'projectname': projectname,
    'projectdue ': projectdue,
    'username': username,
    'userid': userid,
    'userparticipants': userparticipants,
    'pmname': pmname,
    'pmparticipants': pmparticipants,
    'adminname': adminname,
    'adminparticipants': adminparticipants,
    'avatar': avatar,
  };

}
