import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/viewModels/postVm.dart';
import 'package:restore_config/src/viewModels/userVm.dart';

class PostWidget extends StatelessWidget {
  Post post;
  PostWidget({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.content),
      subtitle: Row(
        children: [
          Text(post.modified.toString()),
          Spacer(),
          const SizedBox(
            width: 8,
          ),
          Selector<UserViewModel, User?>(
              selector: (p0, p1) => p1.user,
              builder: (context, user, _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user?.id == post.creatorId) ...[
                      IconButton(
                        onPressed: () {
                          context.read<PostViewModel>().deletePost(post);
                        },
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                    ] else ...[
                      const Icon(Icons.person),
                      Text("by ${post.creatorId}")
                    ]
                  ],
                );
              }),
        ],
      ),
    );
  }
}
