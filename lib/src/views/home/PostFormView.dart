import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/models/post.dart';
import 'package:restore_config/src/services/implementations/userService.dart';
import 'package:restore_config/src/viewModels/postVm.dart';
import 'package:restore_config/src/viewModels/userVm.dart';

class PostFormView extends StatefulWidget {
  Post? post;
  PostFormView({super.key, this.post});
  @override
  State<PostFormView> createState() => _PostFormViewState();
}

class _PostFormViewState extends State<PostFormView> {
  late TextEditingController controller;
  late UserViewModel userVm = context.read<UserViewModel>();
  late PostViewModel postVm = context.read<PostViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.post?.content);
    userVm = context.read();
    postVm = context.read();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updating = widget.post != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              updating ? Icons.note_alt_outlined : Icons.note_add_outlined,
              size: Theme.of(context).textTheme.headlineLarge?.fontSize ?? 32,
            ),
            Text(
              updating ? "Edit the post" : "Create a post",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            // expands: true,
            maxLines: 5,
            decoration: InputDecoration(
                label: Text("Post content"), hintText: "write your thoughts"),
            controller: controller,
          ),
        ),
        if (updating) Text(widget.post!.modified.toString()),
        if (userVm.loggedIn &&
            (widget.post == null || widget.post?.creatorId == userVm.user?.id))
          Selector<PostViewModel, bool>(
              selector: (p0, p1) => p1.loading,
              builder: (context, loading, c) {
                return loading
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                        ),
                        child: FittedBox(child: CircularProgressIndicator()),
                      )
                    : ElevatedButton.icon(
                        onPressed: _submit,
                        label: const Text("Save"),
                        icon: const Icon(Icons.save),
                      );
              }),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        )
      ],
    );
  }

  void _submit() async {
    if (userVm.loading || postVm.loading) return;
    final uid = userVm.user!.id;
    if (await postVm.addPost(controller.text, uid)) Navigator.of(context).pop();
  }
}
