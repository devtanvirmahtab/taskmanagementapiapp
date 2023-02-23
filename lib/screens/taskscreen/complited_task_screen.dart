import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapiapp/res/app_url.dart';
import 'package:taskmanagementapiapp/view_model/get_taskdata_view_model.dart';

import '../../utils/colors.dart';
import '../../widgets/item_card.dart';
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

                return ItemCard(
                  title: task.title!,
                  description: task.description!,
                  status: task.status!,
                  favTap: (){},
                  editTap: (){

                  },
                );
              },
            );
          },
        ),
      )

    );
  }
}
