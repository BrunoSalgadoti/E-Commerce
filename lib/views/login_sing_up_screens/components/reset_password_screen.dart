import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/formatted_fields/custom_text_form_field.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/services/db_api/config_environment_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String oobCode;

  const ResetPasswordScreen({super.key, required this.oobCode});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitNewPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final userManager = context.read<UserManager>();
    final newPassword = passwordController.text.trim();

    setState(() => loading = true);

    await userManager.confirmNewPassword(
      oobCode: widget.oobCode,
      newPassword: newPassword,
      onSuccess: () async {
        CustomScaffoldMessenger(
          context: context,
          message: 'Senha alterada com sucesso!',
          backgroundColor: Colors.green,
          iconColor: Colors.black,
        ).alertScaffold();

        // 🔑 Smart Redirection
        try {
          // 1. Try opening the app via deep link
          final success = await launchUrlString(
            AppConfigKey.deepLinkUrl, // brn-ecommerce://login
            mode: LaunchMode.externalApplication,
          );

          if (!success) {
            // 2. If not successful (web/desktop or app not installed), please login to the site
            await launchUrlString(AppConfigKey.linkLoginScreenApp);
          }
        } catch (e) {
          debugPrint("Erro ao abrir deep link: $e");
          await launchUrlString(AppConfigKey.linkLoginScreenApp);
        }
      },
      onFail: (error) {
        CustomScaffoldMessenger(
          context: context,
          message: 'Erro: $error',
        ).alertScaffold();
      },
    );

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redefinir Senha')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.lock_reset, size: 80, color: Colors.blue),
                const SizedBox(height: 20),

                // New Password
                CustomTextFormField(
                  controller: passwordController,
                  obscureText: true,
                  labelText: 'Nova senha',
                  hintText: 'Digite sua nova senha',
                  validator: (v) {
                    final value = (v ?? '').trim();
                    if (value.isEmpty) return 'Informe a nova senha';
                    if (value.length < 7) return 'Senha curta, MÍNIMO 7 CARACTERES';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password confirmation
                CustomTextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  labelText: 'Confirmar nova senha',
                  hintText: 'Repita a nova senha',
                  validator: (v) {
                    final value = (v ?? '').trim();
                    if (value.isEmpty) return 'Confirme a senha';
                    if (value != passwordController.text.trim()) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Button to change password
                CustomButton(
                  text: loading ? 'Processando...' : 'Alterar Senha',
                  onPressed: loading ? null : () => _submitNewPassword(context),
                  buttonColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
