import 'package:connect_athlete_admin/Screens/Billing/AddBillingstate_Controller.dart';
import 'package:connect_athlete_admin/Screens/Billing/Getall_Billing_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:connect_athlete_admin/service/GetStatelistController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';

class Addbillingstatescreen extends StatefulWidget {
  const Addbillingstatescreen({super.key});

  @override
  State<Addbillingstatescreen> createState() => _AddbillingstatescreenState();
}

class _AddbillingstatescreenState extends State<Addbillingstatescreen> {

  final StatelistController statelistController=Get.find<StatelistController>();
  final AddbillingstateController addbillingstateController=Get.find<AddbillingstateController>();
  final Getall_Billing_Controller getall_billing_controller=Get.find<Getall_Billing_Controller>();

  final TextEditingController taxcontroller=TextEditingController();
  String?SelectedState;
  int?stateid;
  @override
  void initState() {
   statelistController.StatelistApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Billing State"),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Text("Billing State",style: dashboardcardtxt,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4.0),
              child: DropdownButtonFormField(
                menuMaxHeight: displayheight(context)*0.60,
                decoration: InputDecoration(
                  hintText: "Select State",
                  // hintStyle: textfieldhint,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  border: const OutlineInputBorder(),
                ),
                value: SelectedState,
                onChanged: (newValue) {
                  setState(() {
                    SelectedState = newValue as String?;
                  });
                },
                items: statelistController.statedata.map((item) {
                  return DropdownMenuItem(
                    value: item['name'],
                    child: Text(item['name'],style: inputtxt,),
                    onTap: (){
                      setState(() {
                        stateid=item['id'];
                        SelectedState=item['name'];
                      });
                    },
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
            ),
            Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Text("Tax",style: dashboardcardtxt,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: displayheight(context)*0.07,
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: Colors.black,
                  controller: taxcontroller,
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
              padding: const EdgeInsets.only(top:30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: displayheight(context)*0.06,
                    width: displaywidth(context)*0.45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )),
                      onPressed: (){
                        if(SelectedState==null){
                          StackDialog.show("Required Field is Empty", "Select State", Icons.info, Colors.red);
                        }
                        else if(taxcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter the Tax", Icons.info, Colors.red);
                        }
                        else {
                          addbillingstateController.AddBillingstateApi(context, SelectedState,taxcontroller.text);
                          getall_billing_controller.GetbillingstateApi(context);
                        }
                      },child: Center(child: Text("Submit",style: btntxtwhite,),),
                    ) ,
                  ),
                  SizedBox(
                    height: displayheight(context)*0.06,
                    width: displaywidth(context)*0.45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )),
                      onPressed: (){
                        Get.back();
                      },child: Center(child: Text("Cancel",style: btntxtred,),),
                    ) ,
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}
