import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/onboarding_page/widgets/slider_tile.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key}) : super(key: key);
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? ColorConstant.orangeA200 : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  SliderTile(
                    imagePath: mySLides[0].getImageAssetPath(),
                    title: mySLides[0].getTitle(),
                    description: mySLides[0].getDesc(),
                    textcolor: mySLides[0].getColor(),
                  ),
                  SliderTile(
                    imagePath: mySLides[1].getImageAssetPath(),
                    title: mySLides[1].getTitle(),
                    description: mySLides[1].getDesc(),
                    textcolor: mySLides[1].getColor(),
                  ),
                  SliderTile(
                    imagePath: mySLides[2].getImageAssetPath(),
                    title: mySLides[2].getTitle(),
                    description: mySLides[2].getDesc(),
                    textcolor: mySLides[2].getColor(),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: ScreenUtil().setHeight(450),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 3; i++)
                          i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        slideIndex == 2
                            ? Container()
                            : SizedBox(
                                width: ScreenUtil().setHeight(250),
                                height: ScreenUtil().setHeight(120),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.signinScreen);
                                  },
                                  splashColor: Colors.black12,
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: ColorConstant.orangeA200,
                                      fontSize: ScreenUtil().setSp(35),
                                    ),
                                  ),
                                ),
                              ),
                        slideIndex == 2
                            ? SizedBox(
                                width: ScreenUtil().setHeight(250),
                                height: ScreenUtil().setHeight(120),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.signinScreen);
                                  },
                                  child: Text('Start',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  color: ColorConstant.orangeA200,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: ColorConstant.orangeA200,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              )
                            : SizedBox(
                                width: ScreenUtil().setHeight(250),
                                height: ScreenUtil().setHeight(120),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.signinScreen);
                                  },
                                  child: Text('Next',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(35),
                                          fontWeight: FontWeight.bold)),
                                  color: ColorConstant.orangeA200,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: ColorConstant.orangeA200,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;
  Color textcolor;

  SliderModel({this.imageAssetPath, this.title, this.desc, this.textcolor});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setColor(Color getColor) {
    textcolor = getColor;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  Color getColor() {
    return textcolor;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "In-app messaging feature lets you easily contact your Project Manager or admin for easy communication of ideas");
  sliderModel.setTitle("Communicate");
  sliderModel.setImageAssetPath("assets/images/ob_1.svg");
  sliderModel.setColor(Colors.white);

  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Option to upload reports for easy collaboration and tracking of project progress");
  sliderModel.setTitle("Collaborate");
  sliderModel.setImageAssetPath("assets/images/ob_2.svg");
  sliderModel.setColor(Colors.black);
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "Verification and approval of tasks by a qualified team and also you the user to ensure 100% integrity");
  sliderModel.setTitle("Succeed");
  sliderModel.setImageAssetPath("assets/images/ob_3.svg");
  sliderModel.setColor(Colors.white);
  slides.add(sliderModel);

  return slides;
}
