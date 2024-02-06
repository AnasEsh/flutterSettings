import 'dart:async';

import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/implementations/postService.dart';
import 'package:restore_config/src/services/implementations/userService.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/viewModels/base.dart';

class PostViewModel extends BaseVm {
  final _service = dependincies.get<PostService>();
  List<Post>? posts;
  bool get loadingPosts => posts == null && loading;

  void getPosts() async {
    if (posts != null) return;
    toggleLoading(true);
    final r = await _service.getAll();
    if (!r.success) {
      errors.add(r.message);
    } else {
      posts = r.result!;
    }
    toggleLoading(false);
  }

  Future<bool> deletePost(Post post) async {
    posts!.remove(post);
    notifyListeners();
    return (await _service.delete(post)).success;
  }

  Future<bool> addPost(String content, String userId) async {
    toggleLoading(true);
    final post = Post(content: content, creatorId: userId);
    final result = await _service.create(post);
    if (result.success) {
      posts = posts ?? [];
      posts!.add(post);
      post.id = result.result!.id;
    }
    toggleLoading(false);
    return result.success;
  }
}
