import 'package:quote/cores/components/buttons/textbutton.dart';
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

        title: Text("Reset Password", style: AppTextStyle.textTheme.bodyLarge),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            height: ScreenSize.screenHeight(context) * 0.8,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    spacing: 25,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot your password?',
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            "Enter your phone number below and we’ll send you a code to reset your password.",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      PhoneNumberField(
                        phoneNumberController: phoneNumberController,
                        onChanged: (phone) {
                          setState(() {
                            fullPhoneNumber = phone.completeNumber;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextButton(
                              text: 'Resend Code',
                              onPressed: () async {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                MyButton(
                  onTap: resetPassword,
                  child: Text('Send Code', style: theme.textTheme.titleSmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
