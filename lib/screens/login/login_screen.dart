import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: kIsWeb
              ? const EdgeInsets.symmetric(horizontal: 3)
              : const EdgeInsets.symmetric(horizontal: 19),
          child: SizedBox(
            width: 480,
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email!)) {
                            return 'E-Mail Inválido';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password!.isEmpty || password.length < 7) {
                            return 'Senha Inválida';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          child: const Text('Esqueci minha Senha!'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: const Text(
                            'CRIAR   CONTA',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        text: 'Entrar',
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signIn(
                                      users: Users(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                      onFail: (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(error,
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                      });
                                }
                              },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
