import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';

class RequestReviewView extends StatelessWidget {
  static String tag = 'request-review-view';

  final Arguments? arguments;

  const RequestReviewView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<RequestReviewModel>(
      enableTouchRepeal: true,
      onModelReady: (model) => model.init(arguments as RequestReviewArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Request Review'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildForm(model),
          ),
        );
      },
    );
  }

  Widget _buildForm(RequestReviewModel model) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (model.requestReviewType == RequestReviewType.updateReview ||
                model.requestReviewType == RequestReviewType.attendanceReview)
              FYTimeField(
                title:
                    '${model.requestReviewType == RequestReviewType.updateReview ? "Request" : "Check"} In Time',
                value: model.inTime,
                onChanged: (value) => model.inTime = value,
              ),
            if (model.requestReviewType == RequestReviewType.updateReview ||
                model.requestReviewType == RequestReviewType.attendanceReview)
              const SizedBox(height: 16),
            FYTimeField(
              title:
                  '${model.requestReviewType == RequestReviewType.updateReview ? "Request" : "Check"} Out Time',
              value: model.outTime,
              onChanged: (value) => model.outTime = value,
            ),
            if (model.requestReviewType == RequestReviewType.checkoutReview ||
                model.requestReviewType == RequestReviewType.attendanceReview)
              const SizedBox(height: 16),
            if (model.requestReviewType == RequestReviewType.checkoutReview ||
                model.requestReviewType == RequestReviewType.attendanceReview)
              FYInputField(
                title: '',
                label: "Message",
                controller: model.messageController,
              ),
            const SizedBox(height: 24),
            FYPrimaryButton(
              label: "Submit Request",
              onPressed: model.onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
