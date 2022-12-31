import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: AppColor.redColor,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              AppString.appName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Theme.of(context)
                      .copyWith(primaryColor: AppColor.whiteColor)
                      .primaryColor),
            ),
            Text(
              AppString.appTitle,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context)
                      .copyWith(primaryColor: AppColor.goldenColor)
                      .primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
