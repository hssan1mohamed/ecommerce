import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Image.asset('assets/images/loading.gif'),
        ));
  }
}