import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/helpers/validators.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/policy_and_documents_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
    const textFieldSpaceBetweenHeight = SizedBox(height: 16);

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
                        const Center(
                          child: Text(
                            'Cadastro',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: 18),
                        CustomTextFormField(
                          labelText: 'Nome Completo',
                          hintText: 'Preencha com seu nome completo',
                          enableTextEdit: !userManager.loading,
                          isDense: false,
                          validator: (name) {
                            if (name!.trim().split(' ').length <= 1) {
                              return 'Preencha seu nome completo!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (name) => users.userName = name!,
                        ),
                        textFieldSpaceBetweenHeight,
                        CustomTextFormField(
                          labelText: 'E-mail',
                          hintText: 'EX: nome@domínio.xxx',
                          enableTextEdit: !userManager.loading,
                          textInputType: TextInputType.emailAddress,
                          isDense: false,
                          validator: (email) {
                            if (!emailValid(email!)) {
                              return 'E-mail inválido';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (email) => users.email = email!,
                        ),
                        textFieldSpaceBetweenHeight,
                        CustomTextFormField(
                          labelText: 'Telefone (Opcional)',
                          hintText: '(00) 00000-0000',
                          enableTextEdit: !userManager.loading,
                          textInputType: TextInputType.number,
                          isDense: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          validator: (phone) {
                            if (phone!.isNotEmpty && phone.length < 11) {
                              return 'Confira o número digitado!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (phone) => users.phoneNumber = phone!,
                        ),
                        textFieldSpaceBetweenHeight,
                        CustomTextFormField(
                          labelText: 'Senha',
                          hintText: 'Mínimo: 7 caracteres',
                          enableTextEdit: !userManager.loading,
                          isDense: false,
                          obscureText: true,
                          validator: (password) {
                            if (password!.length < 7) {
                              return 'Senha deve conter no mínimo 7 caracteres';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (password) => users.password = password!,
                        ),
                        textFieldSpaceBetweenHeight,
                        CustomTextFormField(
                          labelText: 'Repita a Senha',
                          enableTextEdit: !userManager.loading,
                          isDense: false,
                          obscureText: true,
                          validator: (password) {
                            if (password!.length < 7) {
                              return 'Senha deve conter no mínimo 7 caracteres';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (password) => users.confirmPassword = password!,
                        ),
                        textFieldSpaceBetweenHeight,
                        ...[const PolicyAndDocumentsScreen()],
                        CustomButton(
                          text: 'Criar Conta',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              if (users.password != users.confirmPassword) {
                                CustomScaffoldMessenger(
                                  context: context,
                                  message: 'Confirmação de Senha não confere! Tente '
                                      'Redigitar a Senha e a confirmação da Senha',
                                ).alertScaffold();
                                return;
                              }
                              if (!policyAndDocuments.agreedToPolicyTerms ||
                                  !policyAndDocuments.agreedToTermsOfService) {
                                CustomScaffoldMessenger(
                                  context: context,
                                  message: 'É necessário Concordar com a Política de '
                                      'privacidade e nossos Termos de Serviço',
                                ).alertScaffold();
                                return;
                              }
                              userManager.singUpWithEmailAndPassword(
                                users: users,
                                onFail: (error) {
                                  CustomScaffoldMessenger(
                                          context: context, message: 'Falha ao cadastrar $error')
                                      .alertScaffold();
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
