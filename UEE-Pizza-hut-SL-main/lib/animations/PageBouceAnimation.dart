import 'package:flutter/cupertino.dart';

class PageBouceAnimation extends PageRouteBuilder {
  final Widget widget;

  PageBouceAnimation({required this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 1200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
