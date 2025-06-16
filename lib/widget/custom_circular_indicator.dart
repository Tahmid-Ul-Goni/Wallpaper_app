
import 'package:flutter/material.dart';

class circularprogressIndicator extends StatelessWidget {
  const circularprogressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      body: Center(child: Image.asset('lib/Assets/loading.gif'),),
    );
  }
}
