import 'package:apex_demo/constants/font_size.dart';
import 'package:apex_demo/provider/login_provider.dart';
import 'package:apex_demo/services/app_localization.dart';
import 'package:apex_demo/ui/common_widgets/custom_textfield.dart';
import 'package:apex_demo/ui/common_widgets/language_popup.dart';
import 'package:apex_demo/ui/common_widgets/popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<LoginProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.language,
                color: Colors.grey[800],
              ),
              onPressed: () => PopupDialog.show(context, LanguagePopup.show(context)),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 0.2.sh,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/game_tv.jpg")),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: "Username",
                    errorText: validationService.username.error,
                    isPasswordField: false,
                    onChanged: (String value) {
                      validationService.changeUsername(value);
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    labelText: "Password",
                    errorText: validationService.password.error,
                    isPasswordField: true,
                    onChanged: (String value) {
                      validationService.changePassword(value);
                    },
                  ),
                  SizedBox(height: 10.h),
                  validationService.error.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Text(
                            validationService.error,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.small,
                            ),
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(AppLocalization.of(context)!.translate("login_label")),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          onPressed: (validationService.isValid) ? () => validationService.submitForm(context) : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
