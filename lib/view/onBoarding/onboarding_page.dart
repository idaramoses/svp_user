import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/res/constant/app_strings.dart';
import 'package:sharkhub/view/login/main/login_page.dart';
import 'package:sharkhub/view/signup/view/signup_page.dart';

import '../../res/common/app_button.dart';
import '../../res/common/app_methods.dart';
import '../../utils/themes.dart';
import 'controller/onboarding_controller.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  List<Widget> _pages = [
    _buildImage(AppImages.slider_image_1, 'Title 1', 'Subtitle 1'),
    _buildImage(AppImages.slider_image_2, 'Title 2', 'Subtitle 2'),
    _buildImage(AppImages.eletricity_meter , 'Title 3', 'Subtitle 3'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonMethods.nullAppBar(
          context,
          statusBarColor: Colors.transparent,

        ),
        body: GetBuilder(
          builder: (onBoardingController) {
            return Stack(
              children: [
                // Expanded(
                //   child: PageView.builder(
                //     scrollDirection: Axis.horizontal,
                //     controller: onBoardingController.controller,
                //     onPageChanged: (value) {
                //       onBoardingController.changeIndex(value);
                //     },
                //     itemCount: onBoardingData.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       OnBoardModel data = onBoardingData[index];
                //       return Column(
                //         children: [
                //           Expanded(
                //             child: CommonMethods.imagesOfApp(
                //               data.image!,
                //               fit: BoxFit.fill,
                //               width: double.infinity,
                //             ),
                //           ),
                //           CommonMethods.sizedBox(height: 78.h),
                //           CommonMethods.appTexts(
                //             context,
                //             data.onboardTag!,
                //             textAlign: TextAlign.center,
                //             color: Themes.getTextColor(context),
                //             fontSize: 28.sp,
                //             fontWeight: FontWeight.w700,
                //           ),
                //           CommonMethods.sizedBox(height: 16.h),
                //           CommonMethods.appTexts(
                //             context,
                //             AppText.obDes,
                //             textAlign: TextAlign.center,
                //             color: Themes.getTextColor(context),
                //             fontSize: 16.sp,
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                // CommonMethods.sizedBox(height: 24.h),
                // Obx(
                //   () {
                //     return DotsIndicator(
                //       dotsCount: 3,
                //       position: onBoardingController.pageIndex.value,
                //       decorator: DotsDecorator(
                //         color: const Color(0xFFDBE5F2),
                //         activeColor: Themes.getPrimaryColor(context),
                //         size: Size(8.h, 8.h),
                //         activeSize: Size(8.h, 8.h),
                //         spacing: EdgeInsets.only(right: 8.w),
                //       ),
                //     );
                //   },
                // ),
                // // ignore: unrelated_type_equality_checks
                // CommonMethods.sizedBox(
                //     height: onBoardingController.pageIndex ==
                //             onBoardingData.length - 1
                //         ? 57.h
                //         : 38.h),
                // Padding(
                //   padding: CommonMethods.appPadding(),
                //   child: GestureDetector(
                //     onTap: () {
                //       if (onBoardingController.pageIndex.value <
                //           (onBoardingData.length - 1)) {
                //         onBoardingController.controller.jumpToPage(
                //             ++onBoardingController.pageIndex.value);
                //       } else {
                //         PrefData.setIntro(false);
                //         CommonMethods.sendToNextScreen(
                //             context, RoutesPath.loginPage);
                //       }
                //     },
                //     child: AppButton(
                //       text: onBoardingController.pageIndex.value <
                //               (onBoardingData.length - 1)
                //           ? AppText.next
                //           : AppText.getStart,
                //     ),
                //   ),
                // ),

                // CommonMethods.sizedBox(height: 40.h),
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: _pages,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 550.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _currentPage == 0
                              ? Column(
                            children: [
                              CommonMethods.appTexts(
                                context,
                                'Welcome to Sparkhup',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CommonMethods.sizedBox(height: 16.h),
                              CommonMethods.appTexts(
                                context,
                                'Simplify Your Electricity Payments',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              CommonMethods.sizedBox(height: 15.h),
                            ],
                          )
                              : _currentPage == 1
                              ? Column(
                            children: [
                              CommonMethods.appTexts(
                                context,
                                'Track Your Usage',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CommonMethods.sizedBox(
                                  height: 16.h),
                              CommonMethods.appTexts(
                                context,
                                'Stay Informed, Save More',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              CommonMethods.sizedBox(
                                  height: 15.h),
                            ],
                          )
                              : Column(
                            children: [
                              CommonMethods.appTexts(
                                context,
                                'Hassle-Free Payments',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CommonMethods.sizedBox(
                                  height: 16.h),
                              CommonMethods.appTexts(
                                context,
                                'Pay Anytime, Anywhere',
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          CommonMethods.sizedBox(height: 30.h),
                          _buildPageIndicator(),
                          CommonMethods.sizedBox(height: 30.h),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => LogInPage(),
                                  duration: Durations.extralong1,
                                  transition: Transition.downToUp);
                            },
                            child: const AppButton(
                              text: 'Login',
                            ),
                          ),
                          CommonMethods.sizedBox(height: 30.h),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignUpPage(),
                                  duration: Durations.extralong1,
                                  transition: Transition.downToUp);
                            },
                            child: Container(
                              height: 54.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(64.r),
                                color: Colors.transparent,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: AppText.already,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF Pro Display',
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppText.signup,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(() => SignUpPage(),
                                              duration:
                                              Durations.extralong1,
                                              transition:
                                              Transition.downToUp);
                                        },
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "SF Pro Display",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CommonMethods.sizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          init: OnBoardingController(),
        ),
      ),
    );
  }

  static Widget _buildImage(String imagePath, String title, String subtitle) {
    return FadeTransition(
      opacity: AlwaysStoppedAnimation(1),
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    // Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),

                  ],
                  stops: [0.0, 0.5], // Adjust the stops as needed
                ),
              ),
              child: SizedBox.expand(), // Ensures the box fills the entire container
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return DotsIndicator(
      dotsCount: _pages.length,
      position: _currentPage.round(), // Convert to integer
      decorator: DotsDecorator(
        color: Colors.white.withOpacity(0.4), // Inactive dot color
        activeColor: Themes.getPrimaryColor(context), // Active dot color
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        spacing: const EdgeInsets.symmetric(horizontal: 4.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
