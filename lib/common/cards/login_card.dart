import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_circle,
                color: primaryColor,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: Text(
                  'Necessário está Logado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              CustomButton(
                text: 'LOGIN',
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
