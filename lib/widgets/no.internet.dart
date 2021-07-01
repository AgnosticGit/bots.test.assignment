import 'package:bots/stores/global.store.dart';
import 'package:bots/utils/constants/color.constant.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  Widget build(BuildContext context) {
    if (GlobalStore.to.internetDisconnected) {
      return IgnorePointer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 60.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: ColorConstant.mainAppColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Reconnecting',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  const SizedBox(width: 15.0),
                  CircularProgressIndicator(backgroundColor: Colors.white)
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
