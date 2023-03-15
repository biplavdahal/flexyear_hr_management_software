import 'package:flutter/material.dart';

class TopToBottomDraggableSheet extends StatefulWidget {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget child;
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;
  final Color handleColor;
  final double handleWidth;
  final double handleHeight;

  const TopToBottomDraggableSheet({
    Key? key,
    required this.child,
    required this.builder,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.1,
    this.maxChildSize = 1.0,
    this.handleColor = Colors.grey,
    this.handleWidth = 40,
    this.handleHeight = 5,
  }) : super(key: key);

  @override
  _TopToBottomDraggableSheetState createState() =>
      _TopToBottomDraggableSheetState();
}

class _TopToBottomDraggableSheetState extends State<TopToBottomDraggableSheet> {
  late ScrollController _scrollController;
  double _childSize = 0.5;

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      // Update the sheet size based on the drag position
      _childSize -= details.primaryDelta! / MediaQuery.of(context).size.height;
      _childSize = _childSize.clamp(widget.minChildSize, widget.maxChildSize);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onVerticalDragUpdate: _handleDragUpdate,
          child: Container(
            width: widget.handleWidth,
            height: widget.handleHeight,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: widget.handleColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: MediaQuery.of(context).size.height * _childSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: widget.builder(context, _scrollController),
            ),
          ),
        ),
      ],
    );
  }
}
