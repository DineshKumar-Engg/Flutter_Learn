import 'package:connect_athlete_admin/Screens/Billing/Addbillingstate_screen.dart';
import 'package:connect_athlete_admin/Screens/Billing/DeletebillingstateController.dart';
import 'package:connect_athlete_admin/Screens/Billing/EditbillingstateController.dart';
import 'package:connect_athlete_admin/service/GetStatelistController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/appbar_widget.dart';
import '../../Widget/common_textfield.dart';
import 'Getall_Billing_Controller.dart';

class billing_state extends StatefulWidget {
  const billing_state({super.key});

  @override
  State<billing_state> createState() => _billing_stateState();
}

class _billing_stateState extends State<billing_state> {
  int?selectedindex;
  String?SelectedState;
  int?stateid;

  final TextEditingController statecontroller=TextEditingController();

  final Getall_Billing_Controller getall_billing_controller=Get.find<Getall_Billing_Controller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final DeletebillingstateController deletebillingstateController=Get.find<DeletebillingstateController>();
  final EditbillingstateController editbillingstateController=Get.find<EditbillingstateController>();

  @override
  void initState() {
   getall_billing_controller.GetbillingstateApi(context);
   statelistController.StatelistApi(context);
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Billing State"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Header with "Subscription Plans" and "Add Subscription" button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Billing States", style: subscriptiontxt),
                  SizedBox(
                    height: displayheight(context) * 0.05,
                    width: displaywidth(context) * 0.40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.to(Addbillingstatescreen());
                      },
                      child: Text("+ Add State", style: subscriptionbtntxtwhite),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.10,
                            child: Text("S.No", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.32,
                            child: Center(child: Text("State", style: listheadingtxt)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.15,
                            child: Text("Tax", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.15,
                            child: Center(child: Text("Action", style: listheadingtxt)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: displayheight(context) * 0.70,
                  width: double.infinity,
                  child: Obx(() {
                    return RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: secondary,
                      onRefresh: () async {
                        await getall_billing_controller.GetbillingstateApi(
                            context);
                      },
                      child: ListView.builder(
                        itemCount: getall_billing_controller.getbillingstatedata
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data = getall_billing_controller
                              .getbillingstatedata[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: selectedindex == index ? const Color(
                                    0XFFD4D5E2) : Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade200),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displaywidth(context) * 0.10,
                                      child: Center(child: Text("${index + 1}.",
                                          style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.42,
                                      child: Center(child: Text(
                                          data['stateName'] ?? '',
                                          style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.18,
                                      child: Center(child: Text("${data['tax']??''}%",
                                          style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.20,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                editspecialitybottom(
                                                    context, data['stateName'],
                                                    data['tax'], data['id']);
                                              },
                                              child: const Icon(
                                                Icons.edit, color: primary,)),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: InkWell(
                                                onTap: () {
                                                  delete(data['id']);
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.delete,
                                                  color: Colors.red,)),
                                          )

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  delete(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Billing State.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deletebillingstateController.DeleteBillingstateApi(context, id);
              getall_billing_controller.GetbillingstateApi(context);
            });
          }, child:  Text("Yes",style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child:  Text("No",style: drawertxt,))
        ],
      );
    });

  }

  editspecialitybottom(BuildContext context,String statename,String tax,id){
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context, builder: (context){
          SelectedState=statename;
          statecontroller.text=tax;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(color: secondary,thickness: 3,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Edit Billing State",style:edittxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Billing State",style: listsubheadingtxt,),
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
                padding: const EdgeInsets.all(8.0),
                child: Text("Tax",style: listsubheadingtxt,),
              ),
              common_textfield(statecontroller, "", TextInputType.text),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                child: SizedBox(
                  height: displayheight(context)*0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )),
                      onPressed: (){
                        editbillingstateController.EditBillingstateApi(context,SelectedState,statecontroller.text,id);
                        getall_billing_controller.GetbillingstateApi(context);
                        Get.back();
                      }, child: Center(child: Text("Edit",style: btntxtwhite,))),
                ),
              )

            ],
          ),
        ),
      );
    });
  }

}
