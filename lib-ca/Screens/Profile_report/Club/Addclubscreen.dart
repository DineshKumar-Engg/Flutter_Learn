import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/AddclubController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/common_textfield.dart';
import '../../../Widget/snackbar.dart';
import '../../../service/CitylistController.dart';
import '../../../service/GetStatelistController.dart';
import '../../../service/GetallspecialityController.dart';
import '../../../service/GetcitylistController.dart';
import '../../Sport/Getall_sport_Controller.dart';

class Addclubscreen extends StatefulWidget {
  const Addclubscreen({super.key});

  @override
  State<Addclubscreen> createState() => _AddclubscreenState();
}

class _AddclubscreenState extends State<Addclubscreen> {

  final ClubRegisrationController clubRegisrationController=Get.find<ClubRegisrationController>();
  final MultiSelectController _controller2 = MultiSelectController();

  final StatelistController statelistController=Get.find<StatelistController>();
  final GetallCitylistController citylistController=Get.find<GetallCitylistController>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();

  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController mobilecontroller=TextEditingController();
  final TextEditingController xlinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController aboutcontroller=TextEditingController();
  final TextEditingController websitecontroller=TextEditingController();
  final TextEditingController organizationcontroller=TextEditingController();
  final TextEditingController leaguecontroller=TextEditingController();

  int?stateid,cityid;
  String?selectedage,selectedgender,selectestateid,selectedcityid,sportsidsvalue,Coachspeciality,sendagewecoach;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Male and Female'];


  void updatedspecialitydata()async{
    final responce=await specialitylistController.SpecialityApi(context, sportsidsvalue);
  }
  @override
  void initState() {
    statelistController.StatelistApi(context);
    getall_sport_controller.GetSportApi(context);
    // updateCityData();
    updatedspecialitydata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var sportdatalist=getall_sport_controller.getsportdata.map((element) => element['sportName']).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = citylistController.getcitylistdata.map((item) =>(item['name'].toString())).toList();
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Add Club & Academie"),
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
                  child: Center(child: Text("Club & Academic Details",style: listheadingtxt,)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Organization Name",style: inputtxt,),
                  ),
                  common_textfield(organizationcontroller, "", TextInputType.text)
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Email ID",style: inputtxt,),
                  ),
                  common_textfield(emailcontroller, "", TextInputType.text)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Mobile Number",style: inputtxt,),
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
                    child: Text("Sports of Interest",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:MultiSelectDropdown.simpleList(
                        list: sportdatalist,
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(10)
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
                    child: Text("State You Training",style: inputtxt,),
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
                           borderRadius: BorderRadius.circular(10)
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
                          print(selectestateid);

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
                    child: Text("City You Training",style: inputtxt,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:MultiSelectDropdown.simpleList(
                        list: city,
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        whenEmpty: "",
                        duration:const Duration(microseconds: 0),
                        textStyle: inputtxt,
                        listTextStyle: inputtxt,
                        checkboxFillColor:primary,
                        initiallySelected:[],
                        onChange: (newList) {
                          List selectedCityIds = newList.map((name) {
                            var cityItem = citylistController.getcitylistdata.firstWhere((item) => item['name'] == name,
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text("About Club & Academic",style: listheadingtxt,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ages We Coaching",style: inputtxt,),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 8.0),
                      child: MultiSelectDropDown(
                        controller: _controller2,
                        onOptionSelected: (options) {
                          List<String> selectedLabels = options.map((option) => option.label).toList();
                          String labelsString = selectedLabels.join(', ');
                          sendagewecoach=labelsString;
                          print(labelsString);
                        },
                        options: const <ValueItem>[
                          ValueItem(label: '09', value: '1'),
                          ValueItem(label: '10', value: '2'),
                          ValueItem(label: '11', value: '3'),
                          ValueItem(label: '12', value: '4'),
                          ValueItem(label: '13', value: '5'),
                          ValueItem(label: '14', value: '6'),
                          ValueItem(label: '15', value: '7'),
                          ValueItem(label: '16', value: '8'),
                          ValueItem(label: '17', value: '9'),
                          ValueItem(label: '18+', value: '10'),
                        ],
                        disabledOptions: const [

                        ],
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 300,
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender We Coaching",style: inputtxt,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: DropdownButtonFormField(
                        decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                        ),
                        value: selectedgender,
                        onChanged: (newValue) {
                          setState(() {
                            selectedgender = newValue;
                          });
                        },
                        items: genderlist.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item,style: textfieldtxt,),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("About Organization",style: inputtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: inputtxt,
                  maxLines: 3,
                  maxLength: 500,
                  cursorColor: Colors.black,
                  controller: aboutcontroller,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("League Information",style: inputtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: inputtxt,
                  maxLines: 3,
                  maxLength: 500,
                  cursorColor: Colors.black,
                  controller: leaguecontroller,
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
              Column(
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
                      child: Center(child: Text("Social Media Links",style: listheadingtxt,)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Website Link",style: inputtxt,),
                      ),
                      common_textfield(websitecontroller, "", TextInputType.text)
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor:secondary,shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                        onPressed: (){
                          if(organizationcontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter Organization Name", Icons.info, Colors.red);
                          }
                          else if(firstnamecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter First Name", Icons.info, Colors.red);
                          }
                          else if(lastnamecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter Last Name", Icons.info, Colors.red);
                          }
                          else if(emailcontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter Email ID", Icons.info, Colors.red);
                          }
                          else if(mobilecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter Mobile Number", Icons.info, Colors.red);
                          }
                          else if(sportsidsvalue==null){
                            StackDialog.show("Required Field is Empty", "Select Sport of Interest", Icons.info, Colors.red);
                          }
                          else if(selectestateid==null){
                            StackDialog.show("Required Field is Empty", "Select State", Icons.info, Colors.red);
                          }
                          else if(selectedcityid==null){
                            StackDialog.show("Required Field is Empty", "Select City", Icons.info, Colors.red);
                          }
                          else if(selectedage==null){
                            StackDialog.show("Required Field is Empty", "Select Ages you Coach", Icons.info, Colors.red);
                          }
                          else if(selectedgender==null){
                            StackDialog.show("Required Field is Empty", "Select Gender you Coach", Icons.info, Colors.red);
                          }
                          else if(aboutcontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter About Organization", Icons.info, Colors.red);
                          }
                          else if(leaguecontroller.text.isEmpty){
                            StackDialog.show("Required Field is Empty", "Enter League Information", Icons.info, Colors.red);
                          }
                          else{
                            clubRegisrationController.ClubregistrationApi(context, organizationcontroller.text, firstnamecontroller.text,
                                lastnamecontroller.text, mobilecontroller.text, selectestateid, leaguecontroller.text, sportsidsvalue,
                                emailcontroller.text, aboutcontroller.text, selectedcityid, sendagewecoach, selectedgender,
                                xlinkcontroller.text, iglinkcontroller.text, websitecontroller.text);
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
