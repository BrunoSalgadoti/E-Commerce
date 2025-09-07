import 'package:brn_ecommerce/common/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Recuperar Senha',
        showDrawerIcon: false,
        showSearchButton: false,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: emailController,
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail, para redefinição da senha',
                textInputType: TextInputType.emailAddress,
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty) return 'Informe seu e-mail';
                  final emailOk = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$").hasMatch(value);
                  if (!emailOk) return 'E-mail inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Enviar',
                onPressed: loading
                    ? null
                    : () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => loading = true);

                  await userManager.sendPasswordResetEmailRequest(
                    email: emailController.text.trim(),
                    onSuccess: () {
                      CustomScaffoldMessenger(
                        context: context,
                        message: 'E-mail enviado! Verifique caixa de entrada ou spam.',
                        backgroundColor: Colors.green,
                        iconColor: Colors.white,
                      ).alertScaffold();

                      // Volta para a tela de login no app
                      Navigator.of(context).pop();
                    },
                    onFail: (error) {
                      CustomScaffoldMessenger(
                        context: context,
                        message: 'Erro: $error',
                      ).alertScaffold();
                    },
                  );

                  setState(() => loading = false);
                },
                buttonColor: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}