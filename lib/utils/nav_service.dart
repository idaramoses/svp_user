import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/auth/signin/state/auth_provider.dart';
import '../presentation/profile_screen/state/profile_provider.dart';
import 'app_local_storage.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> logOut() async {
    AppLocalStorage _appLocalStorage = new AppLocalStorage();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(navigatorKey.currentContext, listen: false);
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(
        navigatorKey.currentContext,
        listen: false);
    authProvider.token;
    await _appLocalStorage.store("token", "");

    //save customer data in store
    authProvider.userInfo = null;
    profileProvider.userInfo = null;
    await _appLocalStorage.store("user", null);

    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil("/signin_screen", (Route r) => r == null);
  }
}
