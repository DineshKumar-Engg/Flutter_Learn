import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/promocode/DeletepromocodeController.dart';
import 'package:connect_athlete_admin/Screens/promocode/EditpromocodeController.dart';
import 'package:connect_athlete_admin/Screens/promocode/Getall_proocode_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../Widget/common_textfield.dart';

class View_promocodescreen extends StatefulWidget {
  Map<String,dynamic> data;
   View_promocodescreen({super.key,required this.data});

  @override
  State<View_promocodescreen> createState() => _View_promocodescreenState();
}

class _View_promocodescreenState extends State<View_promocodescreen> {


  final EditpromocodeController editpromocodeController=Get.find<EditpromocodeController>();
  final DeletepromocodeController deletepromocodeController=Get.find<DeletepromocodeController>();
  final Getall_promocode_Controller getall_promocode_controller=Get.find<Getall_promocode_Controller>();


  String?SelectedProfile,SelectedStatus;
  int?profileid;
  int promocontainer=1;
 bool ?promocontainerbool=true;
  final TextEditingController codevaluecontroller=TextEditingController();
  final TextEditingController discountcontroller=TextEditingController();
  final TextEditingController subscriptionlimitcontroller=TextEditingController();
  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List <String>profiledata=['athlete','academy/club'];
  final List <String>statusdata=['Active','InActive'];
  Future<void> _selectDate(BuildContext context,controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      // firstDate: DateTime(2020),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
    }
  }

  @override
  void initState() {
    codevaluecontroller.text=widget.data['promocodeName']??'';
    SelectedProfile=widget.data['role']['roleName']??'';
    startdateController.text=widget.data['startDate']??'';
    enddateController.text=widget.data['endDate']??'';
    descriptionController.text=widget.data['promocodeDescription']??'';
    discountcontroller.text=int.parse("${widget.data['discount']}").toString()??'';
    subscriptionlimitcontroller.text=widget.data['accessLimit']??'';
    SelectedStatus=widget.data['role']['roleName']==true?"Active":"InActive";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Promo code Details"),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
               promocontainerbool==true && promocontainer==1?
                   viewPromocodedata():
                   editpromocodedata(),
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
                            editpromocodeController.EditPromocodeApi(context, codevaluecontroller.text, descriptionController.text,
                                startdateController.text, enddateController.text, discountcontroller.text,
                                subscriptionlimitcontroller.text, profileid, SelectedStatus.toString(), widget.data['id']);
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
      ),
    );
  }

  Widget viewPromocodedata(){
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
                    Text("Promo code : ",style: btntxtwhite,),
                    Text(widget.data['promocodeName']??'',style: listheadingtxt,),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Profile",style: viewtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.data['role']['roleName']??'',style: inputtxt,),
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
                          child: Text("Discount",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.data['discount']??''}",style: inputtxt,),
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
                          child: Text(widget.data['accessLimit']??'',style: inputtxt,),
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
                          child: Text("Start Date",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['startDate']??'',style: inputtxt,),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("End Date",style: viewtxt,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.data['endDate']??'',style: inputtxt,),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Active Status",style: viewtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.data['role']['roleName']==true?"Active":"InActive",style: inputtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("promo code Description",style: viewtxt,),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget('''
                              ${widget.data['promocodeDescription']??''}
                              ''',textStyle: inputtxt,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget editpromocodedata(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Code Value",style: dashboardcardtxt,),
        ),
        common_textfield(codevaluecontroller, "", TextInputType.text),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Profile",style: dashboardcardtxt,),
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
          child: Text("Discount",style: dashboardcardtxt,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: displayheight(context)*0.07,
            child: TextFormField(
              style: inputtxt,
              cursorColor: Colors.black,
              controller: discountcontroller,
              decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.percent,color: Colors.black,),
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
          child: Text("Start Date",style: dashboardcardtxt,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: displayheight(context)*0.07,
            child: TextFormField(
              onTap: ()=>_selectDate(context,startdateController),
              style: inputtxt,
              cursorColor: Colors.black,
              controller: startdateController,
              readOnly: true,
              decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month,color: Colors.black,),
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
          child: Text("End Date",style: dashboardcardtxt,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: displayheight(context)*0.07,
            child: TextFormField(
              onTap: ()=>_selectDate(context,enddateController),
              style: inputtxt,
              cursorColor: Colors.black,
              controller: enddateController,
              readOnly: true,
              decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month,color: Colors.black,),
                  enabledBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: textfieldcolor),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderSide:const  BorderSide(color: textfieldcolor),
                      borderRadius: BorderRadius.circular(10.0)
                  )
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Subscription Limit",style: dashboardcardtxt,),
        ),
        common_textfield(subscriptionlimitcontroller, "", TextInputType.number),
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
                });
              },

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Promocode Description",style: dashboardcardtxt,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: TextFormField(
              maxLines: 4,
              style: inputtxt,
              cursorColor: Colors.black,
              controller: descriptionController,
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
          child: Text("Are you sure you want to Delete the Promo code.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deletepromocodeController.DeletePromocodeApi(context, id);
              getall_promocode_controller.GetPromocodeApi(context);
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
