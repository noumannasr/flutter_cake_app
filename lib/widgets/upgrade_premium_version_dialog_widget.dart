import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_texts.dart';
import 'package:flutter_cake_app/utils/utils.dart';
import 'package:flutter_cake_app/widgets/material_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpgradePremiumVersionDialogWidget extends StatelessWidget {
  const UpgradePremiumVersionDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'upgrade_premium_title'.tr(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text('upgrade_premium_subtitle'.tr()),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: Colors.green),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'upgrade_premium_point1'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                        TextSpan(
                          text: ' upgrade_premium_pointSubPoint1'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: Colors.green),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'upgrade_premium_point2'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                        TextSpan(
                          text: ' upgrade_premium_pointSubPoint2'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: Colors.green),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'upgrade_premium_point3'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                        TextSpan(
                          text: ' upgrade_premium_pointSubPoint3'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            MyButton(
              verticalMargin: 0,
              title: 'upgrade_premium_button_txt'.tr(),
              onTap: () => Utils.launchURL(
                Uri.parse(
                  AppText.paidAppUrl,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
