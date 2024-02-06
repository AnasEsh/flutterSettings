import 'dart:async';

import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/models/user.dart';
import 'package:restore_config/src/services/postService.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/viewModels/base.dart';

class PostViewModel extends BaseVm {
  final _service = dependincies.get<PostService>();
  List<Post>? posts;
  bool get loadingPosts=>posts==null&&loading;
  
  void getPosts() async {
    if(posts!=null)
    return;
    toggleLoading(true);
    final r=await _service.getAll();
    if(!r.success) {
      errors.add(r.message);
    } else {
      posts=r.result!;
    }
    toggleLoading(false);
  }
}
