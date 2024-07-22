import 'package:animate_do/animate_do.dart';
import 'package:connect_athelete/Screens/Terms%20and%20Conditions/Parent%20Contest.dart';
import 'package:connect_athelete/widget/Loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Services/get data/City_list.dart';
import '../../../Services/get data/List Sports.dart';
import '../../../Services/get data/state_list.dart';
import '../../../widget/Loader.dart';
import '../../../widget/Snackbar.dart';
import '../../../widget/commonTextfield.dart';
import '../../Terms and Conditions/Terms screen.dart';
import 'Athlete Registration Controller.dart';
import 'Sucessscreen.dart';

class Atheletescreen extends StatefulWidget {
  const Atheletescreen({super.key});

  @override
  State<Atheletescreen> createState() => _AtheletescreenState();
}

class _AtheletescreenState extends State<Atheletescreen> {

  final MultiSelectController _controller = MultiSelectController();
  List<ValueItem> _options = [];


  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController currentschoolcontroller=TextEditingController();
  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController parentfirstcontroller=TextEditingController();
  final TextEditingController parentlastcontroller=TextEditingController();
  final TextEditingController parentemailcontroller=TextEditingController();
  final TextEditingController parentphoneecontroller=TextEditingController();
  final TextEditingController gradecontroller=TextEditingController();

  final AthleteRegistrationApi athleteapicontroller=Get.find<AthleteRegistrationApi>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();

  int ?stateid,cityid;
  bool _isLoading = false;
  String ?selectedValue,SelectedState,Selectedsport;
  String?selectedcity;
  final List<String> agelist = ['07','08','09','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Others'];
  String ?selectedage,selectedgender,selectedbill;
  int?page=1;
  int?sportsid;
  bool terms=true;
  bool parent=true;

  void updateCityData() async {
    final response = await citylistController.CitylistApi(context, stateid);
    setState(() {
      print(response);
    });
  }
  @override
  void initState(){
    updateCityData();
    sportslistcontroller.sportslistapi(context);
    statelistController.StatelistApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primary,
      body:  Padding(
        padding: const EdgeInsets.only(top:5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:15.0,top: 55.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: page==3||page==2?newyellow:primary,
                      child: Center(
                        child: page==3?
                        IconButton(onPressed: (){
                          step3button();
                        },icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),):page==2?
                        IconButton(onPressed: (){
                          step2button();
                        },icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),):
                        Container(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.only(left:40.0),
                      child: Image.asset("assets/logo/logowhite.png",height: displayheight(context)*0.15,color: newyellow,),
                    )),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom:40.0),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Athlete Registration",style: requesttxtbold,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Please register your details",style: requesttxt,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                    )
                ),
                child: page==1?
                step1():
                page==2?
                step2():
                step3(),

              )
            ],
          ),
        ),
      ),
    );
  }
  Widget step1(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Athlete First name",style:textfieldtxt,),
              ),
              commontextfield("Enter your first name",firstnamecontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Athlete Last name",style:textfieldtxt,),
              ),
              commontextfield("Enter your last name",lastnamecontroller,TextInputType.text),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Current School",style:textfieldtxt,),
              ),
              commontextfield("Enter your school name",currentschoolcontroller,TextInputType.text),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Age",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Select Age",
                      hintStyle: textfieldhint,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    value: selectedage,
                    onChanged: (newValue) {
                      setState(() {
                        selectedage = newValue;
                      });
                    },
                    items: agelist.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item,style: textfieldtxt,),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Gender",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Select Gender",
                      hintStyle: textfieldhint,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Current Grade",style:textfieldtxt,),
              ),
              commontextfield("Enter your grade",gradecontroller,TextInputType.number),
              Padding(
                padding: const EdgeInsets.only(bottom:15.0,top: 15.0,left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: (){
                        if(firstnamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your First Name", Icons.info, Colors.red);
                        }
                        else if(lastnamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Last Name", Icons.info, Colors.red);
                        }
                        else if(currentschoolcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Current School", Icons.info, Colors.red);
                        }
                        else if(selectedage==null){
                          StackDialog.show("Required Field is Empty", "Select Your Age", Icons.info, Colors.red);
                        }
                        else if(selectedage==null){
                          StackDialog.show("Required Field is Empty", "Select Your Gender", Icons.info, Colors.red);
                        }

                        else{
                          setState(() {
                            page=2;
                          });
                        }
                      }, child: Center(child: Text("Next",style: btntxtwhite,),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget step2(){
    _options = sportslistcontroller.getsportsdata.map((item) => ValueItem(label: item['sportName'], value: item['id'])).toList();
    return Padding(
      padding:  const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FadeInRight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  const EdgeInsets.only(top: 15.0),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Athlete Residential State",style:textfieldtxt,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: DropdownButtonFormField(
                  menuMaxHeight: displayheight(context)*0.60,
                  decoration: InputDecoration(
                    hintText: "Select State",
                    hintStyle: textfieldhint,
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
                      child: Text(item['name'],style: textfieldtxt,),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Athlete Residential City",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText:citylistController.citydata.isEmpty?"No City Found":"Select City",
                    hintStyle: textfieldhint,
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
                      child: Text(item['name'],style: textfieldtxt,),
                      onTap: () => setState(() {
                        selectedcity = item['name'];
                        cityid = item['id'];
                      }),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Parent/Guardian First Name",style:textfieldtxt,),
              ),
              commontextfield("Enter your parent/Guardian first name",parentfirstcontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Parent/Guardian Last Name",style:textfieldtxt,),
              ),
              commontextfield("Enter your parent/Guardian last name",parentlastcontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sport of Interest",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MultiSelectDropDown(
                    selectedOptionTextColor: primary,
                    borderColor: Colors.black.withOpacity(0.10000000149011612) ,
                    controller: _controller,
                    borderWidth: 1.5,
                    onOptionSelected: (options) {
                      List<String> selectedLabels = options.map((option) => option.label).toList();
                      String labelsString = selectedLabels.join(', ');
                      Selectedsport=labelsString;
                      print(labelsString);
                      List selectedValues = options.map((option) => option.value).toList();
                      String valuestring=selectedValues.join(',');
                      Selectedsport=valuestring;
                      print(valuestring);
                    },
                    options: _options,
                    disabledOptions: const [
                    ],
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    // dropdownHeight: 400,
                    optionTextStyle: inputtxt,
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:15.0,top: 15.0,left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: (){
                        if(SelectedState==null){
                          StackDialog.show("Required Field is Empty", "Select Your State", Icons.info, Colors.red);
                        }
                        else if(selectedcity==null){
                          StackDialog.show("Required Field is Empty", "Select Your City", Icons.info, Colors.red);
                        }
                        else if(parentfirstcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Parents First Name", Icons.info, Colors.red);
                        }
                        else if(parentlastcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Parents Last Name", Icons.info, Colors.red);
                        }
                        else if(Selectedsport==null){
                          StackDialog.show("Required Field is Empty", "Select Your Game", Icons.info, Colors.red);
                        }
                        else{
                          setState(() {
                            page=3;
                          });
                        }
                      }, child: Center(child: Text("Next",style: btntxtwhite,),)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget step3(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Parent Email",style:textfieldtxt,),
                  ),
                  commontextfield("Enter your parent mail",parentemailcontroller,TextInputType.emailAddress),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Parent Phone",style:textfieldtxt,),
                  ),
                  commontextfield("Enter your parent phone",parentphoneecontroller,TextInputType.number),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: terms,
                            activeColor: primary,
                            onChanged: (value){
                              setState(() {
                                terms=value!;
                              });
                            }),
                        Text("I agree to the",style: signuptxt,),
                        Padding(
                          padding: const EdgeInsets.only(left:0.0),
                          child: TextButton(onPressed: (){
                            Get.to(const Termscreen());
                          }, child: Text("terms and conditions",style: termstxt,)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: parent,
                            activeColor: primary,
                            onChanged: (value){
                              setState(() {
                                parent=value!;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left:0.0),
                          child: TextButton(onPressed: (){
                            Get.to(const Parent_Contest_screen());
                          }, child: Text("Parent Consent ",style: termstxt,)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: displayheight(context)*0.20,
              ),

              Padding(
                padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child: _isLoading?const Center(child: CircularProgressIndicator()):ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: ()async{
                        if(parentphoneecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Mobile Number", Icons.info, Colors.red);
                        }
                        else if(parentemailcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Email ID", Icons.info, Colors.red);
                        }
                        else if(!EmailValidator.validate(parentemailcontroller.text)){
                          StackDialog.show("Email Not Valid", "Enter Valid Email Id", Icons.info, Colors.red);
                        }
                        else if(terms==false){
                          StackDialog.show("Please Accept", "Terms & Conditions", Icons.info, Colors.red);
                        }
                        else if(parent==false){
                          StackDialog.show("Please Accept", "Parent Consent", Icons.info, Colors.red);
                        }
                        else if(!EmailValidator.validate(parentemailcontroller.text)){
                          StackDialog.show("Email Not Valid", "Enter Valid Email Id", Icons.info, Colors.red);
                        }
                        else{
                              showloadingdialog(context);
                              await athleteapicontroller.athleteregistrationapi(context,firstnamecontroller.text,lastnamecontroller.text,selectedage.toString(),
                              selectedgender.toString(),currentschoolcontroller.text,cityid,stateid,
                              parentfirstcontroller.text,parentlastcontroller.text,parentemailcontroller.text,parentphoneecontroller.text,
                              selectedValue.toString(),Selectedsport,gradecontroller.text);
                              Navigator.pop(context);
                        }
                      }, child: Center(child: Text("Submit",style: btntxtwhite,),)),
                ),
              ),
              SizedBox(
                height: displayheight(context)*0.05,
              )


            ],
          ),
        ),
      ),
    );
  }

  void step2button() {
    setState(() {
      page=1;
    });
  }
  void step3button() {
    setState(() {
      page=2;
    });
  }


}
