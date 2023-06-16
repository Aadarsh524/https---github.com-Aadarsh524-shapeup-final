import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'apptheme/app_theme.dart';
import 'bloc/cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox('storage');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_47494fae63fd48158448b80bf362f95e',
      builder: (context, navigatorKey) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterCubit(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              title: 'Flutter Demo',
              theme: AppTheme.darkTheme,
              home: const SplashScreen(),
            ));
      },
    );
  }
}
