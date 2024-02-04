import 'package:flutter/material.dart';
import 'package:restore_config/src/views/auth/home/homne.dart';

void login(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(HomeView.name);
}

void logout(BuildContext ctx) {}
