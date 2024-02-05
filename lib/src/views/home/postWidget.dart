import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restore_config/src/models/post.dart';

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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(post.modified.toString()),
          const SizedBox(
            width: 8,
          ),
          const Icon(Icons.person),
          Text("by ${post.UserId}")
        ],
      ),
    );
  }
}
