import 'package:flutter/material.dart';
import 'package:app_flutter/viewmodels/auth_viewmodel.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  final String name;
  final String email;

  const UpdateScreen({super.key, required this.name, required this.email});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();


  // Definir los campos del formulario
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores de widget
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);

    _passwordController = TextEditingController(); // Campo vacío para la contraseña
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'La contraseña no debe ir vacía'),
    MinLengthValidator(8, errorText: 'La contraseña debe tener al menos 8 caracteres'),
    PatternValidator(r'^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$', errorText: 'La contraseña debe tener entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula y al menos una mayúscula.'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'El Correo es requerido'),
    EmailValidator(errorText: 'El texto del campo debe ser un Correo'),
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es requerido'),
    MinLengthValidator(10, errorText: 'El Nombre debe tener al menos 10 caracteres'),
  ]);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de texto para el nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre Completo'),
                validator: nameValidator,
              ),
              SizedBox(height: 16), // Espacio entre campos
              // Campo de texto para el correo electrónico
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                validator: emailValidator,
              ),
              SizedBox(height: 16), // Espacio entre campos
              // Campo de texto para la contraseña
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: passwordValidator,
              ),
              SizedBox(height: 20), // Espacio antes del botón
              authViewModel.loading
                  ? CircularProgressIndicator() // Muestra un indicador de carga
                  : ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si el formulario es válido, proceder a actualizar
                    authViewModel.update(
                      _emailController.text,
                      _nameController.text,
                      _passwordController.text
                    ).then((value) {
                      if (authViewModel.user != null) {
                        // Si la actualización fue exitosa, regresa a la pantalla anterior
                        print(authViewModel.user);
                        Navigator.pop(context);
                      } else {
                        // Aquí puedes manejar errores de actualización si es necesario
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error al actualizar la información.')),
                        );
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.check_sharp, size: 18),
                label: Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Asegúrate de liberar los controladores cuando ya no se necesiten
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
