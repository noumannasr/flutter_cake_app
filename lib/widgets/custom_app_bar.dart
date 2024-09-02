import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_cake_app/svg_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackText;
  final VoidCallback? onGoBack;
  final String backTitle;
  final Color? bgColor;
  final Widget? ifThereIsWidget;
  final double? newHeight;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.isShowBackText = false,
      this.onGoBack,
      this.backTitle = 'back',
      this.bgColor,
      this.ifThereIsWidget,
      this.newHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? AppColors.secondaryColor,
      automaticallyImplyLeading: false,
      surfaceTintColor: bgColor ?? AppColors.secondaryColor,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 26.h),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  if (onGoBack == null) {
                    Navigator.pop(context);
                    return;
                  }
                  onGoBack!();
                },
                child: SvgPicture.asset(SvgAssets.backIcon,colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),),
              ),
              if (isShowBackText)
                GestureDetector(
                  onTap: () {
                    if (onGoBack == null) {
                      Navigator.pop(context);
                      return;
                    }
                    onGoBack!();
                  },
                  child: Text(
                    backTitle.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              Expanded(
                child: Text(
                  title.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: isShowBackText ? 68.w : 30.w),
            ],
          ),
          ifThereIsWidget ?? Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(newHeight ?? 48.h);
}
