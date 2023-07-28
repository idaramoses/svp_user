
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/notifications_one_screen/state/notification_controller.dart';
import 'package:svp_admin_pm/presentation/notifications_one_screen/state/notification_provider.dart';


import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../models/notification.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../utils/app_local_storage.dart';
import '../../utils/flushbar_mixin.dart';
import '../../widgets/custom_image_view.dart';
import '../auth/signin/state/auth_provider.dart';



class NotificationsOneScreen extends StatefulWidget {
  @override
  State<NotificationsOneScreen> createState() => _NotificationsOneScreenState();
}

class _NotificationsOneScreenState extends State<NotificationsOneScreen> {
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
      await NotificationController(context: context).getPosts();

      setState(() {
        isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  ColorConstant.gray200,
        body: Column(
          children: [
            Container(
              height: getVerticalSize(
                70,
              ),
              width: double.maxFinite,
              child: Container(
                width: double.maxFinite,
                padding: getPadding(
                  all: 16,
                ),
                decoration: AppDecoration.outlineGray300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: getMargin(
                              top: 10,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorConstant.orangeA200,
                            ),
                          ),
                        ),
                        Spacer(),
                        CustomImageView(
                          svgPath: ImageConstant.imgOverflowmenu,
                          height: getSize(
                            24,
                          ),
                          width: getSize(
                            24,
                          ),
                          margin: getMargin(
                            top: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<NotificationProvider>(builder: (context, value, child) {
                if (value.posts == null)
                  return loader();
                else {
                  return Column(
                    children: [
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 25,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "ALL NOTIFICATIONS",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBold16,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget NotificationBody(NotificationProvider value) {
    if (value.posts == null) {
      return loader();
    } else if (value.posts.length == 0) {
      emptyPostWidget("No Notification.");
    } else {
      List<Notifications> categoryPost = [];
      //List<Post> postsByClassmates = [];

      //get user groups ids

      //get post by category
      value.posts.forEach((element) {
        categoryPost.add(element);
      });

      if (categoryPost.length == 0) {
        emptyPostWidget("No Notification.");
      } else
        return listViewBuilder(categoryPost);
    }
    return emptyPostWidget("No Notification.");
  }


  Widget listViewBuilder(List<Notifications> postList) {
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
              Notifications post = postList[index];
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


  Widget postCard(Notifications post) {

    String  date = post.date;
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Notificationloader(
              id:post.ref,
              type:post.type.toLowerCase(),
            )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: getPadding(
            left: 8,
            top: 10,
            right: 8,
            bottom: 10,
          ),
          decoration: AppDecoration.outlineOrangeA2002,
          child: ListTile(
            leading:  CustomImageView(
              imagePath: ImageConstant.imgEllipse13,
              height: getSize(
                48,
              ),
              width: getSize(
                48,
              ),
              radius: BorderRadius.circular(
                getHorizontalSize(
                  24,
                ),
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "New",
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: " ",
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: post.type,
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: " ",
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "from",
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: " ",
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: post.from_userFirstName,
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            subtitle: Text(
              outputDate,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtSFProTextRegular14Gray500,
            ),
            trailing:  CustomImageView(
              svgPath: ImageConstant.imgOverflowmenu,
              height: getSize(
                24,
              ),
              width: getSize(
                24,
              ),
              margin: getMargin(
                left: 24,
                top: 12,
                bottom: 12,
              ),
            ),
          ),
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


}
 class Notificationloader extends StatefulWidget {
   String id;
   String type;
   bool isupload;
    Notificationloader({Key key,this.id,
      this.type, this.isupload,}) : super(key: key, );

   @override
   State<Notificationloader> createState() => _NotificationloaderState();
 }

 class _NotificationloaderState extends State<Notificationloader> with FlushBarMixin {
  bool isLoading = false;
   @override
   void initState() {
     super.initState();
    next();
   }
  Widget loader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return PKCardSkeleton();
      },
    );
  }
   @override
   Widget build(BuildContext context) {
     return SafeArea(child: Scaffold(body: Column(
       children: [
         Container(
           height: getVerticalSize(
             70,
           ),
           width: double.maxFinite,
           child: Container(
             width: double.maxFinite,
             padding: getPadding(
               all: 16,
             ),
             decoration: AppDecoration.outlineGray300,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.end,
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Row(
                   children: [
                     GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                       },
                       child: Container(
                         margin: getMargin(
                           top: 10,
                         ),
                         child: Icon(
                           Icons.arrow_back,
                           color: ColorConstant.orangeA200,
                         ),
                       ),
                     ),
                     Spacer(),
                     CustomImageView(
                       svgPath: ImageConstant.imgOverflowmenu,
                       height: getSize(
                         24,
                       ),
                       width: getSize(
                         24,
                       ),
                       margin: getMargin(
                         top: 10,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
         Expanded(child: loader()),
       ],
     )));
   }
   Future<void> next() async {
     String role =
         Provider.of<AuthProvider>(context, listen: false).userInfo.role;

     if (!isLoading) {
       setState(() {
         isLoading = true;
       });
       try {
         Map<String, dynamic> credentials = {
           "id":  widget.id,
           "role": 'user',
           "type":widget.type,
         };
         await NotificationController(context: context).getnotiffication(credentials);
       } catch (e) {
         print(e);
       }
       setState(() {
         isLoading = false;
       });
     }
     if(widget.isupload == true){
       showSuccessNotification(
           context, "Attachment Added");
     }
   }
 }


