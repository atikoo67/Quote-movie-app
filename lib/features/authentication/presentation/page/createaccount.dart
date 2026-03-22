import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/features/movie/presentation/widgets/buttons/checkboxbutton.dart';
import 'package:quote/features/movie/presentation/widgets/notifier/mysnackbar.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/cores/utils/theme/textstyle.dart';
import 'package:quote/features/movie/presentation/widgets/buttons/mybutton.dart';
import 'package:quote/features/movie/presentation/widgets/textfields/mytextfield.dart';
import 'package:quote/features/movie/presentation/widgets/textfields/passwordtextfield.dart';
import 'package:quote/features/movie/presentation/widgets/textfields/phonenumber_field.dart';
import 'package:quote/features/movie/presentation/widgets/buttons/textbutton.dart';

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
            MySnackbar.showSnack(
              context,
              "Dear ${userNamecontroller.text.trim()}, You're Registered successfully",
              Colors.green[800],
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInChecker()),
            );
          }
        }
      } else {
        if (mounted) {
          MySnackbar.showSnack(
            context,
            "All fields are required! Please fill in all inputs",
            Colors.red[800],
          );
        }
      }
    } on FirebaseAuthException catch (_) {
      if (mounted) {
        MySnackbar.showSnack(
          context,
          "Something went wrong, please try again",
          Colors.red[800],
        );
      }
    } catch (_) {
      if (mounted) {
        MySnackbar.showSnack(
          context,
          "Something went wrong, please try again",
          Colors.red[800],
        );
      }
    }
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset("assets/launch_icon/my_logo.png", height: 50),
                    const SizedBox(height: 10),
                    Text(
                      AppStrings.appName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Create Your Free Account',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join now to unlock unlimited movies & shows',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              PhoneNumberField(
                phoneNumberController: phoneNumberController,
                onChanged: (phone) {
                  setState(() {
                    fullPhoneNumber = phone.completeNumber;
                  });
                },
              ),
              const SizedBox(height: 15),
              MyTextField(label: 'Username', controller: userNamecontroller),
              const SizedBox(height: 15),
              PasswordTextField(
                label: 'Password',
                controller: passwordController,
                validator: (value) {
                  if (value!.isNotEmpty && value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              PasswordTextField(
                label: 'Confirm Password',
                controller: confirmController,
                validator: (value) {
                  if (value!.isNotEmpty && passwordController.text != value) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MyCheckBox(
                subtitle: MyTextButton(
                  text: 'Terms & Conditions and Privacy Policy',
                  onPressed: () {
                    MySnackbar.showSnack(
                      context,
                      "Terms and conditions are not provided yet",
                      Colors.red[800],
                    );
                  },
                ),
                title: Text(
                  "By continuing, you agree to our",
                  style: theme.textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 30),
              MyButton(
                onTap: signUp,

                child: Center(
                  child: Text(
                    'Register',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member?', style: theme.textTheme.bodyMedium),
                  MyTextButton(
                    text: 'Login Here',
                    onPressed: widget.showLoginPage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
