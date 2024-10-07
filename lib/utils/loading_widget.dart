import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.yellow.shade700,
          strokeWidth: 5,
        ),
      ),
    );
  }
}
