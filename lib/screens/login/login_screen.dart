import 'package:ecommerce/common/button/BotaoCustomizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),

      body: Center(
        child: Card(
          margin: kIsWeb ?  const EdgeInsets.symmetric(horizontal: 150) :
                            const EdgeInsets.symmetric(horizontal: 19),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email){
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Senha'),
                autocorrect: false,
                obscureText: true,
                validator: (password){
                  if(password!.isEmpty || password.length < 7) {
                    return 'Senha Inválida';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed: (){

                  },
                  padding: EdgeInsets.zero,
                  child: const Text(
                      'Esqueci minha Senha!'
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: 44,
                child: BotaoCustomizado(
                    texto: 'Entrar',
                    onPressed: (){ }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
