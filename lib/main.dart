import 'dart:async';
import 'package:detectionApp/features/auth/bloc/login_bloc.dart';
import 'package:detectionApp/global_app/cubit/global_app_cubit.dart';
import 'package:detectionApp/loader_overlay.dart';
import 'package:detectionApp/repositories/repository.dart';
import 'package:detectionApp/spinKitRing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:detectionApp/constants.dart';
import 'package:detectionApp/controllers/menu_app_controller.dart';
import 'package:detectionApp/features/main/main_screen.dart';
import 'package:detectionApp/router.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:detectionApp/simple_bloc_observer.dart';
import 'package:detectionApp/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/auth/views/login.dart';
import 'services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  Bloc.observer = SimpleBlocObserver();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const DetectionApp());
}

class DetectionApp extends StatelessWidget {
  const DetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) {
            final _detectionRepository = locator<DetectionRepository>();
            return LoginBloc(_detectionRepository);
          },
        ),
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            scaffoldMessengerKey: notificationServiceSnackBarKey,
            onGenerateRoute: generateRoute,
            supportedLocales: const [Locale("fr")],
            navigatorKey: locator<NavigationService>().navigationKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme: GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme,
              ).apply(),
              canvasColor: secondaryColor,
            ),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
