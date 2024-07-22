import 'dart:async';
import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/add_speciality.dart';
import 'package:connect_athlete_admin/Screens/Speciality/deletespeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/editspeciality_Controller.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/appbar_widget.dart';
import '../../service/Get_sportlist_Controller.dart';

class speciality_screen extends StatefulWidget {
  const speciality_screen({super.key});

  @override
  State<speciality_screen> createState() => _speciality_screenState();
}

class _speciality_screenState extends State<speciality_screen> {

  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();
  final deletespeciality_Controller deletespeciality_controller=Get.find<deletespeciality_Controller>();
  final Get_sport_Controller get_sport_controller=Get.find<Get_sport_Controller>();
  final Editspeciality_Controller editspeciality_controller=Get.find<Editspeciality_Controller>();

  final TextEditingController edittextcontroller=TextEditingController();

  int?selectedindex;
  String?Selectedsport;
  int?sportid;

  @override
  void initState() {
    getspeciality_controller.GetspecialityApi(context);
    get_sport_controller.GetsportApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Speciality"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Speciality's", style: subscriptiontxt),
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
                        Get.to(const add_speciality());
                      },
                      child: Text("+ Add Speciality", style: subscriptionbtntxtwhite),
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
                            width: displaywidth(context) * 0.08,
                            child: Text("S.No", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.30,
                            child: Center(child: Text("Speciality", style: listheadingtxt)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.24,
                            child: Center(child: Text("Sport", style: listheadingtxt)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.12,
                            child: Center(child: Text("Action", style: listheadingtxt)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() {
                    if(getspeciality_controller.getspeciality_data.isEmpty){
                      return Center(child: Text("No Speciality data Found",style: inputtxt,));
                    }
                    return RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: primary,
                      onRefresh: () async{
                        await getspeciality_controller.GetspecialityApi(context);
                      },
                      child: ListView.builder(
                        itemCount: getspeciality_controller.getspeciality_data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data = getspeciality_controller.getspeciality_data[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: selectedindex == index ? const Color(0XFFD4D5E2) : Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displaywidth(context) * 0.08,
                                      child: Center(child: Text("${index + 1}.", style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.42,
                                      child: Center(child: Text(data['specialityData']['specialityTitle'], style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.22,
                                      child: Center(child: Text(data['sportData']['sportName']??'', style: listsubheadingtxt)),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.18,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                editspecialitybottom(context, data['specialityData']['specialityTitle'],
                                                    data['sportData']['sportName'], data['specialityData']['id']);
                                              },
                                              child: const Icon(Icons.edit, color: primary,)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                logout(data['specialityData']['id']);
                                              },
                                              child: const Icon(CupertinoIcons.delete, color: Colors.red,),
                                            ),
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
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  logout(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete, color: Colors.red, size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Speciality Data.", style: inputtxt, textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              deletespeciality_controller.DeleteSpecialityApi(context, id);
              Get.back();
            });
          }, child: Text("Yes", style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child: Text("No", style: drawertxt,))
        ],
      );
    });
  }

  editspecialitybottom(BuildContext context, String specialityname, String sportname, int id){
    var selectedSportData = get_sport_controller.getsportdata.firstWhere((item) => item['sportName'] == sportname, orElse: () => null);
    sportid = selectedSportData != null ? selectedSportData['id'] : null;
    Selectedsport = sportname;
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context, builder: (context){
      edittextcontroller.text = specialityname;
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
                child: Divider(color: secondary, thickness: 3,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Edit Speciality", style: edittxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Speciality Name", style: listsubheadingtxt,),
              ),
              common_textfield(edittextcontroller, "", TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sport Name", style: listsubheadingtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  value: sportid,
                  items: get_sport_controller.getsportdata.map((item) {
                    return DropdownMenuItem(
                      value: item['id'],
                      child: Text(item['sportName'], style: inputtxt,),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {
                    setState(() {
                      sportid = newValue as int?;
                      Selectedsport = get_sport_controller.getsportdata.firstWhere((item) => item['id'] == sportid)['sportName'];
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: SizedBox(
                  height: displayheight(context) * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: secondary, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
                    onPressed: (){
                      Get.back();
                      editspeciality_controller.EditSpecialityApi(context, edittextcontroller.text, sportid, id);
                    },
                    child: Center(child: Text("Edit", style: btntxtwhite,)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    );
  }
}
