import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/policy_and_documents_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';
import 'package:brn_ecommerce/common/button/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Users users = Users(email: '');

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);
    final policyAndDocuments = Provider.of<PolicyAndDocuments>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                margin: kIsWeb
                    ? const EdgeInsets.symmetric(horizontal: 3)
                    : const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
                            hintText: 'Preencha com seu nome completo',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.text,
                          validator: (name) {
                            if (name!.isEmpty || name == '') {
                              return 'Campo obrigatório!';
                            } else if (name.trim().split(' ').length <= 1) {
                              return 'Preencha seu nome completo!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (name) => users.userName = name!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'E-mail',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email!.isEmpty || email == '') {
                              return 'Campo Obrigatório';
                            } else if (!emailValid(email)) {
                              return 'E-mail inválido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (email) => users.email = email!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Telefone (Opcional)',
                            hintText: '(00) 00000-0000',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.number,
                          validator: (phone) {
                            if (phone!.isNotEmpty && phone.length < 11) {
                              return 'Confira o número digitado!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (phone) => users.phoneNumber = phone!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            hintText: '*******',
                            hintStyle: TextStyle(color: Colors.black38),
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
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Repita a Senha',
                            hintText: 'Repita a Senha',
                            hintStyle: TextStyle(color: Colors.black38),
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
                          onSaved: (password) =>
                              users.confirmPassword = password!,
                        ),
                        const SizedBox(height: 16),
                        ...[const PolicyAndDocumentsScreen()],
                        CustomButton(
                          text: 'Criar Conta',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              if (users.password != users.confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Confirmação de Senha não confere! Tente '
                                      'Redigitar a Senha e a confirmação da Senha',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 5),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.all(15),
                                  ),
                                );
                                return;
                              }
                              if (!policyAndDocuments.agreedToPolicyTerms ||
                                  !policyAndDocuments.agreedToTermsOfService) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'É necessário Concordar com a Política de '
                                      'privacidade e nossos Termos de Serviço',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 5),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.all(15),
                                  ),
                                );
                                return;
                              }
                              userManager.singUp(
                                users: users,
                                onFail: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Falha ao cadastrar $error',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 5),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.all(15),
                                    ),
                                  );
                                },
                                onSuccess: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}