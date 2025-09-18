import 'dart:ui';

import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/buttons/mybutton.dart';
import 'package:quote/cores/components/textfields/phonenumber_field.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final phoneNumberController = TextEditingController();
  String? fullPhoneNumber;
  Future resetPassword() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: theme.textTheme.displayLarge!.color,
        backgroundColor: theme.scaffoldBackgroundColor,

        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: ScreenSize.screenHeight(context) * 0.025,
            fontWeight: theme.textTheme.displayLarge!.fontWeight,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Stack(
            children: [
              Positioned(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/background.jpg',
                      fit: BoxFit.cover,
                      height: ScreenSize.screenHeight(context) * 0.89,
                      width: MediaQuery.of(context).size.width,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 3,
                        tileMode: TileMode.mirror,
                      ),
                      child: Container(
                        height: ScreenSize.screenHeight(context) * 0.89,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenSize.screenHeight(context) * 0.89,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Icon(
                        Icons.person_pin_rounded,
                        size: ScreenSize.screenHeight(context) * 0.0800,
                        color: theme.iconTheme.color,
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.screenHeight(context) * 0.78,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          spacing: ScreenSize.screenHeight(context) * 0.010,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Forgot your password? Don\'t Worry!',
                                    style: TextStyle(
                                      fontSize:
                                          ScreenSize.screenHeight(context) *
                                          0.021,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          theme.textTheme.displayLarge!.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "Please provide your registered phone number. We’ll send you a verification code to reset your password.",
                                style: TextStyle(
                                  fontSize:
                                      ScreenSize.screenHeight(context) * 0.016,
                                  fontWeight: FontWeight.w500,
                                  color: theme.textTheme.displayMedium!.color,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenSize.screenHeight(context) * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSize.screenHeight(context) * 0.025,
                              ),
                              child: PhoneNumberField(
                                phoneNumberController: phoneNumberController,
                                onChanged: (phone) {
                                  setState(() {
                                    fullPhoneNumber = phone.completeNumber;
                                    // print(fullPhoneNumber); // e.g. +251912345678
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyButton(
                                  onTap: resetPassword,
                                  child: Text(
                                    'Send',
                                    style: AppTextStyle.textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
