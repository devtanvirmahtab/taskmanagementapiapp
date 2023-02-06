import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapiapp/res/app_url.dart';
import 'package:taskmanagementapiapp/view_model/get_taskdata_view_model.dart';

import '../../utils/colors.dart';
import '../../widgets/task_shimmier_effect.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}



class _CompletedTaskScreenState extends State<CompletedTaskScreen> {


  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getTaskDataModel = Provider.of<GetTaskDataModel>(context,listen: false);
      getTaskDataModel.getNewTaskApi(AppUrls.completedTaskEndPoint);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getTaskdatamodel = Provider.of<GetTaskDataModel>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Consumer<GetTaskDataModel>(
          builder: (context,value,child){
            return value.loading ? TaskShimmerEffect(count: value.getTaskModel?.data?.length,) : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: value.getTaskModel?.data?.length ?? 0,
              itemBuilder: (context,index){
                var taskList = value.getTaskModel!.data!.toList();
                final task = taskList[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(task.title ?? "",style: const TextStyle(color: appPrimaryColor,fontSize: 20,fontWeight: FontWeight.w700),),
                            Icon(Icons.favorite_outline_outlined,color: appPrimaryColor),
                          ],
                        ),
                        Text(task.title ?? "",style: TextStyle(color: appLightTextColor.withOpacity(.7),fontSize: 14),),
                        Chip(
                          label: Text(task.status ?? ""),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      )

    );
  }
}
