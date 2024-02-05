import 'package:flutter/material.dart';
import 'package:restore_config/src/utils/di.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeView extends StatefulWidget {
  static const name = "/";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final localization=dependincies.get<AppLocalizations>();
    return Scaffold(
      appBar: AppBar(
        title:Text(localization.posts_title) ,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.login)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
