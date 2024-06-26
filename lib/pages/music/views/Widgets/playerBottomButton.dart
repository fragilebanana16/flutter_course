import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';

class PlayerBottomButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const PlayerBottomButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                icon,
                width: 30,
                height: 30,
                color: ChillifyColor.primary,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: TColor.secondaryText, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
