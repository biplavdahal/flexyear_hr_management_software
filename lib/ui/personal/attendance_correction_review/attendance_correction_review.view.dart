import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/attendance_correction_review.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction_review/widgets/review_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AttendanceCorrectionReviewView extends StatelessWidget {
  static String tag = 'attendance-correction-review-view';

  const AttendanceCorrectionReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceCorrectionReviewModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Correction Review'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: model.init,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ReviewItem(
                          isProcessing: model.isBusyWidget(
                              '${model.reviews[index].id}-review'),
                          correction: model.reviews[index],
                          onApprove: model.onApprove,
                          onDecline: model.onDecline,
                        );
                      },
                      itemCount: model.reviews.length,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
