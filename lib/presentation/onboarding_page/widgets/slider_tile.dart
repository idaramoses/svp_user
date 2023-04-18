import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svp_admin_pm/core/app_export.dart';

class SliderTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color textcolor;

  SliderTile({this.imagePath, this.title, this.description, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // new SvgImage.asset(
                //   imagePath,
                //   new Size(100.0, 100.0),
                // ),
                new SvgPicture.asset(
                  imagePath,
                  height: ScreenUtil().setHeight(400),
                ),
                Center(
                  child: Container(
                    width: ScreenUtil().setHeight(800),
                    padding: EdgeInsetsDirectional.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0)),
                        color: Colors.white.withOpacity(0.1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                color: ColorConstant.orangeA200,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(62)),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(40)),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
