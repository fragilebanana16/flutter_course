import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepCard<T> extends StatelessWidget {
  StepCard({
    super.key,
    required this.isChosen,
    required this.value,
    required this.title,
    this.subTitle = '',
    required this.icon,
    required this.onChoosen,
  });

  final bool isChosen;
  final T value;
  final String subTitle;
  final IconData icon;
  final ValueChanged<T> onChoosen;
  String title = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChoosen(value),
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isChosen ? Color(0xff005819) : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        child: SizedBox(
          height: 76.h,
          child: Row(
            children: [
              Icon(
                icon,
                color: isChosen ? Color(0xff005819) : Colors.black,
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xff262626),
                      ),
                    ),
                    subTitle != ''
                        ? Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Color(0xffA8A8A8),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              16.horizontalSpace,
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isChosen ? Color(0xff005819) : Colors.black,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isChosen ? Color(0xff005819) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
