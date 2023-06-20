import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../consts/textstyle.dart';
import '../services/utils.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              duration: const Duration(milliseconds: 500),
              size: 60,
              color: Colors.grey,
            ),
            Text(
              "Please wait",
              style: kTextStyle(20, context),
            )
          ],
        ),
      ),
    );
  }
}
