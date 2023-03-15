import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.arguments.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.model.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class StaffsView extends StatelessWidget {
  static String tag = 'staffs-view';

  final Arguments? arguments;

  const StaffsView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<StaffsModel>(
      enableTouchRepeal: true,
      onModelReady: (model) => model.init(arguments as StaffsArguments?),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.isSelectMode ? 'Select Staffs' : 'Staffs'),
          ),
          floatingActionButton: model.isSingleSelect
              ? null
              : model.selectedStaffs.isNotEmpty
                  ? FloatingActionButton(
                      child: const Icon(Icons.check),
                      onPressed: () => model.goBack(
                        result: model.selectedStaffs,
                      ),
                    )
                  : null,
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FYInputField(
                        title: '',
                        label: 'Search staff by name',
                        controller: model.searchController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final _staff = model.staffsToShow[index];

                            return ListTile(
                              onTap: () => model.addSelectedStaffs(_staff),
                              title: Text(_staff.fullName),
                              leading: model.isSelected(_staff)
                                  ? const Icon(Icons.check_box,
                                      color: Colors.green)
                                  : const Icon(
                                      Icons.check,
                                      color: Colors.grey,
                                    ),
                            );
                          },
                          itemCount: model.staffsToShow.length,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
