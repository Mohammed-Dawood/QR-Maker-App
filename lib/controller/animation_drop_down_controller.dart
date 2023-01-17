import 'package:flutter/material.dart';

class AnimationDropDownController extends StatelessWidget {
  const AnimationDropDownController(
      {Key? key,
      required this.changeState,
      required this.durationTime,
      required this.firstChildeCard})
      : super(
          key: key,
        );

  final bool changeState;
  final int durationTime;
  final Card firstChildeCard;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          changeState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: durationTime + 300),
      firstCurve: Curves.linear,
      secondCurve: Curves.linear,
      sizeCurve: Curves.linear,
      firstChild: firstChildeCard,
      secondChild: const SizedBox(
        height: 0,
      ),
    );
  }
}
