import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/cores/components/buttons/checkboxbutton.dart';
import 'package:quote/cores/utils/constant/strings.dart';
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
      if (passwordController.text.isNotEmpty &&
          confirmController.text.isNotEmpty &&
          userNamecontroller.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  spacing: 20,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 3,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Text(
                            'Create Your Free Account',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            " Join Now to Unlock Unlimited Movies & Shows",
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
                              });
                            },
                          ),
                        ),
                        MyTextField(
                          label: 'Usernmae',
                          controller: userNamecontroller,
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
                        PasswordTextField(
                          label: 'Confirm Password',
                          controller: confirmController,
                          validator: (value) {
                            if (value!.isNotEmpty &&
                                passwordController.text != value) {
                              return 'the confirmation password is not correct';
                            }
                            return null;
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 8,
                          ),
                          child: MyCheckBox(
                            subtitle: MyTextButton(
                              text: 'Terms & Conditions and Privacy Policy.',
                              onPressed: () {},
                            ),

                            title: Text(
                              "By continuing, you agree to our ",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  spacing: 10,
                  children: [
                    MyButton(
                      onTap: signUp,
                      child: Text(
                        'Register',
                        style: theme.textTheme.titleSmall,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 3,
                      children: [
                        Text(
                          'i am a member!',
                          style: theme.textTheme.bodySmall,
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
      ),
    );
  }
}
