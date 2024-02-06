import 'package:flutter/material.dart';
import 'package:restore_config/src/models/post.dart';

class PostFormView extends StatefulWidget {
  Post? post;
  PostFormView({super.key, this.post});
  @override
  State<PostFormView> createState() => _PostFormViewState();
}

class _PostFormViewState extends State<PostFormView> {

  late TextEditingController controller ;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  controller = TextEditingController(text: widget.post?.content);
  
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
      children: [
        Row(
          children: [
            Icon(updating ? Icons.note_alt_outlined : Icons.note_add_outlined),
            Text(updating ? "Edit the post" : ""),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: controller,
        ),
        if (updating) Text(widget.post!.modified.toString()),
        ElevatedButton.icon( onPressed: () {
          
        },
        label: Text("Save"),
          icon: Icon(Icons.save),
        )
      ],
    );
  }
}
