

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.isLoading});
  final bool isLoading;
  //TODO: fIX ME Loading

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Lottie.asset(
                'assets/anim/loading_location.json',
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
