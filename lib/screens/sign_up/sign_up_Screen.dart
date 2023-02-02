import 'package:ecommerce/common/button/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),

        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Confirme a Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 52,
                  child: CustomButton(
                    texto: 'Criar Conta',
                    onPressed: () {  },
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
