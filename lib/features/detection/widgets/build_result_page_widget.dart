import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildResultPageWidget(BuildContext context, Function()? onClose) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Positioned(
        top: 0,
        right: 20,
        child: IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            color: Colors.pink,
          ),
        ),
      ),
      GestureDetector(
        onTap: onClose,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.black.withOpacity(0.3), // Dark overlay
          ),
        ),
      ),
      // This is the content that will appear on top of the blurred background
      Center(
        child: Container(
          width: 0.9.sw,
          height: 0.85.sh,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                10), // Ensure the image respects the border radius
            child: Image.asset(
              'assets/images/result.jpg',
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
          ),
        ),
      ),
    ],
  );
}
