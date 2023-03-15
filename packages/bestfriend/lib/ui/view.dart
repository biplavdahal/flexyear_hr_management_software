import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class View<T extends ViewModel> extends StatefulWidget {
  /// Provides a builder function that will build/re-build the widget/screen
  final Widget Function(BuildContext ctx, T model, Widget? child) builder;

  /// This method will be called as soon as model is ready
  final Function(T model)? onModelReady;

  /// You can put logics for initState here.
  final Function(T model)? initState;

  /// Weather to dispose view model once removed from router stack.
  /// default: True
  final bool killViewOnClose;

  /// You can put disposal logics here.
  final Function(T model)? onDispose;

  /// If [true], it will wrap the child in TouchRepeal widget which will hide
  /// softkey when pressed outside textfield.
  final bool enableTouchRepeal;

  const View({
    Key? key,
    required this.builder,
    this.onModelReady,
    this.initState,
    this.killViewOnClose = true,
    this.onDispose,
    this.enableTouchRepeal = false,
  }) : super(key: key);

  @override
  _ViewState<T> createState() => _ViewState();
}

class _ViewState<T extends ViewModel> extends State<View<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    _createViewModel();
  }

  void _createViewModel() {
    model = locator<T>();

    if (widget.initState != null) {
      if (model.onModelReadyCalled) {
        widget.initState!(model);
      }
    }

    if (widget.onModelReady != null) {
      if (!widget.killViewOnClose && !model.onModelReadyCalled) {
        widget.onModelReady!(model);

        model.setOnModelReadyCalled(status: true);
      } else if (widget.killViewOnClose) {
        widget.onModelReady!(model);
      }
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableTouchRepeal) {
      if (!widget.killViewOnClose) {
        return ChangeNotifierProvider.value(
          value: model,
          child: Consumer<T>(
            builder: (context, value, child) => TouchRepeal(
              child: widget.builder(context, value, child),
            ),
          ),
        );
      }

      return ChangeNotifierProvider(
        create: (context) => model,
        child: Consumer<T>(
          builder: (context, value, child) => TouchRepeal(
            child: widget.builder(context, value, child),
          ),
        ),
      );
    }

    if (!widget.killViewOnClose) {
      return ChangeNotifierProvider.value(
        value: model,
        child: Consumer<T>(
          builder: (context, value, child) {
            return widget.builder(context, value, child);
          },
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer<T>(
        builder: (context, value, child) {
          return widget.builder(context, value, child);
        },
      ),
    );
  }
}
