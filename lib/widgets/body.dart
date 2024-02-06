import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    this.children = const [],
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(
        children: children,
      ),
    );
  }
}
