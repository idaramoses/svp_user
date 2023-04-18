class Post {
  String id;
  String user_status;
  String admin_Status;
  String priority;
  String name;
  String size;
  String due;
  // String status;
  // String userName;
  // String usersize;
  // String userPlayerId;
  // String userToken;
  // String categoryName;
  // String createdAt;
  // String isPromoted;
  // String repostId;
  // String reposted;
  // String reposterName;
  // String repostHassize;
  // String details;
  // String categoryId;

  Post(
      {this.id,
      this.user_status,
      this.admin_Status,
      this.priority,
      this.name,
      this.size,
      this.due,
      // this.status,
      // this.details,
      // this.userName,
      // this.userToken,
      // this.userPlayerId,
      // this.isPromoted,
      // this.repostId,
      // this.reposted,
      // this.reposterName,
      // this.repostHassize,
      // this.usersize,
      // this.categoryName,
      // this.createdAt,
      // this.categoryId
      });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user_status = json['user_status'];
    admin_Status = json["admin_Status"];
    priority = json['priority'];
    name = json['name'];
    size = json['size'];
    due = json['due'];
    // status = json['status'];
    // details = json['details'];
    // userToken = json["user"]["api_token"];
    // isPromoted = json['isPromoted'];
    // repostId = json['repostId'];
    // repostHassize = json['repostHassize'];
    // reposted = json['reposted'];
    // reposterName = json['reposterName'];
    // categoryId = json['category_id'];
    // createdAt = json["created_at"];
    // userName = json['user']['name'];
    // usersize = json['user']['size'];
    // userPlayerId = json['user']['player_id'];
    // categoryName = json['category']['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['user_status'] = this.user_status;
    data["admin_Status"] = this.admin_Status;
    data['priority'] = this.priority;
    data['name'] = this.name;
    data['size'] = this.size;
    data['due'] = this.due;
    // data['status'] = this.status;
    // data['details'] = this.details;
    // data["user"]["api_token"] = this.userToken;
    // data['isPromoted'] = this.isPromoted;
    // data['repostId'] = this.repostId;
    // data['repostHassize'] = this.repostHassize;
    // data['reposted'] = this.reposted;
    // data['reposterName'] = this.reposterName;
    // data['category_id'] = this.categoryId;
    // data['created_at'] = this.createdAt;
    // data['user']['name'] = this.userName;
    // data['user']['size'] = this.usersize;
    // data['user']['player_id'] = this.userPlayerId;
    // data['category']['name'] = this.categoryName;
    return data;
  }
}
