import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button_styles.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);

    final loadingToTextFormField = !userManager.loading ||
        userManager.loadingGoogle ||
        userManager.loadingFace;

    final loadingToButton = userManager.loading ||
        userManager.loadingGoogle ||
        userManager.loadingFace;

    messengerToOnFail(error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error, style: const TextStyle(fontSize: 18)),
        backgroundColor: Colors.red,
      ));
    }

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
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    const Text(
                      'Entar com E-mail e Senha:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      enabled: loadingToTextFormField,
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
                      enabled: loadingToTextFormField,
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
                      onPressed: loadingToButton
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                userManager.signInWithEmailAndPassword(
                                    users: Users(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                    onFail: (error) {
                                      messengerToOnFail(error);
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    userManager.loadingFace
                        ? SpinKitChasingDots(
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          )
                        : SizedBox(
                            height: 40,
                            child: loadingToButton
                                ? null
                                : CustomTextButton(
                                icon: const Icon(FontAwesomeIcons.facebook),
                                text: '   Entrar com Facebook',
                                onPressed: () {
                                  userManager.loginOrSingUpWithFacebook(
                                      onFail: (error) {
                                    messengerToOnFail(error);
                                  }, onSuccess: () {
                                    Navigator.of(context).pop();
                                  });
                                },
                                style:
                                    CustomTextButtonStyles.buttonStyleFacebook),
                          ),
                    const SizedBox(height: 10),
                    userManager.loadingGoogle
                        ? SpinKitChasingDots(
                            color: Theme.of(context).primaryColor,
                            size: 30.0, // Tamanho do indicador
                          )
                        : SizedBox(
                            height: 37,
                            child: loadingToButton
                                ? null
                                : CustomTextButton(
                                imageAssetsTarget: "assets/logo/googleLogo.png",
                                text: '   Entrar com Google',
                                onPressed: () {
                                  userManager.loginOrSingUpWithGoogle(
                                      onFail: (error) {
                                    messengerToOnFail(error);
                                  }, onSuccess: () {
                                    Navigator.of(context).pop();
                                  });
                                },
                                style:
                                    CustomTextButtonStyles.buttonStyleGoogle),
                          )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
