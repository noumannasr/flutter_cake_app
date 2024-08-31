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
              'Upgrade to Premium Version',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
                'Enjoy an ad-free experience! Install our Premium version from the Play Store to support our development and remove ads for a seamless experience.'),
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
                          text: 'Ad-free experience:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),

                        TextSpan(
                          text: ' Enjoy uninterrupted usage without annoying ads.',
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
                          text: 'Support the developers:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),

                        TextSpan(
                          text: ' Contribute to the continued development and improvement of our app.',
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
                          text: 'Priority support:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: GoogleFonts.montserrat().fontFamily),
                        ),

                        TextSpan(
                          text: ' Get faster and more personalized assistance.',
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
              title: 'Install Now',
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
