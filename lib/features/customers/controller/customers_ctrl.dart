import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/providers.dart';
import 'package:go_shop_admin_panel/model/user.dart';

final fetchCustomersProvider = FutureProvider((ref) {
  return ref.read(firestoreProvider).collection('users').get().then((value) {
    return value.docs.map((e) => GoShopUser.fromMap(e.data())).toList();
  });
});