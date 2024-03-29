import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/constants/view_helpers/auth.dart';
import 'package:restore_config/src/utils/Extensions/strExt.dart';

import 'package:restore_config/src/viewModels/userVm.dart';

class LoginView extends StatefulWidget {
  static const routeName = "/login";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController email, pswd, name;
  late UserViewModel vm;
  late StreamSubscription<String?> errorsObserver;
  final key = GlobalKey<FormState>();
  bool registeration = false;
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    pswd = TextEditingController();
    name = TextEditingController();
    vm = context.read<UserViewModel>();

    errorsObserver = vm.errors.stream.listen((event) {
      if (event == null) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(event)));
    });
  }

  @override
  void dispose() {
    for (var c in [email, pswd, name]) {
      c.dispose();
    }
    key.currentState?.dispose();
    errorsObserver.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
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
                registeration ? "Register" : "Login",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              if (registeration) ...[
                TextFormField(
                  controller: name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) =>
                      v!.length < 5 ? "Name must be of 5 or more chars" : null,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(letterSpacing: 1.5),
                      hintText: "Anas Eshtaiwi",
                      label: Text("Name"),
                      prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
              TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v?.validEmail(),
                decoration: const InputDecoration(
                    hintStyle: TextStyle(letterSpacing: 1.5),
                    hintText: "anas@anas.com",
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.mail)),
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
                    hintText: "*****",
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.password)),
              ),
              Selector<UserViewModel, bool>(
                child: const LinearProgressIndicator(),
                builder: (_, value, child) {
                  if (value) return child!;
                  return Container();
                },
                selector: (p0, p1) => p1.loading,
              ),
              ElevatedButton(
                  onPressed: _submit,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(registeration ? Icons.account_circle : Icons.login),
                      const SizedBox(width: 16),
                      Text(
                        registeration ? "Register" : "Login",
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _toggleRegisteration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(registeration
                        ? Icons.login
                        : Icons.account_circle_outlined),
                    Text(registeration ? "Login" : "Register your account")
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

  void _toggleRegisteration() {
    setState(() {
      registeration = !registeration;
    });
  }

  Future<void> _onRegister() async {
    if (!await vm.register(name.text, email.text, pswd.text)) return;
    name.clear();
    _toggleRegisteration();
  }

  Future<void> _onLogin() async {
    if (await vm.login(email.text, pswd.text)) login(context);
  }

  void _submit() async {
    final formState = key.currentState;
    if (formState == null || !formState.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (!registeration) {
      _onLogin();
    } else {
      _onRegister();
    }
  }
}
