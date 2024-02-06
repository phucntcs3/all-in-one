import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  const VSpace({
    super.key,
    this.space = 10,
  });

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}
