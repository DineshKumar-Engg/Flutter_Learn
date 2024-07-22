import 'package:animate_do/animate_do.dart';
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
import 'Club Registration Controller.dart';

class Clubsscreen extends StatefulWidget {
  const Clubsscreen({super.key});

  @override
  State<Clubsscreen> createState() => _ClubsscreenState();
}

class _ClubsscreenState extends State<Clubsscreen> {

  final MultiSelectController _controller = MultiSelectController();
  final MultiSelectController _controller1 = MultiSelectController();
  final MultiSelectController _controller2 = MultiSelectController();
  List<ValueItem> _options = [];
  List<ValueItem> _options1 = [];
  List<ValueItem> _options2 = [];

  final TextEditingController organizationcontroller=TextEditingController();
  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController phonecontroller=TextEditingController();
  final TextEditingController primarycontroller=TextEditingController();
  final TextEditingController aboutclubcontroller=TextEditingController();
  final TextEditingController leaguenamecontroller=TextEditingController();
  // final TextEditingController flightcontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();

  bool _isLoading = false;
  final List<String> agelist = ['18-21','21-29','29-35','35-42','42-50'];
  final List<String> genderlist=['male','female','others'];
  final List<String> gamelist=['FootBall','BasketBall','VolleyBall'];
  String ?selectedage,selectedgender;
  String ?selectedgame,Selectedsport;
  final ClubRegisrationController clubRegisrationController=Get.find<ClubRegisrationController>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  String?selectedValue,Selectedstate,SelectedCity,selectestateid,selectedcitylabel,selectedcityid;

  int page=1;
  int ?sportid;

  void updateCityData() async {
    final response = await citylistController.CitylistApi(context, selectestateid);
    setState(() {
      print(response);
    });
  }
  @override
  void initState() {
    updateCityData();
    statelistController.StatelistApi(context);
    sportslistcontroller.sportslistapi(context);
    super.initState();
  }

  bool terms=true;
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
                padding: const EdgeInsets.symmetric(vertical:40.0,horizontal: 8.0),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Clubs Registration",style: requesttxtbold,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Please register your details",style: requesttxt,),
                      ),
                    ],
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
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FadeInRight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Organisation Name",style:textfieldtxt,),
                ),
              ),
              commontextfield("Enter your organization name",organizationcontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contact First Name",style:textfieldtxt,),
              ),
              commontextfield("Enter your first name",firstnamecontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contact Last Name",style:textfieldtxt,),
              ),
              commontextfield("Enter your last name",lastnamecontroller,TextInputType.text),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contact Phone",style:textfieldtxt,),
              ),
              commontextfield("Enter your contact phone",phonecontroller,TextInputType.number),
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
                padding: const EdgeInsets.only(bottom:20.0,top: 20.0,left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: (){
                        if(organizationcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Organization Name", Icons.info, Colors.red);
                        }
                        else if(firstnamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your First Name", Icons.info, Colors.red);
                        }
                        else if(lastnamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Last Name", Icons.info, Colors.red);
                        }
                        else if(phonecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your Mobile Number", Icons.info, Colors.red);
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
      ),
    );
  }
  Widget step2(){
    _options2 = sportslistcontroller.getsportsdata.map((item) => ValueItem(label: item['sportName'], value: item['id'])).toList();    return Padding(
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
                  borderColor: Colors.black.withOpacity(0.10000000149011612),
                  borderWidth: 1.5,
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
                child: Text("Club Email ID",style:textfieldtxt,),
              ),
              commontextfield("Enter your Email ID",emailcontroller,TextInputType.emailAddress),

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
                    controller: _controller2,
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
                    options: _options2,
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
                padding: const EdgeInsets.all(8.0),
                child: Text("About Club",style:textfieldtxt,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller:aboutclubcontroller,
                  maxLength: 1000,
                  maxLines: 2,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color:Color(0XFFD9D9D9) )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color:Color(0XFFD9D9D9) )
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("League Name",style:textfieldtxt,),
                ),
              ),
              commontextfield("Enter your league name",leaguenamecontroller,TextInputType.text),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Text("I agree the",style: signuptxt,),
                    Padding(
                      padding:  const EdgeInsets.only(left:0.0),
                      child: TextButton(onPressed: (){
                        Get.to( const Termscreen());
                      }, child: Text("Terms & Conditions",style: termstxt)),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom:20.0,top: 20.0,left: 8.0,right: 8.0),
                child: SizedBox(
                  height:displayheight(context)*0.06,
                  child:_isLoading?const Center(child: CircularProgressIndicator()): ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: ()async{
                        if(SelectedCity==null){
                          StackDialog.show("Required Field is Empty", "Select City You Coach", Icons.info, Colors.red);
                        }
                       else if(emailcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter EmailID", Icons.info, Colors.red);
                        }
                        else if(!EmailValidator.validate(emailcontroller.text)){
                          StackDialog.show("Email Not Valid", "Enter Valid Email Id", Icons.info, Colors.red);
                        }
                        else if(Selectedsport==null){
                          StackDialog.show("Required Field is Empty", "Select Your Sport", Icons.info, Colors.red);
                        }
                        else if(aboutclubcontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter About Your Club", Icons.info, Colors.red);
                        }
                        else if(leaguenamecontroller.text.isEmpty){
                          StackDialog.show("Required Field is Empty", "Enter Your League Name", Icons.info, Colors.red);
                        }
                        else if(terms==false){
                          StackDialog.show("Required Field is Empty", "Enter Your Mobile Number", Icons.info, Colors.red);
                        }
                        else{
                          showloadingdialog(context);
                          await clubRegisrationController.ClubregistrationApi(context,organizationcontroller.text,firstnamecontroller.text,lastnamecontroller.text,
                              phonecontroller.text,selectedgame.toString(),selectestateid.toString(),
                              leaguenamecontroller.text,Selectedsport,emailcontroller.text
                              ,aboutclubcontroller.text,selectedcityid.toString());
                             Navigator.pop(context);

                        }

                      }, child: Center(child: Text("Next",style: btntxtwhite,),)),
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
}
