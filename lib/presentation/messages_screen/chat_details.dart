import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../../widgets/app_bar/appbar_circleimage_1.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../auth/signin/state/auth_provider.dart';

class Chat extends StatefulWidget {
  final String houseId,title,avatar,ptitle,pstatues,pdescription,pdue;
 

  Chat({
    Key key,
    @required this.houseId, @required this.title,@required this.avatar, @required this.ptitle, @required this.pstatues, @required this.pdescription,@required this.pdue,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isInit = false;
  double _animatedHeight = getVerticalSize(
    0,
  );
  @override
  Widget build(BuildContext context) {
    String  date = widget.pdue;
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return SafeArea(
      child: new Scaffold(
        body: Column(
          children: [
            Container(
              decoration: AppDecoration.outlineGray300,
              child: Padding(
                padding: getPadding(
                  left: 15,
                  top: 16,
                  right: 15,
                  bottom: 16,
                ),
                child: Row(

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
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        AppbarCircleimage1(
                          imagePath: ImageConstant.imgEllipse1340x40,
                        ),
                        AppbarTitle(
                          text: widget.title,
                          margin: getMargin(
                            left: 12,
                            top: 11,
                            bottom: 8,
                          ),
                        ),
                      ],
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
              ),
            ),
            new GestureDetector(
              onTap: ()=>setState((){
                _animatedHeight!=0.0?_animatedHeight=0.0:_animatedHeight= getVerticalSize(
                  180,
                );}),
              child:  Container(
                color: Colors.white,
                height: getVerticalSize(50,),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new   Icon(_animatedHeight==0.0?Icons.arrow_drop_down:Icons.arrow_drop_up,color: ColorConstant.orangeA200,size: getSize(30),),
                  ],
                ),
              ),),
            new AnimatedContainer(duration: const Duration(milliseconds: 120),
              child: new Container(
                width: double.maxFinite,
                child: Container(
                  padding: getPadding(
                    left: 15,
                    top: 16,
                    right: 15,
                    bottom: 16,
                  ),
                  decoration: AppDecoration.outlineGray300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        child: Container(
                          width: getHorizontalSize(
                            344,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: getPadding(
                                  right: 50,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Project: ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .txtSFProTextSemibold14Gray800,
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 46,
                                      ),
                                      child: Text(
                                        widget.ptitle,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextSemibold14OrangeA200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 11,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 6,
                                        bottom: 6,
                                      ),
                                      child: Text(
                                        "Status: ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextSemibold14Gray800,
                                      ),
                                    ),
                                    CustomButton(
                                      height: getVerticalSize(
                                        30,
                                      ),
                                      width: getHorizontalSize(
                                        94,
                                      ),
                                      text: widget.pstatues,
                                      margin: getMargin(
                                        left: 49,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 11,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        bottom: 1,
                                      ),
                                      child: Text(
                                        "Due date: ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextSemibold14Gray800,
                                      ),
                                    ),
                                    CustomImageView(
                                      svgPath: ImageConstant.imgCalendar,
                                      height: getSize(
                                        16,
                                      ),
                                      width: getSize(
                                        16,
                                      ),
                                      margin: getMargin(
                                        left: 33,
                                        top: 1,
                                        bottom: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 8,
                                        top: 1,
                                      ),
                                      child: Text(
                                        outputDate,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextSemibold14Gray800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  top: 10,
                                  right: 19,

                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: getPadding(
                                        top: 1,
                                        bottom:20,
                                      ),
                                      child: Text(
                                        "Description:",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextSemibold14Gray800,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: getHorizontalSize(
                                          227,
                                        ),
                                        margin: getMargin(
                                          left: 16,
                                        ),
                                        child: Text(
                                          widget.pdescription,
                                          maxLines: null,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtSFProTextRegular14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              height: _animatedHeight,
            ),
            Expanded(
              child: new ChatScreen(
                houseId: widget.houseId,

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String houseId;

  ChatScreen(
      {Key key,
      @required this.houseId,})
      : super(key: key);

  @override
  State createState() =>
      new ChatScreenState(houseId: houseId, );
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.houseId, @required this.peerAvatar});

  String houseId;
  String peerAvatar;
  String id;
  TextEditingController commentController = TextEditingController();

  var listMessage;

  // String houseId = 'main id';

  File imageFile;
  File videoFile;
  bool isShowSticker;
  bool isimage = false;
  bool isvideo = false;
  String imageUrl;
  bool isLoading = false;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    isShowSticker = false;
    imageUrl = '';
    // readLocal();
    // readChat();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      setState(() {
        isInit = true;
      });
    }
  }


  readLocal() async {
    setState(() {
      houseId = '$widget.houseId';
    });
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile images = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(images.path);
    });
  }



  Future getVideo() async {
    final ImagePicker _picker = ImagePicker();
    XFile video = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      videoFile =  File(video.path);
    });
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(houseId)
        .collection(houseId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("post")
        .child(houseId)
        .child("video")
        .child("video" + ".mp4");
    UploadTask uploadTask = storageReference.putFile(videoFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((value) {
      documentReference.set({
        "video": value,
        'content': commentController.text,
        'idFrom': Provider.of<AuthProvider>(context, listen: false).userInfo.id,
        'idname': Provider.of<AuthProvider>(context, listen: false).userInfo.name ?? '',
        "idphoto": Provider.of<AuthProvider>(context, listen: false).userInfo.avatar,
        'idTo': houseId,
        'time_stamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': 1
      });
    });
  }

  Future uploadimage() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(houseId)
          .collection(houseId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("messages")
          .child(houseId)
          .child("image")
          .child("image" + ".jpg");
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      storageTaskSnapshot.ref.getDownloadURL().then((value) {
        documentReference.set({
          "image": value,
          'content': commentController.text,
          'idFrom': Provider.of<AuthProvider>(context, listen: false).userInfo.id,
          'idname': Provider.of<AuthProvider>(context, listen: false).userInfo.name ?? '',
          "idphoto": Provider.of<AuthProvider>(context, listen: false).userInfo.avatar,
          'idTo': houseId,
          'time_stamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'type': 1
        }).whenComplete(() => commentController.clear());
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onSendMessage(String content, int type) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(houseId)
          .collection('messages')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'sender_id': Provider.of<AuthProvider>(context, listen: false).userInfo.id,
            'sender_name': Provider.of<AuthProvider>(context, listen: false).userInfo.name ?? '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'message': content,
          },
        );
      });
      sendMessage(content, type);
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }


  void sendMessage(String content, int type) async {
    //send message to each group member
    // sendNotification(
    //     "${Provider.of<AuthProvider>(context, listen: false).userInfo.id} made a post on ${widget.peername}",
    //     widget.peername,
    //     memberId,
    //     token);
    // FirebaseFirestore.instance
    //     .collection('Pnoti')
    //     .doc("${widget.houseId}")
    //     .collection("messages")
    //     .doc("${widget.houseId}")
    //     .collection("messages")
    //     .doc(DateTime.now().millisecondsSinceEpoch.toString())
    //     .set({
    //   'read': false,
    //   'time_stamp': FieldValue.servertime_stamp(),
    // });
    //
    // var peerChatActivity = FirebaseFirestore.instance
    //     .collection("usersChatActivity")
    //     .doc(widget.houseId)
    //     .collection('activity')
    //     .doc(DateTime.now().millisecondsSinceEpoch.toString());
    //
    // peerChatActivity.set({'type': 'privete message'});
  }


  void sendNotification(
      String content, String heading, String token, String userId) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {
        "body": content,
        "title": heading,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'type': 'group',
        'user_id': '${Provider.of<AuthProvider>(context, listen: false).userInfo.id}',
        'user_name': '${Provider.of<AuthProvider>(context, listen: false).userInfo.name ?? ''}',
      },
      "to": '$token'
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAFHe5x28:APA91bGRWk-jLZKOeG_JHE4Ev8j2vLnNDWQJC95igthzVf4XICSivQ0TMq9i95CjBApQcMyzscCdtBpcObCHPN97usT1nC_SpLUaTZR1dHEYMNbNmNasH_DHMglh4TzJOMzj_Nnr9Shv'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth

      print('test ok push CFM');
    } else {
      print(' CFM error');
    }
  }



  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['sender_id'] == Provider.of<AuthProvider>(context, listen: false).userInfo.id) {
      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Delete message?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      )
                    ],
                  ));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: getHorizontalSize(
                    287,
                  ),
                  margin: getMargin(
                    left: 50,
                    top: 12,
                    right: 16,
                    bottom: 16,
                  ),
                  padding: getPadding(
                      all:20
                  ),
                  decoration: AppDecoration.fillOrangeA200.copyWith(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                    ),//BorderRadius.Only
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: getHorizontalSize(
                          243,
                        ),
                        margin: getMargin(
                          right: 11,
                        ),
                        child: ReadMoreText(
                          '${document['message']}' ?? '',
                          trimLines: 10,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '... Read more',
                          trimExpandedText: '... Show less',
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextRegular16WhiteA700,),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: getPadding(
                            top: 1,
                            bottom: 1,
                          ),
                          child: Text(
                            DateFormat('kk:mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    document['time_stamp'])),
                            style:   AppStyle.txtSFProTextMedium12Gray100.copyWith(
                              letterSpacing: getHorizontalSize(
                                0.06,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      );
    } else {
      return Padding(
        padding: getPadding(
          left: 16,
          top: 8,
          right: 40,
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse1340x40,
              height: getSize(
                32,
              ),
              width: getSize(
                32,
              ),
              radius: BorderRadius.circular(
                getHorizontalSize(
                  16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: getMargin(
                  left: 8,
                ),
                padding: getPadding(
                  left: 16,
                  top: 12,
                  right: 16,
                  bottom: 16,
                ),
                decoration: AppDecoration.outlineGray1002.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: getHorizontalSize(
                        225,
                      ),
                      margin: getMargin(
                        right: 21,
                      ),
                      child: ReadMoreText(
                          '${document['message']}' ?? '',
                          trimLines: 10,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '... Read more',
                          trimExpandedText: '... Show less',
                          style: AppStyle.txtSFProTextRegular16Gray800,),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: getPadding(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${document['sender_name']}',
                              style: AppStyle.txtSFProTextMedium12Gray500
                                  .copyWith(
                                fontSize:  getFontSize(12),
                                letterSpacing: getHorizontalSize(
                                  0.06,

                                ),
                              ),
                            ),
                            Text(
                              DateFormat('kk:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      document['time_stamp'])),
                              style: AppStyle.txtSFProTextMedium12Gray500
                                  .copyWith(
                                letterSpacing: getHorizontalSize(
                                  0.06,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }


  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white.withOpacity(0.02),
              ColorConstant.orangeA200.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
              ColorConstant.orangeA200.withOpacity(0.01),
            ],
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of Pchat
                  buildListMessage(),
                  Container(
                    width: double.maxFinite,
                    padding: getPadding(
                      top: 8,
                      bottom: 8,
                    ),
                    decoration: AppDecoration.outlineGray1003,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomIconButton(
                          height: 40,
                          width: 40,
                          margin: getMargin(
                            bottom: 16,
                          ),
                          variant: IconButtonVariant.OutlineOrangeA200,
                          shape: IconButtonShape.CircleBorder20,
                          child: CustomImageView(
                            svgPath: ImageConstant.imgTrashGray400,
                          ),
                        ),
                        CustomTextFormField(
                          width: getHorizontalSize(
                            231,
                          ),
                          focusNode: FocusNode(),
                          controller: textEditingController,
                          hintText: "Type here...",
                          margin: getMargin(
                            top: 2,
                            bottom: 18,
                          ),
                          variant: TextFormFieldVariant.FillGray100,
                          fontStyle: TextFormFieldFontStyle.SFProTextRegular16Gray500,
                          textInputAction: TextInputAction.done,
                        ),
                        CustomIconButton(
                          onTap: (){
                            onSendMessage(textEditingController.text, 0);
                          },
                          height: 40,
                          width: 40,
                          margin: getMargin(
                            bottom: 16,
                          ),
                          variant: IconButtonVariant.FillOrangeA200,
                          shape: IconButtonShape.CircleBorder20,
                          child: CustomImageView(
                            svgPath: ImageConstant.imgSend,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Loading
              buildLoading()
            ],
          ),
        ),
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: new Image.asset(
                  'assets/images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: new Image.asset(
                  'assets/images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: new Image.asset(
                  'assets/images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: new Image.asset(
                  'assets/images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: new Image.asset(
                  'assets/images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: new Image.asset(
                  'assets/images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: new Image.asset(
                  'assets/images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: new Image.asset(
                  'assets/images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              ElevatedButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: new Image.asset(
                  'assets/images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  color: Colors.black,
                  size: 30,
                ),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(houseId)
                  .collection('messages')
                  .orderBy('time_stamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: SpinKitThreeBounce(
                    color: Colors.black,
                    size: 30,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(index, snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

}
