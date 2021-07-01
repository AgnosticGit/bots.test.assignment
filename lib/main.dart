import 'package:bots/modules/bottom.nav.bar/views/bottom.nav.bar.dart';
import 'package:bots/stores/global.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:bots/widgets/loader.dart';
import 'package:bots/widgets/no.internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: ColorConstant.mainAppColor),
      home: GetBuilder<GlobalStore>(
        init: GlobalStore(),
        builder: (_) {
          return Stack(
            children: [
              BottomNavBar(),
              Loader(),
              NoInternet(),
            ],
          );
        },
      ),
    );
  }
}
