import 'package:flutter/material.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/config/constants.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/config/styles.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/entity/screen_navigation_mode.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/ui/common_view/two_modes_switcher.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  ScreenNavigationMode _selectedMode = ScreenNavigationMode.server;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select mode:'),
                const SizedBox(width: 36.0),
                Flexible(
                  child: TwoModeSwitcher(
                    leftValue: const Text('CLIENT'),
                    rightValue: const Text('SERVER'),
                    switchInitValue: true,
                    onValueChanged: (value) {
                      _selectedMode = value
                          ? ScreenNavigationMode.server
                          : ScreenNavigationMode.client;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56.0),
            FloatingActionButton.extended(
              onPressed: () => _onClickStart(),
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Start',
                  style: CommonTextStyle.textStyleNormal
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onClickStart() {
    switch (_selectedMode) {
      case ScreenNavigationMode.server:
        Navigator.of(context).pushNamed(mServerPath);
        break;
      case ScreenNavigationMode.client:
        Navigator.of(context).pushNamed(mClientPath);
        break;
    }
  }
}
