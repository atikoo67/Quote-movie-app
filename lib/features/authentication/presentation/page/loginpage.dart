import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/widgets/mybutton.dart';
import 'package:quote/cores/widgets/passwordtextfield.dart';
import 'package:quote/cores/widgets/phonenumber_field.dart';
import 'package:quote/cores/widgets/textbutton.dart';
import 'package:quote/features/authentication/presentation/config_login/signinchecker.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/features/authentication/presentation/page/forgetpassword.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignupPage;
  const LoginPage({super.key, required this.showSignupPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  String? incorrect;
  String? fullPhoneNumber;
  Future signIn() async {
    final authenticateEmail = "phone.$fullPhoneNumber@royalmovie.com";
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authenticateEmail,
        password: passwordController.text.trim(),
      );
      if (credential != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInChecker()),
        );
      }
    } on FirebaseAuthException catch (error) {
      print("the error >>>>>>${error.message}<<<<<<<");
    } on Exception catch (otherError) {
      print(
        "the error encountered except auth <>>>>>>>>>>>>>>>>>>>>>.${otherError.toString()}<<<<<<<<<<<<<<<<<<<<<<<<<",
      );
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
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
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: theme.textTheme.displayLarge!.color,
        backgroundColor: theme.scaffoldBackgroundColor,

        title: Text(
          'Login',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
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
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Center(
                        child: Icon(
                          Icons.person_pin_rounded,
                          size: ScreenSize.screenHeight(context) * 0.055,
                          color: theme.iconTheme.color,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.screenHeight(context) * 0.75,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 60),
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
                                    horizontal:
                                        ScreenSize.screenHeight(context) *
                                        0.025,
                                  ),
                                  child: Column(
                                    spacing:
                                        ScreenSize.screenHeight(context) *
                                        0.010,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        'Enter your details to jump back in. We missed you! 😊\n',
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

                                Column(
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
                                            // print(fullPhoneNumber); // e.g. +251912345678
                                          });
                                        },
                                      ),
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
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenSize.screenHeight(context) *
                                            0.025,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MyTextButton(
                                            fontSize:
                                                ScreenSize.screenHeight(
                                                  context,
                                                ) *
                                                0.014,
                                            text: 'Forgot Password?',
                                            onPressed: () =>
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgetPassword(),
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              spacing: 15,
                              children: [
                                MyButton(
                                  onTap: signIn,
                                  child: Text(
                                    'Login',
                                    style: AppTextStyle.textTheme.titleMedium,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 3,
                                  children: [
                                    Text(
                                      'don\'t have an Account?',
                                      style: TextStyle(
                                        color: theme
                                            .textTheme
                                            .displayMedium!
                                            .color,
                                        fontSize:
                                            ScreenSize.screenHeight(context) *
                                            0.018,
                                      ),
                                    ),
                                    MyTextButton(
                                      fontSize:
                                          ScreenSize.screenHeight(context) *
                                          0.018,
                                      text: 'Register here',
                                      onPressed: widget.showSignupPage,
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
