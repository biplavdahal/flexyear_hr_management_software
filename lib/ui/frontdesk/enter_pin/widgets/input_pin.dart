import 'package:flutter/material.dart';

class InputPin extends StatelessWidget {
  final String value;
  final ValueSetter<String> onPressed;

  const InputPin({
    Key? key,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(78 / 2),
      color: value.isNotEmpty ? Colors.white : Colors.transparent,
      elevation: value.isNotEmpty ? 6 : 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(78 / 2),
        onTap: value.isNotEmpty ? () => onPressed(value) : null,
        child: Container(
          alignment: Alignment.center,
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(78 / 2),
          ),
          child: value.toLowerCase() == "<"
              ? const Icon(
                  Icons.backspace,
                  color: Colors.black,
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
