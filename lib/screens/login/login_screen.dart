import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button_styles.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              : const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
          child: SizedBox(
            width: 380,
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      const Text(
                        'Entar com E-mail e Senha:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 14),
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
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                          child: Text(
                            'Não tem conta? Cadastre-se!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        text: 'Entrar',
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signInWithEmailAndPassword(
                                      users: Users(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                      onFail: (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
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
                      const Divider(
                        indent: 2,
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Ou entre com sua conta:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: CustomTextButton(
                            icon: const Icon(FontAwesomeIcons.facebook),
                            text: '   Entrar com Facebook',
                            onPressed: () {
                              userManager.loginWithFacebook(
                                  onFail: (error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                      content: Text(error,
                                      style: const TextStyle(fontSize: 18)),
                                  backgroundColor: Colors.red,
                                ));
                              }, onSuccess: () {
                                Navigator.of(context).pop();
                              });
                            },
                            style: CustomTextButtonStyles.buttonStyleFacebook),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 37,
                        child: CustomTextButton(
                            imageAssetsTarget: "assets/logo/googleLogo.png",
                            text: '   Entrar com Google',
                            onPressed: () {
                              userManager.googleLogin();
                            },
                            style: CustomTextButtonStyles.buttonStyleGoogle),
                      )
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
