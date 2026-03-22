import 'package:firebase_auth/firebase_auth.dart';
import 'package:quote/features/movie/presentation/widgets/notifier/mysnackbar.dart';
import 'package:quote/cores/utils/constant/strings.dart';
import 'package:quote/features/movie/presentation/widgets/buttons/mybutton.dart';
import 'package:quote/features/movie/presentation/widgets/textfields/passwordtextfield.dart';
import 'package:quote/features/movie/presentation/widgets/textfields/phonenumber_field.dart';
import 'package:quote/features/movie/presentation/widgets/buttons/textbutton.dart';
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
      if (mounted) {
        MySnackbar.showSnack(
          context,
          error.message!.contains("incorrect")
              ? "Password or Phone number is incorrect"
              : "Something went wrong, please try again",
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
              const SizedBox(height: 50),
              Text(
                'Welcome Back!',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Log in and pick up where you left off',
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: MyTextButton(
                  text: 'Forgot Password?',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgetPassword()),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: signIn,

                child: Center(
                  child: Text(
                    'Login',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: theme.textTheme.bodyMedium,
                  ),
                  MyTextButton(
                    text: 'Register Here',
                    onPressed: widget.showSignupPage,
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
