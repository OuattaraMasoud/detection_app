import 'package:detectionApp/constants.dart';
import 'package:detectionApp/features/auth/bloc/login_bloc.dart';
import 'package:detectionApp/features/main/main_screen.dart';
import 'package:detectionApp/global_app/cubit/global_app_cubit.dart';
import 'package:detectionApp/repositories/repository.dart';
import 'package:detectionApp/services/dio_service.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:detectionApp/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LoginPageView";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Connexion",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: "Nom d'utilisateur",
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez votre nom d'utilisateur";
                    }
                    if (value.length < 6) {
                      return "Enterez un nom d'utilisateur valide";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Entrez votre mot de passe";
                    }
                    if (value.length < 6) {
                      return "Le mot de passe doit contenir au minimum 6 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Mot de passe oublié?",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      _handleLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Connexion",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      _isLoading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: PlatformCircularProgressIndicator(),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    final email = _userNameController.text;
    final password = _passwordController.text;
    print("username: $email, Password: $password");
    Map<String, dynamic> data = {"username": email, "password": password};
    locator<GlobalAppCubit>().startLoading();
    context.read<LoginBloc>().add(LogUser(userData: data));
  }
}
