import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/search_bar.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/contact_backup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final Map<String, VoidCallback?> pages = {
  "Contact Backup": () => Get.to(() => ContactBackup()),
  "Guitar Tuner": () => {},
  "Todo List": () => {},
  "RGB Convertor": () => {},
  "Guitar Chords": () => {},
  "Recorded Music Chords": () => {},
  "3D stuff": () => {},
  "Medical Kit": () => {},
  "Fix Stuff": () => {},
  "Charts": () => {},
  "Favorite": () => {},
  "My Tech Stack": () => {},
};

class ToolBoxHomeView extends StatelessWidget {
  const ToolBoxHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 54.h, 24.w, 29.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Contacts",
                        ),
                      ),
                      SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: IconButton(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 22.h),
                  searchBar(),
                  SizedBox(height: 30.h),
                  _RecentlyUsed()
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(24.w, 44.h, 26.w, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC4C4C4).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, -4), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.separated(
                  itemCount: pages.length,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (c, index) {
                    return _ListItem(
                        name: pages.keys.elementAt(index),
                        callback: pages[pages.keys.elementAt(index)]);
                  },
                  separatorBuilder: (c, i) {
                    return SizedBox(height: 24.h);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String name;
  final VoidCallback? callback;

  const _ListItem({required this.name, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback,
        child: SizedBox(
          width: 340.w,
          height: 60.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                    width: 60.h,
                    height: 60.h,
                    color: Color.fromRGBO(
                      Random().nextInt(256),
                      Random().nextInt(256),
                      Random().nextInt(256),
                      1,
                    )),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "14:23",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xffA8A8A8),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      Flexible(
                        child: Text(
                          "Lorem Ipsum",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class _RecentlyUsed extends StatelessWidget {
  const _RecentlyUsed();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recently Used",
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 60.r,
          width: 359.w,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: pages.length,
            itemBuilder: (c, i) {
              return SizedBox(
                width: 59.r,
                height: 59.r,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                            width: 56.r,
                            height: 56.r,
                            color: Color.fromRGBO(
                              Random().nextInt(256),
                              Random().nextInt(256),
                              Random().nextInt(256),
                              1,
                            )),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18.r,
                        height: 18.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.r),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16.w,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AppStyles {
  static var addressBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey),
  );
  static var underLineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static var focusedTransparentBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  );
  static var energyBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}

TextStyle errorTextStyle(context) => TextStyle(
    fontSize: 10.sp,
    color: Theme.of(context).colorScheme.error,
    fontWeight: FontWeight.w500,
    height: 1.4);
