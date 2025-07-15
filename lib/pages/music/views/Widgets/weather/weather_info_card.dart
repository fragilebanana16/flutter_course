import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  InfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      elevation:
          0, //ThemeColors.isDark ? 0 : 1, //only elevate if not dark mode
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: kInfoCardTitle.copyWith(
                    color: Theme.of(context).primaryColorDark)),
            SizedBox(
              height: 2,
            ),
            Text(value == "null" ? "-" : value,
                style: kInfoCardInfoText.copyWith(
                    color: Theme.of(context).primaryColorLight)),
          ],
        ),
      ),
    );
  }
}
