import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager({super.key,required this.color, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
          color: Colors.black.withOpacity(0.7),
        )
            : Container(),
        isLoading
            ?  Center(
          child: SpinKitFadingCircle(
            color: color,
          ),
        )
            : Container(),
      ],
    );
  }
}