import 'package:program1/roller_dice.dart';
import 'package:flutter/material.dart';
class GradientContainer extends StatelessWidget {
  final Color color;

  const GradientContainer(this.color, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
