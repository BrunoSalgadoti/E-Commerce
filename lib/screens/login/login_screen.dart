import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button_styles.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
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
      CustomScaffoldMessenger(context: context, message: error).msn();
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      controller: emailController,
                      enableTextEdit: loadingToTextFormField,
                      hintText: 'E-mail',
                      textInputType: TextInputType.emailAddress,
                      autocorrect: false,
                      isDense: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return 'E-Mail Inválido';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    CustomTextFormField(
                      controller: passwordController,
                      enableTextEdit: loadingToTextFormField,
                      hintText: 'Senha',
                      autocorrect: false,
                      isDense: false,
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 7) {
                          return 'Campo Obrigatório';
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                                    icon:
                                        const Icon(FontAwesomeIcons.facebook),
                                    text: '   Entrar com Facebook',
                                    onPressed: () {
                                      userManager.loginOrSingUpWithFacebook(
                                          onFail: (error) {
                                        messengerToOnFail(error);
                                      }, onSuccess: () {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    style: CustomTextButtonStyles
                                        .buttonStyleFacebook),
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
                                    imageAssetsTarget:
                                        "assets/icons/googleLogo.svg",
                                    text: '   Entrar com Google',
                                    isSvg: true,
                                    onPressed: () {
                                      userManager.loginOrSingUpWithGoogle(
                                          onFail: (error) {
                                        messengerToOnFail(error);
                                      }, onSuccess: () {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    style: CustomTextButtonStyles
                                        .buttonStyleGoogle),
                          )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
