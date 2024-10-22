import 'package:app_flutter/viewmodels/auth_viewmodel.dart';
import 'package:app_flutter/views/home_view.dart';
import 'package:app_flutter/views/user/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/user/login_screen.dart';
import 'package:app_flutter/middelware/session_middleware.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> AuthViewModel()),
        ],
      child: MaterialApp(
        title: 'App de Usuarios',
        routes: {
          '/home': (context) => SessionMiddleware(protectedScreen: HomeScreen()),
          '/login': (context)=> const LoginScreen(),
          '/register': (context)=> const RegisterScreen()
        },
        initialRoute: '/home',
      ),
    );
  }
}
