import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SnackbarManager extends StatefulWidget {
  final Widget body;
  final Color infoColor;
  final Color warningColor;
  final Color errorColor;
  final Color successColor;
  final TextStyle? messageStyle;
  final SnackBarBehavior behavior;
  final ShapeBorder? shape;
  final double elevation;

  const SnackbarManager({
    Key? key,
    required this.body,
    this.messageStyle,
    this.infoColor = Colors.blue,
    this.warningColor = Colors.yellow,
    this.errorColor = Colors.red,
    this.successColor = Colors.green,
    this.behavior = SnackBarBehavior.fixed,
    this.shape,
    this.elevation = 0,
  }) : super(key: key);

  @override
  _SnackbarManagerState createState() => _SnackbarManagerState();
}

class _SnackbarManagerState extends State<SnackbarManager> {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  @override
  void initState() {
    super.initState();
    _snackbarService.registerSnackbarListener(_showSnackbar);
  }

  Tuple2 _colorSelector(ESnackbarType type) {
    switch (type) {
      case ESnackbarType.warning:
        Tuple2<Color, Color> _color = Tuple2(
            widget.warningColor,
            widget.warningColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white);
        return _color;
      case ESnackbarType.error:
        Tuple2<Color, Color> _color = Tuple2(
            widget.errorColor,
            widget.errorColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white);
        return _color;
      case ESnackbarType.success:
        Tuple2<Color, Color> _color = Tuple2(
            widget.successColor,
            widget.successColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white);
        return _color;
      default:
        Tuple2<Color, Color> _color = Tuple2(
            widget.infoColor,
            widget.infoColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white);
        return _color;
    }
  }

  void _showSnackbar(SnackbarRequest request) {
    Tuple2 _color = _colorSelector(request.type);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          request.message,
          style: widget.messageStyle ??
              TextStyle(
                color: _color.item2,
              ),
        ),
        backgroundColor: _color.item1,
        action: request.action != null
            ? SnackBarAction(
                label: request.action!.label,
                onPressed: request.action!.onPressed,
                textColor: _color.item2,
              )
            : null,
        duration: request.duration == ESnackbarDuration.short
            ? const Duration(seconds: 1)
            : const Duration(seconds: 3),
        behavior: widget.behavior,
        shape: widget.shape,
        elevation: widget.elevation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.body;
  }
}
