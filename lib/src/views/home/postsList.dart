import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/viewModels/postVm.dart';
import 'package:restore_config/src/views/home/postWidget.dart';
import 'package:restore_config/src/views/shared/retryLoad.dart';
import 'package:tuple/tuple.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  late StreamSubscription _subscription;
  late PostViewModel postsVm;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postsVm = context.read();
    _subscription = postsVm.errors.stream.listen((event) {
      if (event != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event)));
    });
    // postsVm.getPosts();
  }

  @override
  void dispose() {
    _subscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Selector<PostViewModel, bool>(
          selector: (p0, p1) => p1.loading,
          builder: (context, loading, child) {
            return !loading
                ? Container()
                : const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Loading Posts..."),
                      LinearProgressIndicator(),
                    ],
                  );
          },
        ),
        Selector<PostViewModel, Tuple2<int?, bool>>(
            selector: (p0, p1) => Tuple2(p1.posts?.length, p1.loadingPosts),
            child: Container(),
            shouldRebuild: (previous, next) {
              if (previous.item1 != next.item1) return true;
              return (previous.item2 != next.item2) && previous.item1 == null;
            },
            builder: (context, count, child) => count.item1 != null
                ? ListView(
                  shrinkWrap: true,
                    children: postsVm.posts!
                        .map((post) => PostWidget(post: post))
                        .toList(),
                  )
                : 
                //not loaded, but is loading
                count.item2
                    ? Container()
                    : Retry(
                        warningMessage: "Failed to load posts",
                        onRetry: postsVm.getPosts,
                      )),
      ],
    );
  }
}
