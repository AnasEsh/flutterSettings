import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/settings/settings_view.dart';
import 'package:restore_config/src/utils/di.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restore_config/src/viewModels/postVm.dart';
import 'package:restore_config/src/viewModels/userVm.dart';
import 'package:restore_config/src/views/auth/Login.dart';
import 'package:restore_config/src/views/home/PostFormView.dart';
import 'package:restore_config/src/views/home/postsList.dart';

class HomeView extends StatefulWidget {
  static const routeName = "/";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late UserViewModel userVm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostViewModel>().getPosts();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    userVm = context.read();
    final localization = dependincies.get<AppLocalizations>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(context: context, builder: (context) {
          return PostFormView();
        },);
      },
      child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(localization.posts_title),
            const SizedBox(
              width: 4,
            ),
            const Icon(Icons.podcasts_sharp)
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsView.routeName);
              },
              icon: const Icon(Icons.settings)),
          Selector<UserViewModel, bool>(
            selector: (p0, p1) => p1.loggedIn,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginView.routeName);
                },
                icon: const Icon(Icons.login)),
            builder: (context, loggedIn, child) {
              return !loggedIn
                  ? child!
                  : Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(userVm.user!.name)
                              ],
                            )),
                        IconButton(
                            onPressed: () {
                              userVm.logout();
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.error,
                            ))
                      ],
                    );
            },
          )
        ],
      ),
    
    body:const PostsList(),
    );
  }
}
