import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/consts/routes.dart';
import 'package:go_shop_admin_panel/core/providers.dart';
import 'package:go_shop_admin_panel/features/auth/views/admin_sign_in.dart';
import 'package:go_shop_admin_panel/features/dashboard/views/dashboard.dart';
import 'package:go_shop_admin_panel/firebase_options.dart';
import 'package:go_shop_admin_panel/services/theme_prefs.dart';
import 'package:go_shop_admin_panel/shared/loader.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: Sizer(
        builder: (_, __, ___) {
          return ShadApp.material(
            theme: ShadThemeData(
              colorScheme: ShadSlateColorScheme.light(),
              brightness: Brightness.light,
            ),
            home: MyApp(),
          );
        },
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ref
            .watch(authStateProvider)
            .when(
              data: (user) {
                if (user != null) {
                  return Dashboard();
                }
                return AdminSignIn();
              },
              error: (e, __) {
                return Scaffold(body: Center(child: Text(e.toString())));
              },
              loading: () {
                return Scaffold(body: Center(child: Loader()));
              },
            ),
        if (ref.watch(appIsLoadingProvider)) Loader(),
      ],
    );
  }
}
