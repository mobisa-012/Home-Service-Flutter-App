import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnboardingTile extends StatelessWidget {
  final title, imagePath, mainText;

  OnboardingTile(
      {required this.imagePath, required this.mainText, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 34),
          Expanded(
            child: Image.asset(imagePath) 
            ),
            const SizedBox(height: 65),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24
              ),
            ),
            const SizedBox(height: 15),
            Padding(padding: EdgeInsets.symmetric(horizontal: screenWidth / 100),
            child: Text(mainText,
            style: const TextStyle(
              fontSize: 16.0
            ),
            textAlign: TextAlign.center,),
            )
            ],
      ),
      );
  }
}
