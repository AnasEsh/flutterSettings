import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  Widget? warningWidget;
  String? warningMessage;
  void Function()? onRetry;
   Retry({super.key, this.warningMessage, this.warningWidget,this.onRetry}){
    assert((warningMessage!=null)^(warningWidget!=null));
   }

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Failed to Load Posts",style: TextStyle(color: Theme.of(context).colorScheme.error),)
            ,IconButton(onPressed: (){
              if(onRetry!=null) {
                onRetry!();
              }
            }, icon: Icon(Icons.refresh))
           ],);
  }
}