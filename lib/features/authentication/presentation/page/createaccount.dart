import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/buttons/mybutton.dart';
import 'package:quote/cores/components/textfields/mytextfield.dart';
import 'package:quote/cores/components/textfields/passwordtextfield.dart';
import 'package:quote/cores/components/textfields/phonenumber_field.dart';
import 'package:quote/cores/components/buttons/textbutton.dart';

import 'package:flutter/material.dart';
import 'package:quote/features/authentication/presentation/config_login/signinchecker.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';

class CreateAccount extends StatefulWidget {
  final VoidCallback showLoginPage;
  const CreateAccount({super.key, required this.showLoginPage});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final userNamecontroller = TextEditingController();
  final confirmController = TextEditingController();
  String? fullPhoneNumber;
  bool termsAccepted = false;
  final db = FirebaseFirestore.instance;
  Future signUp() async {
    try {
      final fakeEmail = "phone.$fullPhoneNumber@royalmovie.com";

      final isRegistered = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: fakeEmail,
            password: passwordController.text.trim(),
          );

      final uid = isRegistered.user?.uid;

      if (uid != null) {
        final userData = {
          "phonenumber": fullPhoneNumber,
          "username": userNamecontroller.text.trim(),
          "email": fakeEmail,
        };

        await db.collection("users").doc(uid).set(userData);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInChecker()),
          );
        }
      } else {}
    } on FirebaseAuthException catch (error) {
    } catch (e) {}
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    confirmController.dispose();
    passwordController.dispose();
    super.dispose();
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
          'Create Account',
          style: TextStyle(
            fontSize: ScreenSize.screenHeight(context) * 0.025,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
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
                      width: ScreenSize.screenWidth(context),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Icon(
                        Icons.person_pin_rounded,
                        size: ScreenSize.screenHeight(context) * 0.0550,
                        color: theme.iconTheme.color,
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.screenHeight(context) * 0.78,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.screenHeight(context) * 0.040,
                        ),

                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal:
                                        ScreenSize.screenWidth(context) * 0.03,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing:
                                        ScreenSize.screenHeight(context) *
                                        0.010,
                                    children: [
                                      Text(
                                        'Hey there!',
                                        style: TextStyle(
                                          fontSize:
                                              ScreenSize.screenHeight(context) *
                                              0.028,
                                          fontWeight: FontWeight.w500,
                                          color: theme
                                              .textTheme
                                              .displayLarge!
                                              .color,
                                        ),
                                      ),
                                      Text(
                                        " Start your journey with us — it's fast, free, and easy.",
                                        style: TextStyle(
                                          fontSize:
                                              ScreenSize.screenHeight(context) *
                                              0.016,
                                          // fontWeight: FontWeight.w500,
                                          color: theme
                                              .textTheme
                                              .displayMedium!
                                              .color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Form(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenSize.screenHeight(context) *
                                              0.025,
                                        ),
                                        child: PhoneNumberField(
                                          phoneNumberController:
                                              phoneNumberController,
                                          onChanged: (phone) {
                                            setState(() {
                                              fullPhoneNumber =
                                                  phone.completeNumber;
                                            });
                                          },
                                        ),
                                      ),
                                      MyTextField(
                                        label: 'Usernmae',
                                        controller: userNamecontroller,
                                      ),
                                      PasswordTextField(
                                        // hintText: 'Enter your Password',
                                        label: 'Password',
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value!.isNotEmpty &&
                                              value.length < 8) {
                                            return "your password must be greater than 8 digit";
                                          }
                                          return null;
                                        },
                                      ),
                                      PasswordTextField(
                                        // hintText: 'Confirm your Password',
                                        label: 'Confirm Password',
                                        controller: confirmController,
                                        validator: (value) {
                                          if (value!.isNotEmpty &&
                                              passwordController.text !=
                                                  value) {
                                            return 'the confirmation password is not correct';
                                          }
                                          return null;
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CheckboxListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,

                                              title: Text(
                                                'Accept terms & Conditions.',
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.w500,
                                                  color: theme
                                                      .textTheme
                                                      .displayMedium!
                                                      .color,
                                                ),
                                              ),
                                              value: termsAccepted,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  termsAccepted = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Column(
                              spacing: ScreenSize.screenHeight(context) * 0.010,
                              children: [
                                MyButton(
                                  onTap: signUp,
                                  child: Text(
                                    'Register',
                                    style: AppTextStyle.textTheme.titleMedium,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 3,
                                  children: [
                                    Text(
                                      'i am a member!',
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize.screenHeight(context) *
                                            0.018,
                                        color: theme
                                            .textTheme
                                            .displayMedium!
                                            .color,
                                      ),
                                    ),

                                    MyTextButton(
                                      text: 'Login Here',
                                      onPressed: widget.showLoginPage,
                                    ),
                                  ],
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
