import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cake_app/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// common widget for button
class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool disableButton;
  final bool loading;
  final double? margin;
  final Color? bgColor;
  final Color? titleColor;
  final Color? borderColor;
  final bool enableBorder;
  final double? height;
  final double? width;
  final bool? isShowIcon;
  final String? assetName;
  final double? borderRadius;
  final double? titleSize;
  final double? verticalMargin;
  final bool decoration;

  const MyButton({
    Key? key,
    this.disableButton = false,
    this.loading = false,
    this.margin,
    required this.title,
    required this.onTap,
    this.bgColor,
    this.titleColor,
    this.borderColor,
    this.enableBorder = false,
    this.height,
    this.width,
    this.isShowIcon = false,
    this.assetName,
    this.borderRadius,
    this.titleSize,
    this.verticalMargin,
    this.decoration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: disableButton || loading ? null : onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      highlightShape: BoxShape.rectangle,
      containedInkWell: true,
      borderRadius: BorderRadius.circular(borderRadius ?? 48.r),
      child: Container(
        height: height ?? 48.h,
        width: width ?? double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: margin ?? 24.w, vertical: verticalMargin ?? 10.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: disableButton
                  ? AppColors.lightGreyColor
                  : borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 48.r),
          color: disableButton
              ? AppColors.lightGreyColor
              : bgColor ?? AppColors.primaryColor,
          // border: enableBorder ? Border.all(color: borderColor ?? secondaryAppColor(context)) : null,
        ),
        alignment: Alignment.center,
        child: loading
            ? SizedBox(
                key: const Key('circularIndicator'),
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2.w,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isShowIcon == true) ...[
                    SvgPicture.asset(
                      key: const Key('isShowIcon'),
                      assetName!,
                      height: 28.h,
                      width: 28.h,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    title.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: disableButton
                              ? AppColors.darkBlack
                              : titleColor ?? AppColors.darkBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: titleSize ?? 16.sp,
                          decoration: decoration
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor: titleColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.textColor,
  });

  final VoidCallback onTap;
  final String title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          title.tr(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.darkBlack),
        ),
      ),
    );
  }
}
