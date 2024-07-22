import 'package:connect_athlete_admin/Screens/subscription/DeletesubscriptionController.dart';
import 'package:connect_athlete_admin/Screens/subscription/EditsubscriptionController.dart';
import 'package:connect_athlete_admin/Screens/subscription/Getall_subscription_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/common_textfield.dart';

class Viewsubscription_screen extends StatefulWidget {
  Map<String,dynamic> data;
   Viewsubscription_screen({super.key,required this.data});

  @override
  State<Viewsubscription_screen> createState() => _Viewsubscription_screenState();
}

class _Viewsubscription_screenState extends State<Viewsubscription_screen> {

  final EditsubscriptionController editsubscriptionController=Get.find<EditsubscriptionController>();
  final DeletesubscriptionController deletesubscriptionController=Get.find<DeletesubscriptionController>();
  final Getall_subscription_Controller getall_subscription_controller=Get.find<Getall_subscription_Controller>();

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
  final List <String>profiledata=['athlete','academy/club'];
  final List <String>statusdata=['Active','InActive'];
  int promocontainer=1;
  bool ?promocontainerbool=true;

  @override
  void initState() {
    plannamecontroller.text=widget.data['subscriptionName']??'';
    SelectedProfile=widget.data['role']['roleName']??'';
    limitcontroller.text=int.parse("${widget.data['subscriptionLimit']}").toString();
    durationcontroller.text=int.parse("${widget.data['subscriptionMonth']}").toString();
    subscriptionamountcontroller.text=widget.data['subscriptionAmount']??'';
    processingfeecontroller.text=widget.data['processingTax']??'';
    conveiencefeecontroller.text=widget.data['convenienceTax']??'';
    servicecontroller.text=widget.data['serviceTax']??'';
    descriptioncontroller.text=widget.data['description']??'';
    SelectedStatus=widget.data['subscribtionStatus']==true?"Active":"InActive";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Subscription Details"),
      body:   Padding(
        padding:const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child:Column(
            children: [
              promocontainerbool==true && promocontainer==1?
              viewsubscriptiondata():
              editsubscriptiondata(),
              promocontainerbool==true && promocontainer==1?
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                          setState(() {
                            promocontainer=2;
                          });

                        },child: Center(child: Text("Edit",style: btntxtwhite,),),
                      ) ,
                    ),
                    SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                          delete(widget.data['id']);
                        },child: Center(child: Text("Delete",style: btntxtred,),),
                      ) ,
                    )

                  ],
                ),
              ):
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                          setState(() {
                            promocontainer=1;
                          });

                        },child: Center(child: Text("Back",style: btntxtwhite,),),
                      ) ,
                    ),
                    SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                          editsubscriptionController.EditSubscriptionApi(context, plannamecontroller.text, profileid, limitcontroller.text,
                              durationcontroller.text, subscriptionamountcontroller.text, processingfeecontroller.text,
                              conveiencefeecontroller.text, servicecontroller.text, descriptioncontroller.text,SelectedStatusbool.toString(),widget.data['id']);
                          getall_subscription_controller.GetSubscripionApi(context);

                        },child: Center(child: Text("Submit",style: btntxtwhite,),),
                      ) ,
                    )

                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
  Widget viewsubscriptiondata(){
    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.30,
                offset: Offset(0.2, 0.2),
                blurRadius: 0.5
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:15.0),
            child: Container(
              color: primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 4.0),
                child: Row(
                  children: [
                    Text("Plan Name : ",style: btntxtwhite,),
                    Text(widget.data['subscriptionName'],style: listheadingtxt,),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Profile",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['role']['roleName'],style: inputtxt,),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Subscription Amount",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['subscriptionAmount'],style: inputtxt,),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Duration",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.data['subscriptionMonth']} month",style: inputtxt,),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Subscription Limit",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.data['subscriptionLimit']}",style: inputtxt,),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Processing Fee",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['processingTax'],style: inputtxt,),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("convenience Fee",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['convenienceTax'],style: inputtxt,),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Active Status",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.data['subscribtionStatus']==true?"Active":"InActive"}",style: inputtxt,),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Service Fee",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['serviceTax'],style: inputtxt,),
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Description",style: viewtxt,),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget('''
                              ${widget.data['description']}
                              ''',textStyle: inputtxt,)
                ),
              ],
            ),
          )


        ],
      ),
    );
  }

  Widget editsubscriptiondata(){
    return  Column(
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
                if (SelectedProfile == 'athlete') {
                  profileid=2;
                } else if (SelectedProfile == 'club/academy') {
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


      ],
    );
  }


  delete(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Subscription Plan.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deletesubscriptionController.DeleteSubscriptionApi(context, id);
              getall_subscription_controller.GetSubscripionApi(context);
            });
          }, child:  Text("Yes",style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child:  Text("No",style: drawertxt,))
        ],
      );
    });

  }
}
