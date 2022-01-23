import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final List<Widget> buttons;
  final List<bool> buttonsStatus;
  final void Function(int) onChange;
  final Axis axisDirection;
  final BoxConstraints? shrink;
  final bool lineBelow;

  const CustomToggleButton(
      {required this.buttons,
      required this.buttonsStatus,
      required this.onChange,
      this.axisDirection = Axis.horizontal,
      this.shrink,
      this.lineBelow = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: ToggleButtons(
            constraints: shrink,
            direction: axisDirection,
            renderBorder: false,
            fillColor: Colors.grey[400],
            children: buttons,
            isSelected: buttonsStatus,
            onPressed: onChange,
          ),
        ),
        if (lineBelow)
          Container(
            height: 2.0,
            color: Colors.grey[600],
          ),
      ],
    );
  }
}
