import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_flutter/viewmodels/auth_viewmodel.dart';
import 'package:app_flutter/views/user/update_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/artworks-yzNuGkvkb8zQNVyU-BFXBgA-t500x500.jpg'),
              radius: 60,
            ),
            SizedBox(height: 10),
            Text(
              '@${authViewModel.user?.name}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${authViewModel.user?.email}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(
                          name: authViewModel.user?.name ?? '', // Pasa el nombre del usuario
                          email: authViewModel.user?.email ?? '', // Pasa el email del usuario
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(Icons.edit, size: 18),
                  label: Text('Actualizar información'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}