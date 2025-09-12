import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverPasswordCard extends StatefulWidget {
  final String? oobCode;

  const RecoverPasswordCard({super.key, required this.oobCode});

  @override
  State<RecoverPasswordCard> createState() => _RecoverPasswordCardState();
}

class _RecoverPasswordCardState extends State<RecoverPasswordCard> {
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

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Recuperar Senha",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: (v) {
                  final value = (v ?? '').trim();
                  if (value.isEmpty) return "Informe seu e-mail";
                  final emailOk = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$").hasMatch(value);
                  if (!emailOk) return "E-mail inválido";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => loading = true);

                        // flow: send reset email via Firebase Auth
                        try {
                          await userManager.confirmNewPassword(
                            oobCode: widget.oobCode!,
                            newPassword: emailController.text.trim(), // get the new password
                            onSuccess: () {
                              CustomScaffoldMessenger(
                                context: context,
                                message: 'Senha redefinida com sucesso!',
                              ).alertScaffold();
                              Navigator.of(context).pop();
                            },
                            onFail: (error) {
                              CustomScaffoldMessenger(
                                context: context,
                                message: 'Erro: $error',
                              ).alertScaffold();
                            },
                          );
                          if (!mounted) return;
                          CustomScaffoldMessenger(
                            context: context,
                            message:
                                'E-mail de redefinição enviado! Verifique a caixa de entrada ou spam.',
                          ).alertScaffold();

                          setState(() => loading = false);

                          Navigator.of(context).pop(); // back to login
                        } catch (e) {
                          if (!mounted) return;
                          CustomScaffoldMessenger(
                            context: context,
                            message: 'Erro ao enviar e-mail: $e',
                          ).alertScaffold();
                          setState(() => loading = false);
                        }
                      },
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
