import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Screens/Search%20List/Coach/CoachList.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import '../../../Services/Search service/Coach search.dart';
import '../../../Services/get data/City_list.dart';
import '../../../Services/get data/List Sports.dart';
import '../../../Services/get data/getall_cities.dart';
import '../../../Services/get data/state_list.dart';
import '../../../widget/Loading.dart';

class Coachsearchscreen extends StatefulWidget {
  const Coachsearchscreen({super.key});

  @override
  State<Coachsearchscreen> createState() => _CoachsearchscreenState();
}

class _CoachsearchscreenState extends State<Coachsearchscreen> {


  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();

  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final CoachSearchController coachSearchController=Get.find<CoachSearchController>();
  final GetallCitiesController getallCitiesController=Get.find<GetallCitiesController>();

  int?sportid,stateid,cityid=0;

  String ?selectedValue,SelectedState,selectedCity,selectedcityid='0';




  void updateCityData(StateId) async {
    final response = await citylistController.CitylistApi(context, StateId);
    setState(() {
      print(response);
    });
  }
  String selectestateid='0';
  String Selectedsportid='0';
  @override
  void initState() {
    // updateCityData();
    getallCitiesController.GetallCitiesApi(context);
    statelistController.StatelistApi(context);
    sportslistcontroller.sportslistapi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List sportlist = sportslistcontroller.getsportsdata.map((item) =>(item['sportName'].toString())).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = citylistController.citydata.map((item) =>(item['name'].toString())).toList();
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Find Your Coach"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Your Sport",style: profiletxtnew,),
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
                            var stateItem = sportslistcontroller.getsportsdata.firstWhere((item) => item['sportName'] == name);
                            return stateItem['id'];
                          }).toList();
                          String valuestring=selectedStateIds.join(',');
                          Selectedsportid=valuestring;
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
                        child: Text("Select Your State",style: profiletxtnew,),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:  MultiSelectDropdown.simpleList(
                            list: state,
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
                              state=newList;
                              List selectedStateIds = newList.map((name) {
                                var stateItem = statelistController.statedata.firstWhere((item) => item['name'] == name);
                                return stateItem['id'];
                              }).toList();
                              String valuestring=selectedStateIds.join(',');
                              selectestateid=valuestring;
                              citylistController.CitylistApi(context,selectestateid);
                              updateCityData(selectestateid);
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
                        child: Text("City",style: profiletxtnew,),
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
                                var cityItem = getallCitiesController.getcitiesdata.firstWhere((item) => item['name'] == name,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )),
                        onPressed: ()async{
                          showloadingdialog(context);
                          await coachSearchController.CoachSearchApi(context,Selectedsportid,selectestateid,selectedcityid);
                          Navigator.pop(context);
                          List<Map<String, dynamic>> searchdata = coachSearchController.coachsearchdata.cast<Map<String, dynamic>>();
                          Get.to( CoachListscreen(data:searchdata));
                        },child: Text("Search",style: searchbtntxt,),),
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