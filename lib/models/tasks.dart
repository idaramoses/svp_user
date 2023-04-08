class Tasks {
  int id;
  String name;
  String content;
  String photo;
  String video;
  String status;
  String isPromoted;
  String reposted;
  String reposterName;
  String repostId;
  String repostHasPhoto;
  int userId;
  int categoryId;
  int groupId;
  int schoolId;
  String createdAt;
  String updatedAt;

  Tasks(
      {this.id,
      this.name,
      this.content,
      this.photo,
      this.video,
      this.status,
      this.isPromoted,
      this.reposted,
      this.reposterName,
      this.repostId,
      this.repostHasPhoto,
      this.userId,
      this.categoryId,
      this.groupId,
      this.schoolId,
      this.createdAt,
      this.updatedAt});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    photo = json['photo'];
    video = json['video'];
    status = json['status'];
    isPromoted = json['isPromoted'];
    reposted = json['reposted'];
    reposterName = json['reposterName'];
    repostId = json['repostId'];
    repostHasPhoto = json['repostHasPhoto'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    groupId = json['group_id'];
    schoolId = json['school_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['photo'] = this.photo;
    data['video'] = this.video;
    data['status'] = this.status;
    data['isPromoted'] = this.isPromoted;
    data['reposted'] = this.reposted;
    data['reposterName'] = this.reposterName;
    data['repostId'] = this.repostId;
    data['repostHasPhoto'] = this.repostHasPhoto;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['group_id'] = this.groupId;
    data['school_id'] = this.schoolId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
