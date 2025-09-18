import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/cores/components/buttons/mybutton.dart';
import 'package:quote/cores/components/textfields/passwordtextfield.dart';
import 'package:quote/cores/components/textfields/phonenumber_field.dart';
import 'package:quote/cores/components/buttons/textbutton.dart';
import 'package:quote/features/authentication/presentation/config_login/signinchecker.dart';
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
    } on Exception catch (otherError) {}
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

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/launch_icon/my_logo.png", height: 40),
            Text(AppStrings.appName, style: AppTextStyle.textTheme.bodyLarge),
          ],
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            height: ScreenSize.screenHeight(context) * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 180),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        spacing: 20,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Login there!',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  'Enter your details to jump back in. We missed you!😊',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
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
                              PasswordTextField(
                                label: 'Password',
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length < 8) {
                                    return "your password must be greater than 8 digit";
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyTextButton(
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
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 4,
                            children: [
                              Text(
                                'don\'t have an Account?',
                                style: theme.textTheme.bodySmall,
                              ),
                              MyTextButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
