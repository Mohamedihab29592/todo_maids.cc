import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utilies/strings.dart';

class ShowDialogError extends StatefulWidget {
  final String title;
  final String subTitle;
  final Function()? functionPressed ;
  const ShowDialogError({super.key, required this.title, required this.subTitle,  this.functionPressed,});

  @override
  State<ShowDialogError> createState() => _ShowDialogErrorState();
}

class _ShowDialogErrorState extends State<ShowDialogError> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(widget.title),
      content: Text(widget.subTitle),
      actions: <Widget>[
        TextButton(
          child:  Text(AppStrings.ok),
       onPressed:     () {
            if(  widget.functionPressed!=null){
              GoRouter.of(context).pop();
              widget.functionPressed!();

            }
            else {
              GoRouter.of(context).pop();
            }

          }
        ),
      ],
    );
  }
}