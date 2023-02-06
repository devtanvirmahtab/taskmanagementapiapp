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


  Map<String, double> dataMap = {
    "New":20,
    "Completed":20,
    "Cancelled":20,
    "In Progress":20,
  };
  List<Color> color = [
    Colors.blue,
    Colors.pink.withOpacity(.4),
    Colors.cyanAccent.shade700,
    appLightTextColor.withOpacity(.7)];

  List tasklist = [
    "New Task",
    "In Progress Task",
    "Completed Task",
    "Cancelled Task"
  ];



  @override
  void initState() {


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getTaskDataModel = Provider.of<GetTaskDataModel>(context,listen: false);
      getTaskDataModel.getNewTaskApi(AppUrls.newTaskEndPoint);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(kDebugMode){
      print("build");
    }
    return  SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15,),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,20,20,40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(seconds: 2),
                      chartLegendSpacing: 50,
                      chartRadius: MediaQuery.of(context).size.width / 4,
                      colorList: color,
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 32,
                      legendOptions:  LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.left,
                        showLegends: true,
                        legendTextStyle: Theme.of(context).textTheme.headline2!
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 10,),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.topLeft,
              child: Text(
                "New Task List",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.start,
              )
          ),
          const SizedBox(height: 10,),
          Consumer<GetTaskDataModel>(
            builder: (context,value,child){
              return InkWell(
                onTap: (){
                   if(kDebugMode){
                     print("consumer");
                   }
                },
                child: Container(
                  child: value.loading ? TaskShimmerEffect(count: value.getTaskModel?.data?.length,) : ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: value.getTaskModel?.data?.length ?? 0,
                    itemBuilder: (context,index){
                      var reverselist = value.getTaskModel!.data!.reversed.toList();
                      final task = reverselist[index];
                      return ItemCard(
                        title: task.title!,
                        description: task.description!,
                        status: task.status!,
                        favTap: (){},
                        editTap: (){
                          showModalSheetForChangeStatus();
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

  void showModalSheetForChangeStatus(){
    String type = "In Progress";
    showModalBottomSheet(context: context, builder: (context) {
      return StatefulBuilder(
        builder: (context,changeState) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  const Text("Change Status of Task",style: TextStyle(color: appPrimaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 25,),
                  RadioListTile(
                    title: const Text("In Progress"),
                    value: "In Progress",
                    groupValue: type,
                    onChanged: (val){
                        type = val!;
                        changeState((){

                        });

                      }
                  ),
                  RadioListTile(
                      title: const Text("Completed"),
                      value: "Completed",
                      groupValue: type,
                      onChanged: (val){
                        type = val!;
                        changeState((){

                        });
                      }
                  ),
                  RadioListTile(
                      title: const Text("Cancelled"),
                      value: "Cancelled",
                      groupValue: type,
                      onChanged: (val){
                        type = val!;
                        changeState((){

                        });
                      }
                  ),
                  const SizedBox(height: 25,),
                  CustomButton(text: "Submit",onTap: (){})
                ],
              ),
            ),
          );
        }
      );
    });
  }

}


