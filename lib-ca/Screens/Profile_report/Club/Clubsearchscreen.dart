import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/club_report.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/Loading.dart';
import '../../../service/CitylistController.dart';
import '../../../service/GetStatelistController.dart';
import '../../Sport/Getall_sport_Controller.dart';
import '../Athlete/AthleteSearchController.dart';

class Clubsearchscreen extends StatefulWidget {
  const Clubsearchscreen({super.key});

  @override
  State<Clubsearchscreen> createState() => _ClubsearchscreenState();
}

class _ClubsearchscreenState extends State<Clubsearchscreen> {
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final GetallCitylistController getallCitylistController=Get.find<GetallCitylistController>();
  final ClubsearchController clubsearchController=Get.find<ClubsearchController>();

  String?selectedage,selectedgender,publishstatus,subscriptionstatus;
  String?Selectedsportid,selectestateid,selectedcityid,publishid;

  List<dynamic> agelist=['09','10','11','12','13','14','15','16','17','18+'];
  List <dynamic> genderlist=['Male','Female','Others'];
  List <dynamic> publishlist=['Active','Inactive'];
  List <dynamic> subscriptionlist=['Active','Inactive','Expired'];

  @override
  void initState() {
    getall_sport_controller.GetSportApi(context);
    getallCitylistController.GetCitylistApi(context);
    statelistController.StatelistApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List sportlist = getall_sport_controller.getsportdata.map((item) =>(item['sportName'].toString())).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = getallCitylistController.getcitylistdata.map((item) =>(item['name'].toString())).toList();
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Club & Academics Search"),
      body:Column(
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
                          await clubsearchController.ClubsearchApi(context, Selectedsportid??'', selectestateid??'', selectedcityid??'', publishid??'', subscriptionstatus??'');
                          Navigator.pop(context);
                          List<Map<String,dynamic>> data=List<Map<String,dynamic>>.from(clubsearchController.clubsearchdata[0]);
                          Get.to(club_report(data:data,sport:Selectedsportid??'',city:selectedcityid??'',state:selectestateid??'',subscription:subscriptionstatus??'',publish:publishstatus??''));
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
