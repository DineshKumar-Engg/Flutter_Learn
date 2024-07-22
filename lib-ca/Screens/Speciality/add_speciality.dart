import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/addspeciality_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/service/Get_sportlist_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/common_textfield.dart';
import '../../Widget/snackbar.dart';

class add_speciality extends StatefulWidget {
  const add_speciality({super.key});

  @override
  State<add_speciality> createState() => _add_specialityState();
}

class _add_specialityState extends State<add_speciality> {

  final TextEditingController specialitynamecontroller=TextEditingController();
  String?Selectedsport;
  int?sportid;


  final Get_sport_Controller get_sport_controller=Get.find<Get_sport_Controller>();
  final addspeciality_Controller addspeciality_controller=Get.find<addspeciality_Controller>();
  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();

  @override
  void initState() {
   get_sport_controller.GetsportApi(context);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Speciality"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Speciality Name",style: subscriptiontxt,),
            ),
            common_textfield(specialitynamecontroller, "", TextInputType.name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Sport Name",style: subscriptiontxt,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  border: const OutlineInputBorder(),
                ),
                value: sportid,
                items: get_sport_controller.getsportdata.map((item) {
                  return DropdownMenuItem(
                    value: item['id'],
                    child: Text(item['sportName'],style: inputtxt,),
                    onTap: (){
                      setState(() {
                        Selectedsport=item['sportName'];
                        sportid=item['id'];
                      });
                    },
                  );
                }).toList(),
                dropdownColor: Colors.white,
                onChanged: (newValue) {
                  setState(() {
                    Selectedsport = newValue as String;
                  });
                },

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
                      onPressed: ()async{
                        if(specialitynamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Speciality Name", Icons.info, Colors.red);
                        }
                        else if(Selectedsport==null){
                          StackDialog.show("Required Field is Empty", "Select Sport", Icons.info, Colors.red);
                        }
                        else{
                          addspeciality_controller.AddSpecialityApi(context, specialitynamecontroller.text, sportid);
                          specialitynamecontroller.text='';
                          Selectedsport='';
                          await getspeciality_controller.GetspecialityApi(context);
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
