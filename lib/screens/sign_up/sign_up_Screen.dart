import 'package:ecommerce/helpers/validators.dart';
import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Users users = Users(password: '', email: '', userName: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: kIsWeb
              ? const EdgeInsets.symmetric(horizontal: 3)
              : const EdgeInsets.symmetric(horizontal: 19),
          child: SizedBox(
            width: 500,
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Nome Completo'
                        ),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.text,
                        validator: (nome) {
                          if (nome!.isEmpty) {
                            return 'Campo obrigatório!';
                          } else if (nome.trim().split(' ').length <= 1) {
                            return 'Preencha seu nome completo!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (name) => users.userName = name!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'E-mail'
                        ),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (!emailValid(email)) {
                            return 'E-mail inválido';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (email) => users.email = email!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Senha'
                        ),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (password.length < 7) {
                            return 'Senha deve conter no mínimo 7 caracteres';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (password) => users.password = password!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Repita a Senha'
                        ),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (password.length < 7) {
                            return 'Senha deve conter no mínimo 7 caracteres';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (password) => users.confirmPassword = password,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                     CustomButton(
                          texto: 'Criar Conta',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              if (users.password != users.confirmPassword) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar( SnackBar(
                                      content: const Text(
                                          'Confirmação de Senha não confere!!'
                                              'Tente Redigitar a Senha e a '
                                              'confirmação da Senha',
                                      style: TextStyle(fontSize: 18)),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 5),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(15),
                                ));
                                return;
                              }
                              userManager.singUp(users: users,
                                  onFail: (error){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                          content: Text(
                                              'Falha ao cadastrar $error',
                                          style: const TextStyle(
                                              fontSize: 18
                                          )),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 5),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)
                                      ),
                                      margin: const EdgeInsets.all(15),
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
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
