import 'package:flutter/material.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double padding;
  const ResponsivePadding({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 650
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.8)
          : EdgeInsets.all(padding),
      child: child,
    );
  }
}
