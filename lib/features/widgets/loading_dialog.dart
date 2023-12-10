

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Lottie.asset(
                'assets/anim/loading.json',
                width: 150,
                height: 150,
                animate: true,
              ),
            ),
          ),
      ],
    );
  }
}
