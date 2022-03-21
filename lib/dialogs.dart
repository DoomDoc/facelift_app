import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'main.dart';
import 'premium/sample_laborer/get_labor.dart';

void showImageDialogBox(BuildContext context, String image) =>
    showAnimatedDialog(
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(image),
                )
              ],
            ),
          ),
        );
      },
    );

Future<void> showSimpleAnimatedDialogBox(
    BuildContext context, String name, int duration, String image) async {
  showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: duration), () {
        Navigator.of(context).pop(true);
      });
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/modals/$image",
                      )),
                ),
              ),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: true,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.linear,
    duration: const Duration(milliseconds: 400),
  );
}

Future<void> showAnimatedDialogBox(BuildContext context, String name,
    bool barier, int duration, String image, bool cross, int n) async {
  showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: duration), () {
        Navigator.of(context).pop(true);
        n != 1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const GetLaborerScreen())))
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const MyApp())),
                (route) => false,
              );
      });
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: cross ? 10 : 0),
              cross
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop(true);
                              n != 1
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const GetLaborerScreen())))
                                  : Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const MyApp())),
                                      (route) => false,
                                    );
                            },
                            child: const Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/modals/$image",
                      )),
                ),
              ),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    barrierDismissible: barier ? true : false,
    animationType: DialogTransitionType.slideFromBottom,
    curve: Curves.linear,
    duration: const Duration(seconds: 1),
  );
}
