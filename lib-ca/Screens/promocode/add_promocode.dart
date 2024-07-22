import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/promocode/Addpromocode_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common_size.dart';

class add_promocode extends StatefulWidget {
  const add_promocode({super.key});

  @override
  State<add_promocode> createState() => _add_promocodeState();
}

class _add_promocodeState extends State<add_promocode> {


  final AddpromocodeController addpromocodeController=Get.find<AddpromocodeController>();

  String?SelectedProfile,SelectedStatus,SelectedStatusbool;
  int?profileid;

  final TextEditingController codevaluecontroller=TextEditingController();
  final TextEditingController discountcontroller=TextEditingController();
  final TextEditingController subscriptionlimitcontroller=TextEditingController();
  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List <String>profiledata=['Athlete','Club and Academy'];
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
        controller.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Promo Code"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: displayheight(context)*0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor:secondary,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
                    onPressed: (){
                      if(codevaluecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter the Promo code value", Icons.info, Colors.red);
                      }
                      else if(SelectedProfile==null){
                        StackDialog.show("Required Field is Empty", "Select Profile", Icons.info, Colors.red);
                      }
                      else if(discountcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter the Discount", Icons.info, Colors.red);
                      }
                      else if(startdateController.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Select Start Date", Icons.info, Colors.red);
                      }
                      else if(enddateController.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Select End Date", Icons.info, Colors.red);
                      }
                      else if(subscriptionlimitcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Subscription Limit", Icons.info, Colors.red);
                      }
                      else if(SelectedStatus==null){
                        StackDialog.show("Required Field is Empty", "Select Status", Icons.info, Colors.red);
                      }
                      else{
                        addpromocodeController.AddPromocodeApi(context, codevaluecontroller.text,
                            descriptionController.text, startdateController.text, enddateController.text,
                            discountcontroller.text, subscriptionlimitcontroller.text, profileid,SelectedStatusbool);
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
