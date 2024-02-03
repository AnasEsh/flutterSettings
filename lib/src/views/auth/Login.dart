import 'package:flutter/material.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/Extensions/strExt.dart';
import 'package:restore_config/src/utils/di.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController email, pswd;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    pswd = TextEditingController();
  }

  @override
  void dispose() {
    for (var c in [email, pswd]) {
      c.dispose();
    }
    key.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                "Login",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v?.validEmail(),
                decoration: InputDecoration(
                    hintStyle: TextStyle(letterSpacing: 1.5),
                    hintText: "anas@anas.com",
                    label: const Text("Email"),
                    prefixIcon: const Icon(Icons.mail)),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: pswd,
                validator: (v) => (v?.length ?? 0) < 4
                    ? "pswd must be of 4 or more chars"
                    : null,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(letterSpacing: 1.5),
                    hintText: "**************",
                    label: const Text("Password"),
                    prefixIcon: const Icon(Icons.password)),
              ),
              ElevatedButton(
                  // color: ,
                  onPressed: _submit,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login),
                      SizedBox(width: 16),
                      Text(
                        "Login",
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_outlined),
                    Text("Register your account")
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final formState = key.currentState;
    if (formState == null || !formState.validate()) return;
  }
}
