import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/pref_data.dart';
import '../../../../main.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../res/constant/app_routes_path.dart';
import '../../../../utils/themes.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onNumberPressed;

  const NumberPad({Key? key, required this.onNumberPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(16.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(10, (index) {
        if (index == 9) {
          // Button for number 0
          return buildNumberButton('0');
        }
        // Buttons for numbers 1-9
        return buildNumberButton('${index + 1}');
      }),
    );
  }

  Widget buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => onNumberPressed(number),
      child: Text(
        number,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  List<String> pinCode = List.filled(4, '');
  List<String> firstpinCode = List.filled(4, '');
  List<String> secondpinCode = List.filled(4, '');

  bool iscorrect = false;
  bool isfail = false;
  bool isnull = true;
  bool isfirstpin = false;
  bool issecondpin = false;
  bool isauth = false;
  bool incorrectpin = false;
  late String name;
  late String pincodevalue;

  @override
  void initState() {
    super.initState();
    _loadTextFieldValue();
    checkGenderAndShowDialog(context);
  }

  Future<void> _loadTextFieldValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String textFieldValue = prefs.getString('firstname') ?? '';
    String pincodeValue = prefs.getString('pincode') ?? '';
    setState(() {
      name = textFieldValue;
      pincodevalue = pincodeValue;
    });
  }

  Future<void> checkGenderAndShowDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pincode = prefs.getString('pincode');

    if (pincode == null || pincode.isEmpty) {
      setState(() {
        isauth = false;
        isfirstpin = true;
        issecondpin = false;
      });
    } else {
      setState(() {
        isauth = true;
      });
    }
  }

  void onNumberPressed(String number) {
    bool updated = false;
    for (int i = 0; i < pinCode.length; i++) {
      if (pinCode[i].isEmpty && !updated) {
        setState(() {
          pinCode[i] = number;
          updated = true;
          if (i == 3) {
            // Check if PIN code is complete

            String enteredPin = pinCode.join();

            if (enteredPin == pincodevalue) {
              setState(() {
                iscorrect = true;
                isfail = false;
                isnull = true;
              });

              Future.delayed(Duration(seconds: 1), () {
                Get.toNamed(RoutesPath.bottomBarPage);
              });
            } else {
              setState(() {
                iscorrect = false;
                isfail = true;
                isnull = false;
              });
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  pinCode.fillRange(0, 4, '');
                  isnull = true;
                  iscorrect = false;
                  isfail = false;
                  isnull = true;
                });
              });
              Get.snackbar(
                'Error',
                'Incorrect pin',
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              );
            }
          }
        });
      }
    }
  }

  void onTestNumberPressed(String number) {
    bool updated = false;
    for (int i = 0; i < firstpinCode.length; i++) {
      if (firstpinCode[i].isEmpty && !updated) {
        setState(() {
          firstpinCode[i] = number;
          updated = true;
          if (i == 3) {
            // Check if PIN code is complete
            String enteredPin =
                firstpinCode.join(); // Combine PIN digits into a string
            setState(() {
              isfirstpin = false;
              issecondpin = true;
            });
          }
        });
      }
    }
  }

  Future<void> onTestsecondNumberPressed(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    bool updated = false;
    for (int i = 0; i < secondpinCode.length; i++) {
      if (secondpinCode[i].isEmpty && !updated) {
        setState(() async {
          secondpinCode[i] = number;
          updated = true;
          if (i == 3) {
            // Check if PIN code is complete
            String enteredPin =
                secondpinCode.join(); // Combine PIN digits into a string
            String enteredsecondPin =
                firstpinCode.join(); // Combine PIN digits into a string
            if (enteredPin == enteredsecondPin) {
              setState(() {
                iscorrect = true;
                isfail = false;
                isnull = true;
              });
              await prefs?.setString('pincode', '$enteredsecondPin');
              await supabase.from('welcome_pin').insert({
                'pin': "$enteredsecondPin",
                'user_id': "$id",
              }).execute();
              PrefData.setLogin(false);
              Future.delayed(Duration(seconds: 1), () {
                Get.toNamed(RoutesPath.bottomBarPage);
              });
            } else {
              setState(() {
                iscorrect = false;
                isfail = true;
                isnull = false;
              });
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  pinCode.fillRange(0, 4, '');
                  firstpinCode.fillRange(0, 4, '');
                  secondpinCode.fillRange(0, 4, '');
                  isnull = true;
                  isfail = false;
                  isfirstpin = true;
                  issecondpin = false;
                });
                Get.snackbar(
                  'Error',
                  'Pin do not match, try again',
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                );
              });
            }
          }
        });
      }
    }
  }

  void onBackspacePressed() {
    for (int i = pinCode.length - 1; i >= 0; i--) {
      if (pinCode[i].isNotEmpty) {
        setState(() {
          pinCode[i] = '';
        });
        break;
      }
    }
  }

  void onTestBackspacePressed() {
    for (int i = firstpinCode.length - 1; i >= 0; i--) {
      if (firstpinCode[i].isNotEmpty) {
        setState(() {
          firstpinCode[i] = '';
        });
        break;
      }
    }
  }

  void onSecondTestBackspacePressed() {
    for (int i = secondpinCode.length - 1; i >= 0; i--) {
      if (secondpinCode[i].isNotEmpty) {
        setState(() {
          secondpinCode[i] = '';
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonMethods.nullAppBar(
          context,
          statusBarColor: Colors.transparent,
        ),
        body: Center(
          child: isauth
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonMethods.sizedBox(height: 38.h),
              RichText(
                text: TextSpan(
                  text: 'Welcome back,',
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'SF Pro Display',
                    color: Themes.getTextColor(context),
                  ),
                  children: [
                    TextSpan(
                      text: '$name',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w500,
                        color: Themes.getPrimaryColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              CommonMethods.sizedBox(height: 20.h),
              CommonMethods.appTexts(
                context,
                'Enter your pin',
                color: Themes.getTextColor(context),
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              CommonMethods.sizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < pinCode.length; i++)
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isfail
                                ? Colors.red
                                : iscorrect
                                ? Colors.green
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        pinCode[i],
                        style: TextStyle(
                            fontSize: 24,

                            color: Themes.getTextColor(context)),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: List.generate(
                  10,
                      (index) => Container(
                    padding: EdgeInsets.all(20), // Adjust padding as needed
                    child: SizedBox(

                      child: TextButton(
                        onPressed: () => onNumberPressed(index.toString()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                          side: MaterialStateProperty.all(BorderSide(
                            color: Colors.grey.withOpacity(0.2), // Border color
                            width: 1.0,          // Border width
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0), // Border radius
                            ),
                          ),
                        ),
                        child: Text(index.toString(), style: TextStyle(  fontWeight: FontWeight.bold,fontSize: 20, color: Themes.getPrimaryColor(context),)), // Adjust font size as needed
                      ),
                    ),
                  ),
                )..add(
                  Container(
                    padding: EdgeInsets.all(20), // Adjust padding as needed
                    child: SizedBox(
                      child: TextButton(
                        onPressed: onBackspacePressed,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                          side: MaterialStateProperty.all(BorderSide(
                            color: Colors.grey.withOpacity(0.2), // Border color
                            width: 1.0,          // Border width
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0), // Border radius
                            ),
                          ),
                        ),
                        child: Icon(Icons.backspace, size: 24, color: Themes.getPrimaryColor(context),), // Adjust icon size as needed
                      ),
                    ),
                  ),
                ),
              ),


            ],
          )
              : Column(
            children: [
              isfirstpin
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonMethods.sizedBox(height: 38.h),
                  CommonMethods.appTexts(
                    context,
                    'Insert your pin',
                    color: Themes.getPrimaryColor(context),
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CommonMethods.sizedBox(height: 20.h),
                  CommonMethods.appTexts(
                    context,
                    'Enter transaction pin',
                    color: Themes.getTextColor(context),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CommonMethods.sizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                      i < firstpinCode.length;
                      i++)
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isfail
                                    ? Colors.red
                                    : iscorrect
                                    ? Colors.green
                                    : Colors.grey),
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            firstpinCode[i],
                            style: TextStyle(
                                fontSize: 24,
                                color: Themes.getTextColor(
                                    context)),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: List.generate(
                      10,
                          (index) => Container(
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(

                          child: TextButton(
                            onPressed: () => onNumberPressed(index.toString()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Text(index.toString(), style: TextStyle(  fontWeight: FontWeight.bold,fontSize: 20, color: Themes.getPrimaryColor(context),)), // Adjust font size as needed
                          ),
                        ),
                      ),
                    )..add(
                      Container(
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(
                          child: TextButton(
                            onPressed: onBackspacePressed,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Icon(Icons.backspace, size: 24, color: Themes.getPrimaryColor(context),), // Adjust icon size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Container(),
              issecondpin
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonMethods.sizedBox(height: 38.h),
                  CommonMethods.appTexts(
                    context,
                    'Confirm your pin',
                    color: Themes.getPrimaryColor(context),
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CommonMethods.sizedBox(height: 20.h),
                  CommonMethods.appTexts(
                    context,
                    'Confirm your new pin',
                    color: Themes.getTextColor(context),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  CommonMethods.sizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                      i < secondpinCode.length;
                      i++)
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isfail
                                    ? Colors.red
                                    : iscorrect
                                    ? Colors.green
                                    : Colors.grey),
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            secondpinCode[i],
                            style: TextStyle(
                                fontSize: 24,
                                color: Themes.getTextColor(
                                    context)),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: List.generate(
                      10,
                          (index) => Container(
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(

                          child: TextButton(
                            onPressed: () => onNumberPressed(index.toString()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Text(index.toString(), style: TextStyle(  fontWeight: FontWeight.bold,fontSize: 20, color: Themes.getPrimaryColor(context),)), // Adjust font size as needed
                          ),
                        ),
                      ),
                    )..add(
                      Container(
                        padding: EdgeInsets.all(20), // Adjust padding as needed
                        child: SizedBox(
                          child: TextButton(
                            onPressed: onBackspacePressed,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
                              side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.withOpacity(0.2), // Border color
                                width: 1.0,          // Border width
                              )),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0), // Border radius
                                ),
                              ),
                            ),
                            child: Icon(Icons.backspace, size: 24, color: Themes.getPrimaryColor(context),), // Adjust icon size as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
