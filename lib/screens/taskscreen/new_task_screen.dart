import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:taskmanagementapiapp/utils/colors.dart';
import 'package:taskmanagementapiapp/view_model/get_taskdata_view_model.dart';
import 'package:taskmanagementapiapp/widgets/custom_button.dart';

import '../../res/app_url.dart';
import '../../widgets/item_card.dart';
import '../../widgets/task_shimmier_effect.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<Color> color = [
    Colors.blue,
    Colors.pink.withOpacity(.4),
    Colors.cyanAccent.shade700,
    appLightTextColor.withOpacity(.7)
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getTaskDataModel =
          Provider.of<GetTaskDataModel>(context, listen: false);
      getTaskDataModel.getStatusCountApi(AppUrls.taskStatusCountEndPointUrl);
      getTaskDataModel.getNewTaskApi(AppUrls.newTaskEndPoint);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getTaskDataModel = Provider.of<GetTaskDataModel>(context, listen: false);
    Map<String, double> dataMap={
      "${getTaskDataModel.totalCompletedtitle}": getTaskDataModel.totalCompleted.toDouble() ,
      "${getTaskDataModel.totalProgresstitle}":getTaskDataModel.totalProgress.toDouble(),
      "${getTaskDataModel.totalCancelledtitle}":getTaskDataModel.totalCancelled.toDouble(),
      "${getTaskDataModel.totalNewtitle}":getTaskDataModel.totalNew.toDouble(),
    };

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Consumer<GetTaskDataModel>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: value.loadingCount? TaskShimmerEffect(count: 1) :  PieChart(
                            dataMap: dataMap ,
                            animationDuration: const Duration(seconds: 2),
                            chartLegendSpacing: 50,
                            chartRadius: MediaQuery.of(context).size.width / 4,
                            colorList: color,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle:
                                    Theme.of(context).textTheme.headline2!),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )    ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.topLeft,
              child: Text(
                "New Task List",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.start,
              )),
          const SizedBox(
            height: 10,
          ),
          Consumer<GetTaskDataModel>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print("consumer");
                  }
                },
                child: Container(
                  child: value.loading
                      ? TaskShimmerEffect(
                          count: value.getTaskModel?.data?.length,
                        )
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: value.getTaskModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var reverselist =
                                value.getTaskModel!.data!.reversed.toList();
                            final task = reverselist[index];
                            return ItemCard(
                              title: task.title!,
                              description: task.description!,
                              status: task.status!,
                              favTap: () {},
                              editTap: () {
                                showModalSheetForChangeStatus(task.sId!);
                              },
                            );
                          },
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void showModalSheetForChangeStatus(String taskId) {
    final getTaskDataModel =
        Provider.of<GetTaskDataModel>(context, listen: false);

    String taskStatus = "InProgress";
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Change Status of Task",
                      style: TextStyle(
                          color: appPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RadioListTile(
                        title: const Text("InProgress"),
                        value: "InProgress",
                        groupValue: taskStatus,
                        onChanged: (val) {
                          taskStatus = val!;
                          changeState(() {});
                        }),
                    RadioListTile(
                        title: const Text("Completed"),
                        value: "Completed",
                        groupValue: taskStatus,
                        onChanged: (val) {
                          taskStatus = val!;
                          changeState(() {});
                        }),
                    RadioListTile(
                        title: const Text("Cancelled"),
                        value: "Cancelled",
                        groupValue: taskStatus,
                        onChanged: (val) {
                          taskStatus = val!;
                          changeState(() {});
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                        loading: getTaskDataModel.loading,
                        text: "Submit",
                        onTap: () {
                          getTaskDataModel.getChangeStatusApi(
                              AppUrls.ChangeStatusEndPoint(taskId, taskStatus));
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
        });
  }
}
