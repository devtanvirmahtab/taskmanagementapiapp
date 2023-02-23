import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taskmanagementapiapp/view_model/get_taskdata_view_model.dart';

import '../../res/app_url.dart';
import '../../utils/style.dart';
import '../../widgets/custom_button.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {


  final _form = GlobalKey<FormState>();

  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getTaskDataModel = Provider.of<GetTaskDataModel>(context);
    print("build");
    return Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Create Task",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("Create Task ",style: subTextStyle(context)),
                      const SizedBox(height: 25),
                      //task title field
                      TextFormField(
                        controller: _subjectTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          // prefixIcon: PrefixIcon(image: ic_user),
                          hintText: "Enter task title",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter task title";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //Last name field
                      TextFormField(
                        controller: _descriptionTEController,
                        keyboardType: TextInputType.text,
                        maxLines: 7,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          // prefixIcon: PrefixIcon(image: ic_user),
                          hintText: "Enter task description",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter task description";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),



                      const SizedBox(height: 15),
                      // submit button
                      CustomButton(loading: getTaskDataModel.loading,text: "Create Task",onTap: (){
                        if(_form.currentState!.validate()){
                          Map data =
                          {
                              "title":_subjectTEController.text,
                              "description":_descriptionTEController.text,
                              "status":"New"
                          };
                          getTaskDataModel.createApiCall(data);
                          if(getTaskDataModel.result == "success"){
                            _subjectTEController.clear();
                            _descriptionTEController.clear();
                            getTaskDataModel.getNewTaskApi(AppUrls.newTaskEndPoint);
                          }
                          // if()
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
