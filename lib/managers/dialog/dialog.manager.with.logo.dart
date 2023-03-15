import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.service.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogManagerWithLogo extends StatefulWidget {
  final Widget child;

  const DialogManagerWithLogo({Key? key, required this.child})
      : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManagerWithLogo> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog, _hideDialog);
  }

  void _showDialog(DialogRequest request) {
    if (request.type == DialogType.progress) {
      _baseDialog(child: _buildProgressType(request));
    }

    if (request.type == DialogType.confirmation) {
      _baseDialog(
          child: _buildConfirmationType(request),
          dismissable: request.dismissable);
    }

    if (request.type == DialogType.selections) {
      _baseDialog(
        child: _buildSelectionType(request),
        dismissable: request.dismissable,
      );
    }
  }

  _baseDialog({Widget? child, bool dismissable = false}) {
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [Image.asset("assets/images/flex_year_login_image.png")],
          ),
          backgroundColor: Colors.white,
          // title: title,
          content: child,
        );
      },
    );
  }

  _buildProgressType(DialogRequest request) {
    return Row(
      children: [
        const CupertinoActivityIndicator(
          animating: true,
        ),
        const SizedBox(width: 32),
        Expanded(child: Text(request.title)),
      ],
    );
  }

  _buildConfirmationType(DialogRequest request) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(request.title),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: FYPrimaryButton(
                  onPressed: () {
                    _dialogService.hideDialog(DialogResponse(result: true));
                  },
                  label: "Yes",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FYSecondaryButton(
                  label: "No",
                  onPressed: () {
                    _dialogService.hideDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSelectionType(DialogRequest request) {
    final _options = request.payload as List<String>;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(request.title),
        const SizedBox(height: 16),
        for (int i = 0; i < _options.length; i++) ...[
          const SizedBox(height: 16),
          FYPrimaryButton(
            onPressed: () {
              _dialogService.hideDialog(DialogResponse(result: _options[i]));
            },
            label: _options[i],
          ),
        ]
      ],
    );
  }

  void _hideDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
