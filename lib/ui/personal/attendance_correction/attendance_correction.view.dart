import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/widgets/correction_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AttendanceCorrectionView extends StatelessWidget {
  static String tag = 'attendance-correction-view';

  const AttendanceCorrectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceCorrectionModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Correction'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    model.tabs.length,
                    (index) => ChoiceChip(
                      label: Text(model.tabs[index]),
                      selected: model.selectedTab == index.toString(),
                      onSelected: (_) => model.selectedTab = index.toString(),
                    ),
                  ),
                ),
                if (model.isLoading) const FYLinearLoader(),
                const SizedBox(
                  height: 16,
                ),
                if (!model.isLoading)
                  if (model.correctionsToShow.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CorrectionItem(
                              correction: model.correctionsToShow[index],
                              isBusy: model.isBusyWidget(
                                  model.correctionsToShow[index].id),
                              onDeletePressed: model.onDelete,
                              onApprove: model.onApprove,
                              onDecline: model.onDecline,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: model.correctionsToShow.length,
                        ),
                      ),
                    )
                  else
                    const Expanded(
                        child: Center(
                      child: Text('No attandance '),
                    )),
              ],
            ),
          ),

          // body: model.isLoading
          //     ? const FYLinearLoader()
          //     : RefreshIndicator(
          //         onRefresh: model.init,
          //         child: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: ListView.builder(
          //             itemBuilder: (context, index) {
          //               final _correction = model.corrections[index];
          //               return CorrectionItem(
          //                 correction: _correction,
          //                 onDeletePressed: model.onDelete,
          //               );
          //             },
          //             itemCount: model.corrections.length,
          //           ),
          //         ),
          //       ),
        );
      },
    );
  }
}
