import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../theme/app_style.dart';
import '../../../../utils/app_local_storage.dart';
import '../../../../utils/flushbar_mixin.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_image_view.dart';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:svp_admin_pm/utils/nav_service.dart';

import '../../../main_dashboard/user_dashboard.dart';
import '../../../notifications_one_screen/Notification_screen.dart';



class AddEditArticle extends StatefulWidget {
  final String id;

  AddEditArticle({this.id});

  @override
  _AddArticleState createState() => _AddArticleState(id: this.id);
}

class _AddArticleState extends State<AddEditArticle> with FlushBarMixin{
  String id;
  int editId;
  TextEditingController titleController = TextEditingController();
  File videoFile;
  String category;
  String audienceName;
  bool isInit = false;
  bool isLoading = false;
  bool imageAdded = false;
  bool videoAdded = false;
  List<Asset> images = [];
  Dio dio =  Dio();

  _AddArticleState({this.id});



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Text('Attachments', style: AppStyle.txtSFProTextRegular16Gray800.copyWith(fontWeight: FontWeight.w700),),
                    Divider(),
                    SizedBox(height: getVerticalSize(10),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomButton(
                            height: getVerticalSize(
                              34,
                            ),
                            width: getHorizontalSize(
                              175,
                            ),
                            fontStyle: ButtonFontStyle.SFProTextBold12,
                            text: "Select image",
                            variant: ButtonVariant.OutlineOrangeA200,
                            padding: ButtonPadding.PaddingT9,
                            suffixWidget: Container(
                              margin: getMargin(
                                left: 6,
                              ),
                              child: Icon(Icons.add_photo_alternate,color:ColorConstant.orangeA200,),
                            ),
                            onTap: () => loadAssets(),
                          ),
                        ),
                        SizedBox(height: getVerticalSize(10),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment :MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRect(
                                child: Container(
                                    color: Colors.grey[300],
                                    height: getVerticalSize(300),
                                    width: getHorizontalSize(300),
                                    child: (images.length > 0)
                                        ? buildGridView()
                                        :  Icon(
                                      Icons.image,
                                      size: 20,
                                      color: Colors.grey[600],
                                    )),
                              ),
                              images.length > 0 || videoFile != null
                                  ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      images = [];
                                      videoFile = null;
                                      imageAdded = false;
                                      videoAdded = false;
                                    });
                                  })
                                  : SizedBox(),
                              images.length > 0
                                  ? IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    loadAssets();
                                  })
                                  : SizedBox()
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: getVerticalSize(10),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: isLoading ? Center(child: CircularProgressIndicator(color: ColorConstant.orangeA200,)): CustomButton(
                  height: getVerticalSize(
                    34,
                  ),
                  width: getHorizontalSize(
                    175,
                  ),
                  text: "Upload Attachment",
                  variant: ButtonVariant.FillOrangeA200,
                  padding: ButtonPadding.PaddingT9,
                  suffixWidget: Container(
                    margin: getMargin(
                      left: 6,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgUpload,
                    ),
                  ),
                  onTap: () => submitPost(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 50,
            height: 50,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        materialOptions: MaterialOptions(
            actionBarColor: "#000000", statusBarColor: "#000000"),
        maxImages: 10,
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      print(resultList);
      imageAdded = true;
    });
  }

  void submitPost() async {
    const BASE_URL = 'https://svp.hypen.blog/';
    String id = widget.id;
    String upload_urll = BASE_URL+ 'admin/tasks/update/' + id;
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      {
       if(images != null){
         for(var i = 0; i < images.length; i++){
           ByteData byteData = await images[i].getByteData();
           List<int> imageData = byteData.buffer.asInt8List();

           MultipartFile multipartFile = MultipartFile.fromBytes(
             imageData,
             filename: images[i].name,
             contentType: MediaType('image', 'jpg' ),
           );

           FormData formData = FormData.fromMap({
             'attachments': multipartFile,
           }
           );
            var resonse = await dio.post(upload_urll,data: formData,  options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),);
            if(resonse.statusCode == 200){
              print(resonse.data);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Notificationloader(
                    id: widget.id,
                    type: 'task',
                    isupload : true,
                  )));
            }
            else{
              showErrorNotification(
                  context, "Error Uploading Attachment");
            }
         }
       }
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  getToken() async {
    String token = await AppLocalStorage().fetch("token");
    if (token != null) return token;
    return "";
  }

}
