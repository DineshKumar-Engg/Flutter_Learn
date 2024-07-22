import 'package:connect_athelete/Screens/Search%20List/Athlete/Athlete%20List.dart';
import 'package:connect_athelete/Services/Search%20service/athlete_search_api.dart';
import 'package:connect_athelete/Services/get%20data/City_list.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:connect_athelete/Services/get%20data/getall_cities.dart';
import 'package:connect_athelete/Services/get%20data/state_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';
import '../../../widget/Loading.dart';


class Athletesearchscreen extends StatefulWidget {
  const Athletesearchscreen({super.key});

  @override
  State<Athletesearchscreen> createState() => _AthletesearchscreenState();
}

class _AthletesearchscreenState extends State<Athletesearchscreen> {

  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();

  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  // final CitylistController citylistController=Get.find<CitylistController>();
  final GetallCitiesController getallCitiesController=Get.find<GetallCitiesController>();
  final AthleteSearchController athleteSearchController=Get.find<AthleteSearchController>();

  int?sportid,stateid,cityid;
  String Selectedsportid='0';
  String selectedcityid='0';
  String selectestateid='0';
  // Future <void> updateCityData(stateid) async {
  //    await citylistController.CitylistApi(context, stateid);
  // }
  void citiesdata(){
    getallCitiesController.GetallCitiesApi(context);
  }

  @override
  void initState() {
    statelistController.StatelistApi(context);
    sportslistcontroller.sportslistapi(context);
    getallCitiesController.GetallCitiesApi(context);
    super.initState();
  }
   final List<String> agelist = ['09','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Others'];
  String ?selectedValue,SelectedState,SelectedCity;
  String selectedage='';
  String selectedgender='';



  @override
  Widget build(BuildContext context) {
    List sportlist = sportslistcontroller.getsportsdata.map((item) =>(item['sportName'].toString())).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = getallCitiesController.getcitiesdata.map((item) =>(item['name'].toString())).toList();
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Find Your Athlete"),
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
                        child: Text("Select Your City",style: profiletxtnew,),
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
                  SizedBox(
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
                              child: Text("Age",style: profiletxtnew,),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:  SizedBox(
                                  width: displaywidth(context)*0.45,
                                  child: MultiSelectDropdown.simpleList(
                                    list: agelist,
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
                                      print(selectedage);
                                      selectedage=newList.join(',');

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
                              child: Text("Gender",style: profiletxtnew,),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child:  SizedBox(
                                  width: displaywidth(context)*0.45,
                                  child: MultiSelectDropdown.simpleList(
                                    list: genderlist,
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
                                      selectedgender=newList.join(',');
                                      print(selectedgender);

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
                        style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )),
                        onPressed: ()async{
                          showloadingdialog(context);
                            await athleteSearchController.AthleteSearchApi(context, Selectedsportid, selectestateid, selectedcityid,selectedage,selectedgender);
                            Navigator.pop(context);
                             List<Map<String,dynamic>> data=athleteSearchController.athletesearchdata.cast<Map<String,dynamic>>();
                            Get.to( Athletelistscreen(data:data));
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
