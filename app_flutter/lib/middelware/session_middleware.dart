import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_flutter/viewmodels/auth_viewmodel.dart';


class SessionMiddleware extends StatelessWidget {
  final Widget protectedScreen;
  const SessionMiddleware({super.key,required this.protectedScreen });

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    authViewModel.checkSession().then((_){
      if(authViewModel.user==null){
        return Navigator.popAndPushNamed(context, '/login');
      }
    });
    return  protectedScreen;
  }
}
