import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AddathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:connect_athlete_admin/service/GetStatelistController.dart';
import 'package:connect_athlete_admin/service/GetallspecialityController.dart';
import 'package:connect_athlete_admin/service/GetcitylistController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import '../../../Common/Common_textstyle.dart';

class add_athlete_screen extends StatefulWidget {
  const add_athlete_screen({super.key});

  @override
  State<add_athlete_screen> createState() => _add_athlete_screenState();
}

class _add_athlete_screenState extends State<add_athlete_screen> {

  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final AthleteRegistrationApi athleteRegistrationApi=Get.find<AthleteRegistrationApi>();
  final GetallAthleteController getallAthleteController=Get.find<GetallAthleteController>();


  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController mobilecontroller=TextEditingController();
  final TextEditingController currentacademycontroller=TextEditingController();
  final TextEditingController gradecontroller=TextEditingController();
  final TextEditingController xlinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController biocontroller=TextEditingController();
  final TextEditingController achievementscontroller=TextEditingController();
  final TextEditingController parentfirstnamecontroller=TextEditingController();
  final TextEditingController parentlastnamecontroller=TextEditingController();
  final TextEditingController currentschoolcontroller=TextEditingController();



  int?stateid,cityid;
  String?selectedage,selectedgender,SelectedState,selectedcity,sportsidsvalue,Coachspeciality;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Others'];

  void updateCityData() async {
    final response = await citylistController.CitylistApi(context, stateid);
    setState(() {
      print(response);
    });
  }

  void updatedspecialitydata()async{
    final responce=await specialitylistController.SpecialityApi(context, sportsidsvalue);
  }
  @override
  void initState() {
    statelistController.StatelistApi(context);
    getall_sport_controller.GetSportApi(context);
    updateCityData();
    updatedspecialitydata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var sportdatalist=getall_sport_controller.getsportdata.map((element) => element['sportName']).toList();
    List speciality = specialitylistController.specialitydata.map((item) =>(item['specialityTitle'].toString())).toList();

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Athlete"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text("Athlete Details",style: listheadingtxt,)),
                ),
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
                        child: Text("First Name",style: inputtxt,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                            height: displayheight(context)*0.07,
                            width: displaywidth(context)*0.45,
                            child: TextFormField(
                              style: inputtxt,
                              cursorColor: Colors.black,
                              controller: firstnamecontroller,
                              keyboardType: TextInputType.text,
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
                            )),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Last Name",style: inputtxt,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                            height: displayheight(context)*0.07,
                            width: displaywidth(context)*0.45,
                            child: TextFormField(
                              style: inputtxt,
                              cursorColor: Colors.black,
                              controller: lastnamecontroller,
                              keyboardType: TextInputType.text,
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
                            )),
                      )
                    ],
                  )
                ],
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
                        child: Text("Gender",style: inputtxt,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SizedBox(
                          height: displayheight(context)*0.07,
                          width: displaywidth(context)*0.45,
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
                            value: selectedgender,
                            items: genderlist.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item,style: inputtxt,),
                                onTap: (){
                                  setState(() {
                                    selectedgender=item;
                                  });
                                },
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() {
                                selectedgender = newValue as String;
                              });
                            },

                          ),
                        ),
                      )

                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Age",style: inputtxt,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SizedBox(
                          height: displayheight(context)*0.07,
                          width: displaywidth(context)*0.45,
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
                            value: selectedage,
                            items: agelist.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item,style: inputtxt,),
                                onTap: (){
                                  setState(() {
                                    selectedage=item;
                                  });
                                },
                              );
                            }).toList(),
                            dropdownColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() {
                                selectedage = newValue as String;
                              });
                            },

                          ),
                        ),
                      )

                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Athlete Residential State  ",style: inputtxt,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4.0),
                      child: DropdownButtonFormField(
                        style: inputtxt,
                        menuMaxHeight: displayheight(context)*0.60,
                        decoration: InputDecoration(
                          hintText: "Select State",
                          hintStyle: textfieldtxt,
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
                                Future.value([updateCityData()]);
                              });
                            },
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Athlete Residential City  ",style: inputtxt,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4.0),
                      child: DropdownButtonFormField(
                        style: inputtxt,
                        decoration: InputDecoration(
                          hintText: "Select City",
                          hintStyle: textfieldtxt,
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
                        value: selectedcity,
                        onChanged: (newValue) {
                          setState(() {
                            selectedcity = newValue as String?;
                          });
                        },
                        items: citylistController.citydata.map((item) {
                          return DropdownMenuItem(
                            value: item['name'],
                            child: Text(item['name'],style: inputtxt,),
                            onTap: () => setState(() {
                              selectedcity = item['name'];
                              cityid = item['id'];
                            }),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Current School",style: inputtxt,),
                  ),
                  common_textfield(currentschoolcontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Current Academy",style: inputtxt,),
                  ),
                  common_textfield(currentacademycontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Grade",style: inputtxt,),
                  ),
                  common_textfield(gradecontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("X Profile Link",style: inputtxt,),
                  ),
                  common_textfield(xlinkcontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("IG Profile Link",style: inputtxt,),
                  ),
                  common_textfield(iglinkcontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Athlete Bio",style: inputtxt,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: inputtxt,
                      maxLines: 3,
                      maxLength: 500,
                      cursorColor: Colors.black,
                      controller: biocontroller,
                      keyboardType: TextInputType.text,
                      decoration:  InputDecoration(
                          hintText:"",
                          hintStyle:loginhinttxt ,
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
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text("Sport Details",style: listheadingtxt,)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Sports of Interest",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:MultiSelectDropdown.simpleList(
                        list: sportdatalist,
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        whenEmpty: "Select Your Sport",
                        duration:const Duration(microseconds: 0),
                        numberOfItemsLabelToShow: 5,
                        textStyle: inputtxt,
                        isLarge: true,
                        listTextStyle: inputtxt,
                        checkboxFillColor:primary,
                        initiallySelected:[],
                        onChange: (newList) {
                          List specialityIds = newList.map((name) {
                            var specialityItem = getall_sport_controller.getsportdata.firstWhere((item) => item['sportName'] == name);
                            return specialityItem['id'];
                          }).toList();
                          String valuestring=specialityIds.join(',');
                          sportsidsvalue=valuestring;
                          updatedspecialitydata();
                          setState(()async{
                            await specialitylistController.SpecialityApi(context, sportsidsvalue);
                          });
                          print(sportsidsvalue);
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
                    child: Text("Speciality of Interest",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:MultiSelectDropdown.simpleList(
                        list: speciality,
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        whenEmpty: "Select You Speciality",
                        duration:const Duration(microseconds: 0),
                        numberOfItemsLabelToShow: 5,
                        textStyle: inputtxt,
                        isLarge: true,
                        listTextStyle: inputtxt,
                        checkboxFillColor:primary,
                        initiallySelected:[],
                        onChange: (newList) {
                          List specialityIds = newList.map((name) {
                            var specialityItem = specialitylistController.specialitydata.firstWhere((item) => item['specialityTitle'] == name);
                            return specialityItem['id'];
                          }).toList();
                          String valuestring=specialityIds.join(',');
                          Coachspeciality=valuestring;
                          print(Coachspeciality);
                        },
                      )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Athlete Achievements",style: inputtxt,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: inputtxt,
                          maxLines: 3,
                          maxLength: 500,
                          cursorColor: Colors.black,
                          controller: achievementscontroller,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                              hintText:"",
                              hintStyle:loginhinttxt ,
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
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text("Parent Details",style: listheadingtxt,)),
                    ),
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
                            child: Text("First Name",style: inputtxt,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                                height: displayheight(context)*0.07,
                                width: displaywidth(context)*0.45,
                                child: TextFormField(
                                  style: inputtxt,
                                  cursorColor: Colors.black,
                                  controller: parentfirstnamecontroller,
                                  keyboardType: TextInputType.text,
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
                                )),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Last Name",style: inputtxt,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                                height: displayheight(context)*0.07,
                                width: displaywidth(context)*0.45,
                                child: TextFormField(
                                  style: inputtxt,
                                  cursorColor: Colors.black,
                                  controller: parentlastnamecontroller,
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                      enabledBorder:  OutlineInputBorder(
                                          borderSide: const BorderSide(color: textfieldcolor),
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      focusedBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(color: textfieldcolor),
                                          borderRadius: BorderRadius.circular(10.0)
                                      )
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Parent Contact Number",style: inputtxt,),
                      ),
                      common_textfield(mobilecontroller, "", TextInputType.number)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Parent Email ID",style: inputtxt,),
                      ),
                      common_textfield(emailcontroller, "", TextInputType.emailAddress)
                    ],
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
                          if(firstnamecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your First Name", Icons.info, Colors.red);
                          }
                          else if(lastnamecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your Last Name", Icons.info, Colors.red);
                          }
                          else if(selectedgender==null){
                            StackDialog.show("Required Field is Empty","Select Your Gender", Icons.info, Colors.red);
                          }
                          else if(selectedage==null){
                            StackDialog.show("Required Field is Empty","Select Your Age", Icons.info, Colors.red);
                          }
                          else if(SelectedState==null){
                            StackDialog.show("Required Field is Empty","Select Your State", Icons.info, Colors.red);
                          }
                          else if(selectedcity==null){
                            StackDialog.show("Required Field is Empty","Select Your City", Icons.info, Colors.red);
                          }
                          else if(currentschoolcontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your Current School", Icons.info, Colors.red);
                          }
                          else if(currentacademycontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your Current Academic", Icons.info, Colors.red);
                          }
                          else if(sportsidsvalue==null){
                            StackDialog.show("Required Field is Empty","Select Sport of Interest", Icons.info, Colors.red);
                          }
                          else if(mobilecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your Mobile Number", Icons.info, Colors.red);
                          }
                          else if(emailcontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty","Enter your Email ID", Icons.info, Colors.red);
                          }
                          else{
                            athleteRegistrationApi.athleteregistrationapi(context, firstnamecontroller.text, lastnamecontroller.text, selectedage, selectedgender, currentschoolcontroller.text,
                                cityid, stateid, parentfirstnamecontroller.text, parentlastnamecontroller.text, emailcontroller.text,
                                mobilecontroller.text, sportsidsvalue, gradecontroller.text,xlinkcontroller.text,iglinkcontroller.text
                                ,biocontroller.text,achievementscontroller.text,currentacademycontroller.text);
                            getallAthleteController.GetallathleteApi(context);
                          }
                        },child: Center(child: Text("Submit",style: btntxtwhite,),),
                      ) ,
                    ),
                  )                ],
              ),

            ],
          ),
        ),
      ),

    );
  }
}
