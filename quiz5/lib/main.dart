import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/auth_bloc.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loading_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          print("error");
        }
        if(snapshot.connectionState == ConnectionState.done){
          return Provider(
            create: (context) => AuthBloc(),
            child: MaterialApp(
              title: 'HuntersGame',
              theme: ThemeData.dark(),
              home: LoginScreen(),
            ),
          );
        }
        return MaterialApp(
          title: 'HuntersGame',
          theme: ThemeData.dark(),
            home: LoadingScreen(),
        );
      },
    );
  }
}

