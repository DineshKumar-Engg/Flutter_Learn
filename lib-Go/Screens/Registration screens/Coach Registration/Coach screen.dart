import 'package:animate_do/animate_do.dart';
import 'package:connect_athelete/Services/get%20data/City_list.dart';
import 'package:connect_athelete/Services/get%20data/state_list.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Services/get data/List Sports.dart';
import '../../../widget/Loader.dart';
import '../../../widget/Snackbar.dart';
import '../../../widget/commonTextfield.dart';
import '../../Terms and Conditions/Terms screen.dart';
import 'Coach Registration Controller.dart';


class Coachscreen extends StatefulWidget {
  const Coachscreen({super.key});

  @override
  State<Coachscreen> createState() => _CoachscreenState();
}

class _CoachscreenState extends State<Coachscreen> with SingleTickerProviderStateMixin {

  final MultiSelectController _controller = MultiSelectController();
  final MultiSelectController _controller1 = MultiSelectController();
  List<ValueItem> _options = [];
  List<ValueItem> _options1 = [];

  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController primarysportcontroller=TextEditingController();
  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController phonecontroller=TextEditingController();
  final TextEditingController biocontroller=TextEditingController();
  final TextEditingController websitelinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController xprofilecontroller=TextEditingController();
  final TextEditingController youtubelinkcontroller=TextEditingController();
  int page=1;
  bool terms=true;
  final CoachRegistrationApi coachRegistrationApicontroller=Get.find<CoachRegistrationApi>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  int ?sportsid;
  String?selectedValue,Selectedstate,SelectedCity,selectestateid,selectedcitylabel,selectedcityid;
  bool _isLoading = false;

  Future updateCityData() async {
    final response = await citylistController.CitylistApi(context,selectestateid);
    setState(() {
      print(response);
    });
  }
  @override
  void initState() {
    statelistController.StatelistApi(context);
    sportslistcontroller.sportslistapi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primary,
      body: Padding(
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
                      backgroundColor: page==2?newyellow:primary,
                      child: Center(
                        child: page==2?IconButton(onPressed: (){
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
                padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Coach Registration",style: requesttxtbold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Please register your details",style: requesttxt,),
                    ),
                  ],
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
                  step2()
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget step1(){
    _options = statelistController.statedata.map((item) => ValueItem(label: item['name'], value: item['id'])).toList();
    _options1 = citylistController.citydata.map((item) => ValueItem(label: item['name'], value: item['id'])).toList();
    return Padding(
      padding:const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coach first name",style:textfieldtxt,),
              ),
            ),
            commontextfield("Enter your first name",firstnamecontroller,TextInputType.text),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Coach last name",style:textfieldtxt,),
            ),
            commontextfield("Enter your last name",lastnamecontroller,TextInputType.text),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coach Email",style:textfieldtxt,),
              ),
            ),
            commontextfield("Enter your mail",emailcontroller,TextInputType.emailAddress),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Primary sports",style:textfieldtxt,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 60,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintStyle: textfieldhint,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  value: sportsid,
                  items: sportslistcontroller.getsportsdata.map((item) {
                    return DropdownMenuItem(
                      value: item['id'],
                      child: Text(item['sportName'],style: textfieldtxt,),
                      onTap: (){
                        setState(() {
                          selectedValue=item['sportName'];
                          sportsid=item['id'];
                        });
                      },
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedValue=value as String;
                    });
                  },
                  dropdownColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("State You Coach",style:textfieldtxt,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelectDropDown(
                selectedOptionTextColor: primary,
                borderColor: Colors.black.withOpacity(0.10000000149011612) ,
                controller: _controller,
                borderWidth: 1.5,
                onOptionSelected: (options) {
                  List<String> selectedLabels = options.map((option) => option.label).toList();
                  String labelsString = selectedLabels.join(', ');
                  Selectedstate=labelsString;
                  print(labelsString);
                  List selectedValues = options.map((option) => option.value).toList();
                  String valuestring=selectedValues.join(',');
                  selectestateid=valuestring;
                  print(valuestring);
                  Future.value([updateCityData()]);
                },
                options: _options,
                disabledOptions: const [

                ],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 400,
                optionTextStyle: inputtxt,
                selectedOptionIcon: const Icon(Icons.check_circle),
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
                      if(firstnamecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Your First Name", Icons.info, Colors.red);
                      }
                      else if(lastnamecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Your Last Name", Icons.info, Colors.red);
                      }
                      else if(emailcontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Your Email ID", Icons.info, Colors.red);
                      }
                      else if(!EmailValidator.validate(emailcontroller.text)){
                        StackDialog.show("Email Not Valid", "Enter Valid Email Id", Icons.info, Colors.red);
                      }
                      else if(selectedValue==null){
                        StackDialog.show("Required Field is Empty", "Select Your Sport", Icons.info, Colors.red);
                      }
                      else if(Selectedstate==null){
                        StackDialog.show("Required Field is Empty", "Select State You Coach", Icons.info, Colors.red);
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
    );
  }

  Widget step2(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FadeInRight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("City You Coach",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MultiSelectDropDown(
                  borderColor: Colors.black.withOpacity(0.10000000149011612) ,
                  controller: _controller1,
                  onOptionSelected: (options) {
                    List<String> selectedLabels = options.map((option) => option.label).toList();
                    String labelsString = selectedLabels.join(', ');
                    SelectedCity=labelsString;
                    print(labelsString);
                    List selectedValues = options.map((option) => option.value).toList();
                    String valuestring=selectedValues.join(',');
                    selectedcityid=valuestring;
                    print(valuestring);
                  },
                  options: _options1,
                  disabledOptions: const [
                  ],
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 400,
                  optionTextStyle: inputtxt,
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coach Phone number",style:textfieldtxt,),
              ),
              commontextfield("Enter your number",phonecontroller,TextInputType.number),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Coach Bio",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: inputtxt,
                  controller: biocontroller,
                  maxLines: 2,
                  maxLength: 1000,
                  cursorColor: greytxtcolor,
                  decoration: InputDecoration(
                    hintText: "Enter bio",
                    hintStyle: textfieldhint,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Website Link",style:textfieldtxt,),
              ),
              commontextfield("",websitelinkcontroller,TextInputType.text),
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
                padding: const EdgeInsets.only(bottom:15.0,top: 15.0,left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child: _isLoading?const Center(child: CircularProgressIndicator()):ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: ()async{
                        if(SelectedCity==null){
                          StackDialog.show("Required Field is Empty", "Select City You Coach", Icons.info, Colors.red);
                        }
                        else if(phonecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Phone Number", Icons.info, Colors.red);
                        }
                        else if(biocontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Coach Bio", Icons.info, Colors.red);
                        }
                        else if(terms==false){
                          StackDialog.show("Please Accept", "Terms & Conditions", Icons.info, Colors.red);
                        }
                        else{
                          showLoadingDialog(context);
                          await coachRegistrationApicontroller.coachregistrtionapi(context,firstnamecontroller.text,lastnamecontroller.text,
                              emailcontroller.text, selectedcityid.toString(),selectestateid.toString(),sportsid,biocontroller.
                              text,phonecontroller.text,websitelinkcontroller.text);
                          Navigator.pop(context);

                        }

                      }, child: Center(child: Text("Submit",style: btntxtwhite,),)),
                ),
              ),
          
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

}
