// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:app_flutter/viewmodels/auth_viewmodel.dart';
//
//
// class SessionMiddleware extends StatelessWidget {
//   final Widget protectedScreen;
//   const SessionMiddleware({super.key,required this.protectedScreen });
//
//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context);
//     authViewModel.checkSession().then((_){
//       if(authViewModel.user==null){
//         return Navigator.popAndPushNamed(context, '/login');
//       }
//     });
//     return  protectedScreen;
//   }
// }


import 'package:flutter/material.dart';
import 'package:app_flutter/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SessionMiddleware extends StatelessWidget {
  final Widget protectedScreen;

  const SessionMiddleware({super.key, required this.protectedScreen});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // Ejecutar la lógica de sesión después de que se haya construido el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authViewModel.checkSession().then((_) {
        if (authViewModel.user == null) {
          Navigator.popAndPushNamed(context, '/login');
        }
      });
    });

    return protectedScreen;
  }
}
