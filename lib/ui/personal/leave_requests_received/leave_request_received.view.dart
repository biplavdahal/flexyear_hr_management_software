import 'package:bestfriend/di.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests/leave_requests.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/leave_request_received.model.dart';
import 'package:flex_year_tablet/ui/personal/leave_requests_received/widgets/request_item.dart';
import 'package:flex_year_tablet/ui/personal/write_leave_request/write_leave_request.view.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard.model.dart';

class LeaveRequestReceivedView extends StatelessWidget {
  static String tag = 'leave-request-received-view';

  const LeaveRequestReceivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = locator<DashboardModel>().user;
    return View<LeaveRequestReceivedModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Leave Request Received'),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final response = await model.goto(WriteLeaveRequestView.tag);
              if (response != null) {
                model.init();
              }
            },
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                padding: const EdgeInsets.all(0),
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
                          onSelected: (_) => model.selectedTab == index.toString(),
                        )
                       
                       ),
                    ),
                    if(model.isLoading) const FYLinearLoader(),
                    const SizedBox( height: 16,),
                    if(!model.isLoading)
                    if(model.requestsToShow.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            return RequestItem(
                              request: model.requestsToShow[index],
                              isBusy: model.isBusyWidget(model.requestsToShow[index].id),
                              onApprove: model.onApprove,
                              onDecline: model.onDecline,
                              onEditTap: model.onUpdatePressed,
                              onDelete: model.delete,
                              );
        
                          },
                          separatorBuilder: (context, index){
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: model.requestsToShow.length,
                          ),
                      ),
                    )
                    else
                    const Expanded(
                      child: Center(
                        child: Text('No leave requet received'),
                      ),
                    )
                  ],
                ),
              )
              // : Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: RefreshIndicator(
              //       onRefresh: model.init,
              //       child: ListView.builder(
              //         physics: const AlwaysScrollableScrollPhysics(),
              //         itemCount: model.requests.length,
              //         itemBuilder: (ctx, index) {
              //           final leaveRequest = model.requests[index];
              //           return RequestItem(
              //             request: leaveRequest,
              //             isBusy: model.isBusyWidget('$leaveRequest-request'),
              //             onApprove: model.onApprove,
              //             onDecline: model.onDecline,
              //             onEditTap: model.onUpdatePressed,
              //             onDelete: model.delete,
              //           );
              //         },
              //       ),
              //     ),
              //   ),
        );
      },
    );
  }
}
