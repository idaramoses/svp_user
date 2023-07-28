
import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/messages_screen/state/messages_controller.dart';
import 'package:svp_admin_pm/presentation/messages_screen/state/messages_provider.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../models/messages.dart';
import '../../models/notification.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../utils/app_local_storage.dart';
import '../../widgets/app_bar/appbar_circleimage_1.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../auth/signin/state/auth_provider.dart';
import 'chat_details.dart';
import 'package:timeago/timeago.dart' as timeago;




class MessagesScreen extends StatefulWidget {
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  AppLocalStorage storage = AppLocalStorage();
  String selectedCategory;
  String reportReason;
  bool isClassmatesSelected = false;
  bool isCategorySelected = false;
  int currentIndex = 0;
  final scrollController = ScrollController();
  int selectedId;
  int reportedPostId;
  int currentPostId = 0;
  List<String> categories = ["All"];

  bool isLoading = false;
  bool loadingMore = false;
  bool isInit = false;
  bool isFollowing = false;
  bool radioValue1 = false;
  bool radioValue2 = false;
  bool isReporting = false;
  bool isFirstTimeClassmatesTapped = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCategory = 'All';
      isCategorySelected = true;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      await MessagesController(context: context).getPosts();

      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorConstant.gray200,
      body: Consumer<MessagesProvider>(builder: (context, value, child) {
        if (value.posts == null)
          return loader();
        else {
          return Column(
            children: [
              Padding(
                padding: getPadding(
                  left: 16,
                  right: 16,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "MESSAGES",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextBold16,
                        ),
                        Padding(
                          padding: getPadding(
                            top: 19,
                          ),
                          child: Text(
                            "Today",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold14OrangeA200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: getPadding(
                      left: 16,
                      right: 16,
                      top: 5,
                    ),child: NotificationBody(value)),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget NotificationBody(MessagesProvider value) {
    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Posts.");
    } else {
      List<Messages> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      value.posts.forEach((element) {
        categoryPost.add(element);
      });

      if (categoryPost.length == 0) {
        emptyPostWidget("No Message.");
      } else
        return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Message.");
  }


  Widget listViewBuilder(List<Messages> postList) {
    return NotificationListener(
      onNotification: (ScrollEndNotification notification) {
        if (notification is ScrollEndNotification &&
            scrollController.position.extentAfter == 0) {
          print('end');
          loadMore();
        }
        return false;
      },
      child: ListView(
        controller: scrollController,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Messages post = postList[index];
              return postCard(post);
            },
            itemCount: postList.length,
          ),
          loadingMore
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )
              : SizedBox(),
        ],
      ),
    );
  }

  Future loadMore() async {
    if (!loadingMore) {
      setState(() {
        loadingMore = true;
      });

      setState(() {
        loadingMore = false;
      });
    }
  }


  Widget postCard(Messages post) {
    // String  date = post.date;
    // DateTime parseDate =
    // new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    // var inputDate = DateTime.parse(parseDate.toString());
    // var outputFormat = DateFormat('MM/dd/yyyy');
    // var outputDate = outputFormat.format(inputDate);
 String userId =   Provider.of<AuthProvider>(context, listen: false).userInfo.id;
 String username =   Provider.of<AuthProvider>(context, listen: false).userInfo.firstName;
 String userphoto =   Provider.of<AuthProvider>(context, listen: false).userInfo.avatar;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Chat(
              ptitle: post.projectname,
              pstatues:post.projectadminstatus,
              pdescription: post.projectdetails,
              pdue: post.projectdue,
              houseId: post.id,
              title: post.title,
              avatar:post.avatar
            ),
          ),
        );
      },
      child:  Padding(
        padding: getPadding(
          left: 8,
          right: 8,
          bottom: 5,
        ),
        child: Container(
          padding: getPadding(
            left: 5,
            top: 5,
            right: 5,
            bottom: 10,
          ),
          decoration: AppDecoration.outlineOrangeA2002,
          child:
          ListTile(
            leading:   AppbarCircleimage1(
              imagePath: ImageConstant.imgEllipse1340x40,
            ),
            title:  Text(
            post.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtSFProTextSemibold16,
          ),
            subtitle:   groupLastMessage(post.id, Provider.of<AuthProvider>(context, listen: false).userInfo.id),
            trailing:   Container(height: 20,width: 50, child: TimeWidget(post.id, Provider.of<AuthProvider>(context, listen: false).userInfo.id)), ),
        ),
      ),
    );
  }




  Widget loader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return PKCardSkeleton();
      },
    );
  }

  Widget emptyPostWidget(String text) {
    return Center(
      child: Text(
        text,
        style:
        TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget groupLastMessage(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(groupId)
          .collection('messages')
          .orderBy("time_stamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if(snapshot.data.docs.length == 0){
            return Text("No Message", style: TextStyle(fontSize: 14, color: Colors.grey),);
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Map doc = snapshot.data.docs[index].data();
              String dataid = snapshot.data.docs[index].id;
              // Group group = value.userGroups.reversed.toList()[index];
              // Group group = Group(
              //     id: int.parse(doc.docID),
              //     name: doc.data["name"],
              //     photo: doc.data["photo"],
              //     description: doc.data["description"],
              //     totalMembers: 0,
              //     certificate: "",
              //     type: "",
              //     year: "",
              //     schoolId: 0,
              //     schoolName: "");

              return RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${doc["message"]}" ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                maxLines: 1,
              );
            },
          );
        } else
          return Text("...");
      },
    );
  }
  Widget TimeWidget(String groupId, String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(groupId)
          .collection('messages')
          .orderBy("time_stamp", descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if(snapshot.data.docs.length == 0){
            return Text("00.00", style: TextStyle(fontSize: 14, color: Colors.grey),);
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Map doc = snapshot.data.docs[index].data();
              return Text(
                 DateFormat('kk:mm').format(
                     DateTime.fromMillisecondsSinceEpoch(
                         doc['time_stamp'])),
                 style: AppStyle.txtSFProTextMedium12Gray500
                     .copyWith(
                   letterSpacing: getHorizontalSize(
                     0.06,
                   ),
                 ),
               );
            },
          );
        } else
          return Text("00.00");
      },
    );
  }
}
