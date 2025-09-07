import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyEmailScreen extends StatefulWidget {
  final String oobCode;
  const VerifyEmailScreen({super.key, required this.oobCode});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _loading = false;

  Future<void> _verifyEmail() async {
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.checkActionCode(widget.oobCode);
      await FirebaseAuth.instance.applyActionCode(widget.oobCode);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("E-mail confirmado com sucesso!")),
        );
        Navigator.pushReplacementNamed(context, RoutesNavigator.loginScreen);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verificação de E-mail")),
      body: Center(
        child: ElevatedButton(
          onPressed: _loading ? null : _verifyEmail,
          child: _loading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Confirmar E-mail"),
        ),
      ),
    );
  }
}
