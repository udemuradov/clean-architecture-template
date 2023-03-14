import 'dart:io';
import 'package:clean_arch_template/src/presentation/views/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/config/themes/app_themes.dart';
import 'src/core/utils/app_constants.dart';
import 'src/injector.dart';
import 'src/config/blocs/providers.dart';
import 'src/config/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDependencies();

  // welcome screen

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: BlocProviders.providers,
        child: MaterialApp(
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          debugShowCheckedModeBanner: false,
          title: kMaterialAppTitle,
          // navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          initialRoute: '/',
          onUnknownRoute: AppRoutes.onUnkownRoute,
          theme: AppTheme.tmtrade,
          builder: (BuildContext context, Widget? child) {
            final textScaleFactor =
                MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1);
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaleFactor: textScaleFactor),
                child: child ?? const NavigationPage());
          },
        ));
  }
}
