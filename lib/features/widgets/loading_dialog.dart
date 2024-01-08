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
        if (isLoading)
          Container(
            color: Colors.white,
            child: Center(
              child: Lottie.asset(
                'assets/anim/location.json',
                width: 130,
                height: 130,
                animate: true,
              ),
            ),
          ),
      ],
    );
  }
}
