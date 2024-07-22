import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/club_report.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payment_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payments.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';

import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/Loading.dart';
import '../../../service/CitylistController.dart';
import '../../../service/GetStatelistController.dart';
import '../../Sport/Getall_sport_Controller.dart';

class Club_report_searchscreen extends StatefulWidget {
  const Club_report_searchscreen({super.key});

  @override
  State<Club_report_searchscreen> createState() => _Club_report_searchscreenState();
}

class _Club_report_searchscreenState extends State<Club_report_searchscreen> {

  final TextEditingController clubnamecontroller=TextEditingController();



  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final GetallCitylistController getallCitylistController=Get.find<GetallCitylistController>();
  final Club_payment_Controller club_payment_controller=Get.find<Club_payment_Controller>();


  List <dynamic> publishlist=['Active','Inactive'];
  List <dynamic> subscriptionlist=['Active','Inactive','Expired'];
  String?selectedage,selectedgender,publishstatus,subscriptionstatus;
  String?Selectedsportid,selectestateid,selectedcityid,publishid;
  @override
  Widget build(BuildContext context) {
    List sportlist = getall_sport_controller.getsportdata.map((item) =>(item['sportName'].toString())).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = getallCitylistController.getcitylistdata.map((item) =>(item['name'].toString())).toList();
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Academic Report Search"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Club & Academic Name",style: inputtxt,),
                  ),
                  common_textfield(clubnamecontroller, "", TextInputType.text),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Your Sport",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  MultiSelectDropdown.simpleList(
                        list: sportlist,
                        textStyle: inputtxt,
                        duration:const Duration(microseconds: 0),
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        whenEmpty: "",
                        listTextStyle: inputtxt,
                        checkboxFillColor:primary,
                        initiallySelected: [],
                        onChange: (newList) async{
                          sportlist=newList;
                          List selectedStateIds = newList.map((name) {
                            var stateItem = getall_sport_controller.getsportdata.firstWhere((item) => item['sportName'] == name);
                            return stateItem['id'];
                          }).toList();
                          String valuestring=selectedStateIds.join(',');
                          Selectedsportid=valuestring;
                          // await updateCityData();
                          print(Selectedsportid);

                        },
                      )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Your State",style: inputtxt,),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:  MultiSelectDropdown.simpleList(
                            list: state,
                            splashColor: Colors.white,
                            textStyle: inputtxt,
                            duration:const Duration(microseconds: 0),
                            boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            whenEmpty: "",
                            listTextStyle: inputtxt,
                            checkboxFillColor:primary,
                            initiallySelected: [],
                            onChange: (newList) async{
                              state=newList;
                              List selectedStateIds = newList.map((name) {
                                var stateItem = statelistController.statedata.firstWhere((item) => item['name'] == name);
                                return stateItem['id'];
                              }).toList();
                              String valuestring=selectedStateIds.join(',');
                              selectestateid=valuestring;

                            },
                          )
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Your City",style: inputtxt,),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:MultiSelectDropdown.simpleList(
                            list: city,
                            boxDecoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            whenEmpty: "",
                            duration:const Duration(microseconds: 0),
                            textStyle: inputtxt,
                            listTextStyle: inputtxt,
                            checkboxFillColor:primary,
                            initiallySelected:[],
                            onChange: (newList) {
                              List selectedCityIds = newList.map((name) {
                                var cityItem = getallCitylistController.getcitylistdata.firstWhere((item) => item['name'] == name,
                                  orElse: () => null,
                                );
                                return cityItem != null ? cityItem['id'] : null;
                              }).where((id) => id != null).toList();
                              selectedcityid = selectedCityIds.join(',');
                              print(selectedcityid);
                            },
                          )
                      ),

                    ],
                  ),
                  SizedBox(
                    // height: displayheight(context)*0.12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Publish",style: inputtxt,),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:  SizedBox(
                                  width: displaywidth(context)*0.45,
                                  child: MultiSelectDropdown.simpleList(
                                    list: publishlist,
                                    textStyle: inputtxt,
                                    duration:const Duration(microseconds: 0),
                                    boxDecoration: BoxDecoration(
                                        border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    whenEmpty: "",
                                    listTextStyle: inputtxt,
                                    checkboxFillColor:primary,
                                    initiallySelected: [],
                                    onChange: (newList) async{
                                      publishstatus=newList.join(',');
                                      if(publishstatus=="Active"){
                                        publishid="1";
                                        print(publishid);
                                      }else{
                                        publishid="0";
                                        print(publishid);
                                      }

                                    },
                                  ),
                                )
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Subscription",style: inputtxt,),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:  SizedBox(
                                  width: displaywidth(context)*0.45,
                                  child: MultiSelectDropdown.simpleList(
                                    list: subscriptionlist,
                                    numberOfItemsLabelToShow: 1,
                                    textStyle: inputtxt,
                                    duration:const Duration(microseconds: 0),
                                    boxDecoration: BoxDecoration(
                                        border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    whenEmpty: "",
                                    listTextStyle: inputtxt,
                                    checkboxFillColor:primary,
                                    initiallySelected: [],
                                    onChange: (newList) async{
                                      subscriptionstatus=newList.join(',');
                                      print(subscriptionstatus);

                                    },
                                  ),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )),
                        onPressed: ()async{
                          showloadingdialog(context);
                          await club_payment_controller.ClubReportApi(context, clubnamecontroller.text??'', publishstatus??'', '', '', selectestateid??'', selectedcityid??'', Selectedsportid??'', '', '');
                          Navigator.pop(context);
                          List<Map<String,dynamic>> data=List<Map<String,dynamic>>.from(club_payment_controller.getclubreports);
                          Get.to(ClubPaymentscreen(data:data));
                        },child: Text("Search",style: btntxtwhite,),),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
