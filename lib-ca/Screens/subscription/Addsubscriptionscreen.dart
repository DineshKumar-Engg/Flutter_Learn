import 'package:connect_athlete_admin/Screens/subscription/AddsubscriptionController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';

class Addsubscriptionscreen extends StatefulWidget {
  const Addsubscriptionscreen({super.key});

  @override
  State<Addsubscriptionscreen> createState() => _AddsubscriptionscreenState();
}

class _AddsubscriptionscreenState extends State<Addsubscriptionscreen> {

  final AddsubscriptionController addsubscriptionController=Get.find<AddsubscriptionController>();

  final TextEditingController plannamecontroller=TextEditingController();
  final TextEditingController descriptioncontroller=TextEditingController();
  final TextEditingController limitcontroller=TextEditingController();
  final TextEditingController durationcontroller=TextEditingController();
  final TextEditingController subscriptionamountcontroller=TextEditingController();
  final TextEditingController processingfeecontroller=TextEditingController();
  final TextEditingController conveiencefeecontroller=TextEditingController();
  final TextEditingController servicecontroller=TextEditingController();

  String?SelectedProfile,SelectedStatus,SelectedStatusbool;
  int?profileid;
  final List <String>profiledata=['Athlete','Club and Academy'];
  final List <String>statusdata=['Active','InActive'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Subscription"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Subscription Name",style: dashboardcardtxt,),
              ),
              common_textfield(plannamecontroller, "", TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Profile",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: DropdownButtonFormField(
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                      ),
                    ),
                    value: SelectedProfile,
                    items: profiledata.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item,style: inputtxt,),
                        onTap: (){
                          setState(() {
                            SelectedProfile=item;
          
                          });
                        },
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        SelectedProfile = newValue as String;
                      });
                      if (SelectedProfile == 'Athlete') {
                        profileid=2;
                      } else if (SelectedProfile == 'Club and Academy') {
                        profileid=4;// or any other action
                      }
                      print(profileid);
                    },
          
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Subscription Limit",style: dashboardcardtxt,),
              ),
              common_textfield(limitcontroller, "", TextInputType.number),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Duration (Month)",style: dashboardcardtxt,),
              ),
              common_textfield(durationcontroller, "", TextInputType.number),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Subscription Amount",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: TextFormField(
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: subscriptionamountcontroller,
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money_rounded,color: Colors.black,),
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Processing Fee",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: TextFormField(
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: processingfeecontroller,
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money_rounded,color: Colors.black,),
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Convenience Fee ",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: TextFormField(
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: conveiencefeecontroller,
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money_rounded,color: Colors.black,),
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Service Fee",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: TextFormField(
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: servicecontroller,
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money_rounded,color: Colors.black,),
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Status",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.07,
                  child: DropdownButtonFormField(
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                      ),
                    ),
                    value: SelectedStatus,
                    items: statusdata.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item,style: inputtxt,),
                        onTap: (){
                          setState(() {
                            SelectedStatus=item;
                          });
                        },
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        SelectedStatus = newValue as String;
                        if(SelectedStatus=='Active'){
                          SelectedStatusbool="true";
                        }
                        else{
                          SelectedStatusbool="false";

                        }
                        print(SelectedStatusbool);
                      });
                    },

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description",style: dashboardcardtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: TextFormField(
                    maxLines: 4,
                    style: inputtxt,
                    cursorColor: Colors.black,
                    controller: descriptioncontroller,
                    decoration:  InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor:secondary,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
                    onPressed: (){
                      if(plannamecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Subscription Plan Name", Icons.info, Colors.red);
                      }
                      else if(SelectedProfile==null){
                        StackDialog.show("Required Field is Empty", "Select Profile", Icons.info, Colors.red);
                      }
                      else if(limitcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Subscription Limit", Icons.info, Colors.red);
                      }
                      else if(durationcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Subscription Duration", Icons.info, Colors.red);
                      }
                      else if(subscriptionamountcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Subscription Amount", Icons.info, Colors.red);
                      }
                      else if(processingfeecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Processing Fee", Icons.info, Colors.red);
                      }
                      else if(conveiencefeecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Convenience Fee", Icons.info, Colors.red);
                      }
                      else if(servicecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Service Fee", Icons.info, Colors.red);
                      }
                      else if(SelectedStatus==null){
                        StackDialog.show("Required Field is Empty", "Select Status", Icons.info, Colors.red);
                      }
                      else{
                        addsubscriptionController.AddSubscriptionApi(context, plannamecontroller.text, profileid, limitcontroller.text,
                            durationcontroller.text, subscriptionamountcontroller.text, processingfeecontroller.text,
                            conveiencefeecontroller.text, servicecontroller.text, descriptioncontroller.text,SelectedStatusbool.toString());
                      }
                    },child: Center(child: Text("Submit",style: btntxtwhite,),),
                  ) ,
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
