import 'package:flutter/material.dart';
import 'blocs/auth_bloc.dart';
import 'loading_screen.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
                Buttons.Google,
                onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                  return LoadingScreen();}), (route) => false),
            ),
            SignInButton(
                Buttons.Facebook,
                onPressed: () => authBloc.loginFacebook(),
            ),
            SignInButton(
                Buttons.Twitter,
                onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                  return LoadingScreen();}), (route) => false),
            ),
          ],
        ),
      ),
    );
  }
}