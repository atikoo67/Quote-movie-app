import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:quote/cores/utils/constant/screen_size.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController? phoneNumberController;
  final ValueChanged<PhoneNumber>? onChanged;

  const PhoneNumberField({
    super.key,
    required this.phoneNumberController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntlPhoneField(
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: theme.scaffoldBackgroundColor,

        searchFieldInputDecoration: InputDecoration(
          fillColor: theme.colorScheme.primary,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          label: Text('Search country'),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: theme.textTheme.bodySmall,
        ),
        listTilePadding: EdgeInsets.symmetric(vertical: 2),
        countryNameStyle: theme.textTheme.bodySmall,
        countryCodeStyle: theme.textTheme.bodySmall,
        width: ScreenSize.screenWidth(context) * 0.7,
      ),
      controller: phoneNumberController,
      dropdownTextStyle: theme.textTheme.labelMedium,
      style: theme.textTheme.titleSmall,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),

        labelStyle: theme.textTheme.titleSmall,
        // hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        filled: true,
        labelText: 'Phone Numbers',
      ),
      initialCountryCode: 'ET', // Ethiopia
      // Ethiopia
      onChanged: onChanged,
    );
  }
}
