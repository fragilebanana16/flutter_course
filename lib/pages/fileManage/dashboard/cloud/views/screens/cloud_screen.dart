library cloud;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/pages/fileManage/constants/app_constants.dart';
import 'package:flutter_course/pages/fileManage/shared_components/card_cloud.dart';
import 'package:flutter_course/pages/fileManage/shared_components/card_folder.dart';
import 'package:flutter_course/pages/fileManage/shared_components/search_button.dart';
import 'package:flutter_course/pages/fileManage/utils/helpers/app_helpers.dart';
import 'package:get/get.dart';

// binding
part '../../bindings/cloud_binding.dart';

// controller
part '../../controllers/cloud_controller.dart';

// model
part '../../models/folder_data.dart';

// component
part '../components/card_data.dart';
part '../components/header.dart';
part '../components/card_service.dart';

class CloudScreen extends GetView<CloudController> {
  const CloudScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultSpacing),
                    child: _Header(),
                  ),
                  _CardService(),
                  SizedBox(height: kDefaultSpacing),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultSpacing),
                    child: Text(
                      "Folder",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            _CardData(folderData: controller.folderData)
          ],
        ),
      ),
    );
  }
}
