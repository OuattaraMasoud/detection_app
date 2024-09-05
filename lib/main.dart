import 'dart:async';

import 'package:detectionApp/constants.dart';
import 'package:detectionApp/controllers/menu_app_controller.dart';
import 'package:detectionApp/features/main/main_screen.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:detectionApp/simple_bloc_observer.dart';
import 'package:detectionApp/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/detection/views/views.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  if (kDebugMode) {
    Zone.root.runGuarded(() async {
      try {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then((value) => runApp(_buildApp()));
      } catch (error, stackTrace) {
        logger.e('Uncaught error: $error, StackTrace: $stackTrace');
      }
    });
    Bloc.observer = SimpleBlocObserver();
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(
        _buildApp(),
      ),
    );
  }
}

Widget _buildApp() {
  return DetectionApp();
}

class DetectionApp extends StatefulWidget {
  const DetectionApp({super.key});

  @override
  State<DetectionApp> createState() => _DetectionAppState();
}

class _DetectionAppState extends State<DetectionApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme:
                GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
                    .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuAppController(),
              ),
            ],
            child: MainScreen(),
          ),
        );
      },
    );
  }
}
