import 'package:flutter/material.dart';

///Custom horizontal Scrollviewer
class HorizontalListView extends StatelessWidget {
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final int? itemCount;
  final List<Widget>? children;
  final Widget Function(BuildContext context, int index)? seprator;
  final Widget? fillerWidget;
  final int? fillerCount;

  const HorizontalListView({
    Key? key,
    this.itemCount,
    this.itemBuilder,
    this.children,
    this.seprator,
    this.fillerWidget,
    this.fillerCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children != null
              ? children!
              : [
                  for (int i = 0; i < itemCount!; i++)
                    Row(
                      children: [
                        itemBuilder!(context, i),
                        if (seprator != null && i != itemCount! - 1)
                          seprator!(context, i),
                      ],
                    ),
                  if (fillerCount! > 0) seprator!(context, 0),
                  for (int i = 0; i < fillerCount!; i++)
                    Row(
                      children: [
                        fillerWidget!,
                        if (seprator != null && i != fillerCount! - 1)
                          seprator!(context, i),
                      ],
                    ),
                ],
        ),
      ),
    );
  }
}
