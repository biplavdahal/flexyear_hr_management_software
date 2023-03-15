
import 'package:flutter/material.dart';
class UtilityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final Color? iconColor;

  const UtilityItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 32,
                color: iconColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
