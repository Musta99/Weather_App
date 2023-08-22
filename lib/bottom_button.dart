import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const BottomButton({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Row(
            children: [
              Icon(icon),
              Text(
                label,
              )
            ],
          ),
        ),
      ),
    );
  }
}
