import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/providers.dart';

Future<void> signInCtrl(WidgetRef ref, String? email, String? password) async {
  try {
    toggleLoader(ref, true);
    log(ref.watch(appIsLoadingProvider).toString());
    await ref
        .read(firebaseAuthProvider)
        .signInWithEmailAndPassword(email: email!, password: password!);
    toggleLoader(ref, false);
  } on FirebaseAuthException catch (e) {
    log(e.toString());
    toggleLoader(ref, false);
    log(ref.watch(appIsLoadingProvider).toString());
    throw Exception(e.toString());
  } catch (e) {
    toggleLoader(ref, false);
    throw Exception(e.toString());
  }
}
