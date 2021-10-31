import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:quiz5/services/auth_service.dart';

class AuthBloc{
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User?> get currentUser => authService.currentUser;
  loginFacebook() async{
    print("Starting facebook login");
    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]
    );

    switch (res.status){
      case FacebookLoginStatus.success:
        print("login work");
        break;
      case FacebookLoginStatus.cancel:
        print("login cancled");
        break;
      case FacebookLoginStatus.error:
        print("login error");
        break;
    }
  }

}