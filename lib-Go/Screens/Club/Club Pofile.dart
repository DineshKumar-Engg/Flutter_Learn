import 'dart:convert';
import 'dart:io';
import 'package:connect_athelete/Services/Club%20Service/Club%20Details%20Api.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Club Service/Club Profile Edit Api.dart';
import '../../Services/get data/City_list.dart';
import '../../Services/get data/Speciality_list.dart';
import '../../Services/get data/state_list.dart';
import '../../widget/Appbar.dart';
import '../../widget/New Textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../../widget/Snackbar.dart';

class ClubProfilescreen extends StatefulWidget {
  const ClubProfilescreen({super.key});

  @override
  State<ClubProfilescreen> createState() => _ClubProfilescreenState();
}

class _ClubProfilescreenState extends State<ClubProfilescreen> {

  final MultiSelectController _controller2 = MultiSelectController();

  final List<String> genderlist=['Male','Female','Male & Female'];
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];

  String ?sportid;
  XFile?file;
  final picker=ImagePicker();
  String?base64String;
  String ?primarysport,Selectedstate,SelectedCity,selectestateid,selectedcityid,
      Coachspeciality,sendagewecoach,selectedgender,selectedage;
  int container=0;
  int profilepage=1;
  int achievementpage=1;
  int parentpage=1;
  int mediapage=1;
  bool?profilebool=true;
  bool?achievementbool=false;
  bool?parentbool=false;
  bool?mediabool=false;
  File ?SelectedImage;
  String ?service,athleteprofileimage;
  String token='';
  int?userid,imageid;
  String?filetype,sportsidsvalue;

  final TextEditingController organizationcontroller=TextEditingController();
  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController phonecontroller=TextEditingController();
  final TextEditingController primarycontroller=TextEditingController();
  final TextEditingController aboutclubcontroller=TextEditingController();
  final TextEditingController leaguenamecontroller=TextEditingController();
  final TextEditingController flightcontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController websitelinkcontroller=TextEditingController();
  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController youtubelinkcontroller=TextEditingController();
  final TextEditingController xlinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();

  Future <void> updateCityData() async {
     citylistController.CitylistApi(context, selectestateid);
    setState(() {

    });
  }

  Future<void> getimage() async {
    final _pickedimage = await picker.pickImage(source: ImageSource.gallery);
    if (_pickedimage != null) {
      setState(() {
        file = _pickedimage;
      });

      // Read the image file and compress it
      List<int> imagebytes = File(file!.path).readAsBytesSync();
      img.Image? image = img.decodeImage(imagebytes);
      List<int> compressedImageBytes = img.encodeJpg(image!, quality: 50);  // Adjust quality as needed
      base64String = base64Encode(compressedImageBytes);

      // Extracting the file name
      String filename = file!.path.split('/').last;

      athleteprofileimage!.isEmpty?uploadFile(compressedImageBytes, filename):updateFile(compressedImageBytes, filename);

      if (filename.toLowerCase().endsWith('.png')) {
        print('The selected image is in PNG format');
        filetype="png";
        print(filetype);
      } else if (filename.toLowerCase().endsWith('.jpg')) {
        print('The selected image is in JPG format');
        filetype="jpg";
        print(filetype);
      }
      else if(filename.toLowerCase().endsWith('.jpeg')){
        filetype="jpeg";
        print(filetype);
      }
      else {
        print('The selected image format is unknown');
      }
    } else {
      print("Image not Selected");
    }
  }

  Future<void> uploadFile( imagebytes, String name) async {
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var gettoken = shref.getString('token');
    token = gettoken ?? '';

    var getid = shref.getInt('userid');
    userid = (getid ?? '') as int;

    // Example data
    final fileData = {"buffer":imagebytes, "originalname":"$name"};
    final fileLocation = json.encode(fileData);

    // Print the fileLocation to console
    print("fileLocation: $fileLocation");

    final url = 'https://api.engageathlete.com/api/v1/upload-singlefiletest';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "$token"},
      body: json.encode({
        "fileLocation": "$fileLocation",
        "isActive": true,
        "description": "profile Hasan Al Haydos Qatar Japan Takumi Minamino",
        "fileType": "Profile Image",
        "ImageType":"image/$filetype",
        "isApproved": "Approved",
        "userId": userid
      }),
    );
    if (response.statusCode == 201) {
      print(fileLocation);
      print('File uploaded successfully');
      StackDialog.show("Successfully Uploaded", "Image Uploaded Successfully", Icons.verified, Colors.green);
    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }

  Future<void> updateFile( imagebytes, String name) async {
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var gettoken = shref.getString('token');
    token = gettoken ?? '';

    // Example data
    final fileData = {"buffer":imagebytes, "originalname":"$name"};
    final fileLocation = json.encode(fileData);

    // Print the fileLocation to console
    print("fileLocation: $fileLocation");

    final url = 'https://api.engageathlete.com/api/v1/updatefiletwoplatforms';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "$token"},
      body: json.encode({
        "fileLocation": "$fileLocation",
        "isActive": true,
        "description": "profile Hasan Al Haydos Qatar Japan Takumi Minamino",
        "fileType": "Profile Image",
        "ImageType":"image/$filetype",
        "isApproved": "Approved",
        "userId":userid,
        "id":imageid
      }),
    );
    if (response.statusCode == 200) {
      print(fileLocation);
      print('File Updated successfully');
      StackDialog.show("Successfully Uploaded", "Image Updated Successfully", Icons.verified, Colors.green);
      await clubProfileDetailsController.ClubProfileDetailsApi(context);

    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }

  final ClubProfileDetailsController clubProfileDetailsController=Get.find<ClubProfileDetailsController>();
  final ClubProfileEditController clubProfileEditController=Get.find<ClubProfileEditController>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();


  @override
  void initState() {
    updateCityData();
    clubProfileDetailsController.ClubProfileDetailsApi(context);
    statelistController.StatelistApi(context);
    specialitylistController.SpecialityApi(context);
    organizationcontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['academieName']??'';
    firstnamecontroller.text=clubProfileDetailsController.clunprofiledata[0]['userData']['firstName']??'';
    lastnamecontroller.text=clubProfileDetailsController.clunprofiledata[0]['userData']['lastName']??'';
    emailcontroller.text=clubProfileDetailsController.clunprofiledata[0]['userData']['email'];
    phonecontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['phone']??'';
    aboutclubcontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['bio']??'';
    leaguenamecontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['leagueName']??'';
    flightcontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['flightName']??'';
    selectedcityid=clubProfileDetailsController.clunprofiledata[0]['academieData']['city']??'';
    selectestateid=clubProfileDetailsController.clunprofiledata[0]['academieData']['state']??'';
    websitelinkcontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['instagramLink']??'';
    xlinkcontroller.text=clubProfileDetailsController.clunprofiledata[0]['academieData']['twitterLink']??'';
    sportsidsvalue=clubProfileDetailsController.clunprofiledata[0]['academieData']['sportId']??'';
    selectedage=clubProfileDetailsController.clunprofiledata[0]['academieData']['ageYouCoach']??'';
    selectedgender=clubProfileDetailsController.clunprofiledata[0]['academieData']['genderYouCoach']??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List gallerydata=clubProfileDetailsController.clunprofiledata[0]['galleryData']??[];
    var profileimage=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
    athleteprofileimage=profileimage??'';
    var profileimageid=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'id':0})['id'];
    imageid=profileimageid??'';
    return  Scaffold(
      backgroundColor: background,
      appBar:appbarwidget("Profile Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
        child: SingleChildScrollView(
          child: Obx(
            ()=> clubProfileDetailsController.clunprofiledata.isEmpty? const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: primary,
              ),
            ):Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child:  Column(
                    children: [
                      Container(
                        height: displayheight(context)*0.15,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  getimage();
                                },
                                child:  CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey,
                                  child:file==null? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage("$profileimage"))
                                      : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: SizedBox(
                                          height: 120,
                                          width: 120,
                                          child: Image.file(File(file!.path),fit: BoxFit.cover,))),
                                  // backgroundImage: AssetImage("assets/profile1.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:10.0,bottom: 10.0,left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Hi, ",style: aboutclubtxt,),
                                        Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['academieName']??''}",style: profiletxtheadsubtxt,),
                                      ],
                                    ),
                                    Text("${clubProfileDetailsController.clubsportdata[0]['sportName']??''}",style:profiletxtheadsubtxt ,),
                                    Text("${clubProfileDetailsController.clunprofiledata[0]['userData']['email']??''}",style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight:  Radius.circular(15)
                            )
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      profilebool=!profilebool!;
                                    });
                                  },
                                  child: Container(
                                    // height: displayheight(context)*0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),

                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 4.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                  child: Text("Your Profile",style: visacardtxt,),
                                                ),
                                                profilebool==true && profilepage==1?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: background
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      profilepage=2;
                                                    });
                                                  }, child: Row(children: [Text("Edit",style: editbtn,), const Icon(Icons.edit,color: primary,size: 15,)
                                                ],
                                                ),
                                                ):
                                                profilebool==true && profilepage==2?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: Colors.green
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      clubProfileEditController.ClubProfileEditApi(context,organizationcontroller.text,firstnamecontroller.text,
                                                          lastnamecontroller.text,phonecontroller.text,aboutclubcontroller.text,
                                                          leaguenamecontroller.text,flightcontroller.text,selectedcityid,
                                                          selectestateid,websitelinkcontroller.text,youtubelinkcontroller.text,
                                                          sportsidsvalue,xlinkcontroller.text,iglinkcontroller.text,selectedage,selectedgender,emailcontroller.text);
                                                    });
                                                  }, child: Row(children: [Text("Save",style: detailssubtxt,), const Icon(Icons.save,color: Colors.white,size: 15,)
                                                ],
                                                ),
                                                ):
                                                const Text("")
                                              ])
                                      )
                                  ),
                                ),
                              ),
                              profilebool==true && profilepage==1?
                              profile():
                              profilebool==true && profilepage==2?
                              profileedit():
                              Container(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      achievementbool = !achievementbool!;
                                    });
                                  },

                                  child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 4.0),
                                          child:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                  child: Text("About Club",style: visacardtxt,),
                                                ),
                                                achievementbool==true && achievementpage==1?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: background
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      achievementpage=2;
                                                    });
                                                  }, child: Row(children: [Text("Edit",style: editbtn,), const Icon(Icons.edit,color: primary,size: 15,)
                                                ],
                                                ),
                                                ):
                                                achievementbool==true && achievementpage==2?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: Colors.green
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      clubProfileEditController.ClubProfileEditApi(context,organizationcontroller.text,firstnamecontroller.text,lastnamecontroller.text,phonecontroller.text,aboutclubcontroller.text,
                                                          leaguenamecontroller.text,flightcontroller.text,selectedcityid,
                                                          selectestateid,websitelinkcontroller.text,youtubelinkcontroller.text,sportsidsvalue,
                                                          xlinkcontroller.text,iglinkcontroller.text,selectedage,selectedgender,emailcontroller.text);
                                                    });
                                                  }, child: Row(children: [Text("Save",style: detailssubtxt,), const Icon(Icons.save,color: Colors.white,size: 15,)
                                                ],
                                                ),
                                                ):
                                                const Text("")
                                              ])
                                      )
                                  ),
                                ),
                              ),
                              achievementbool==true && achievementpage==1?
                              Aboutclub() :
                              achievementbool==true && achievementpage==2?
                              Aboutclubedit():
                              Container(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      mediabool=!mediabool!;
                                    });
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                  child: Text("Social Media Links",style: visacardtxt,),
                                                ),
                                                mediabool==true && mediapage==1?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: background
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      mediapage=2;
                                                    });
                                                  }, child: Row(children: [Text("Edit",style: editbtn,), const Icon(Icons.edit,color: primary,size: 15,)
                                                ],
                                                ),
                                                ):
                                                mediabool==true && mediapage==2?
                                                TextButton(
                                                  style: TextButton.styleFrom(backgroundColor: Colors.green
                                                    // const Color(0xFFFFF4D1)
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      clubProfileEditController.ClubProfileEditApi(context,organizationcontroller.text,firstnamecontroller.text,lastnamecontroller.text,
                                                          phonecontroller.text,aboutclubcontroller.text,
                                                          leaguenamecontroller.text,flightcontroller.text,selectedcityid,
                                                          selectestateid,websitelinkcontroller.text,youtubelinkcontroller.text,sportsidsvalue,
                                                          xlinkcontroller.text,iglinkcontroller.text,selectedage,selectedgender,emailcontroller.text);
                                                    });
                                                  }, child: Row(children: [Text("Save",style: detailssubtxt,), const Icon(Icons.save,color: Colors.white,size: 15,)
                                                ],
                                                ),
                                                ):
                                                const Text("")
                                              ])
                                      )
                                  ),
                                ),
                              ),
                              mediabool==true && mediapage==1?
                              socialmedia() :
                              mediabool==true && mediapage==2?
                              socialmediaedit():
                              Container(),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profile(){
    var clubdata = clubProfileDetailsController.clunprofiledata[0];
    var statedata = clubProfileDetailsController.clubstatedata.map((item) => item['name']).join(',');
    var citydata=clubProfileDetailsController.clubcitydata.map((element) => element['name']).join(',');
    var sportdata=clubProfileDetailsController.clubsportdata.map((element) => element['sportName']).join(' , ');
    // var specialitydata=clubProfileDetailsController.clubsportdata.map((element) => element['sportName']).join(' , ');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Organization Name",style: profiletxtheadtxt,),
                Text("${clubdata['academieData']['academieName']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style: profiletxtheadtxt,),
                    Text("${clubdata['userData']['firstName']??''}",style: profiletxtheadsubtxt,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Last Name",style: profiletxtheadtxt,),
                    Text("${clubdata['userData']['lastName']??''}",style: profiletxtheadsubtxt,)
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mobile Number",style: profiletxtheadtxt,),
                Text("${clubdata['academieData']['phone']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sport of Interest",style: profiletxtheadtxt,),
                Text(sportdata??'',style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email ID",style: profiletxtheadtxt,),
                Text("${clubdata['userData']['email']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("State We Coach",style: profiletxtheadtxt,),
                Text("${statedata??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("City We Coach",style: profiletxtheadtxt,),
                Text("${citydata??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget profileedit(){
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List defaultstate=clubProfileDetailsController.clubstatedata.map((element) => (element['name'])).toList();
    List city = citylistController.citydata.map((item) =>(item['name'].toString())).toList();
    List defaultcity=clubProfileDetailsController.clubcitydata.map((element) => (element['name'])).toList();
    var sportdatalist=sportslistcontroller.getsportsdata.map((element) => element['sportName']).toList();
    var defaultsportdata=clubProfileDetailsController.clubsportdata.map((element) => element['sportName']).toList();
    // List speciality = specialitylistController.specialitydata.map((item) =>(item['specialityTitle'].toString())).toList();
    // List defaultspeciality=clubProfileDetailsController.clubspecialitydata.map((element) => (element['specialityTitle'])).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Organization Name",style: profilesubtxt1,),
              newtextfield(organizationcontroller,TextInputType.text)
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: displaywidth(context)*0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style: profilesubtxt1,),
                    newtextfield(firstnamecontroller,TextInputType.text)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: displaywidth(context)*0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last Name",style: profilesubtxt1,),
                    newtextfield(lastnamecontroller,TextInputType.text)
                  ],
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone Number",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: inputtxt,
                    controller: phonecontroller,
                    cursorColor: primary,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),
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
              Text("Email Id",style: profilesubtxt1,),
              newtextfield(emailcontroller,TextInputType.emailAddress)
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sport of Interest",style: profilesubtxt1,),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:MultiSelectDropdown.simpleList(
                  list: sportdatalist,
                  boxDecoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  whenEmpty: "",
                  duration:const Duration(microseconds: 0),
                  numberOfItemsLabelToShow: 5,
                  textStyle: inputtxt,
                  isLarge: true,
                  listTextStyle: inputtxt,
                  checkboxFillColor:primary,
                  initiallySelected:defaultsportdata,
                  onChange: (newList) {
                    List specialityIds = newList.map((name) {
                      var specialityItem = sportslistcontroller.getsportsdata.firstWhere((item) => item['sportName'] == name);
                      return specialityItem['id'];
                    }).toList();
                    String valuestring=specialityIds.join(',');
                    sportsidsvalue=valuestring;
                    print(sportsidsvalue);
                  },
                )
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("State You Coaching ",style: profilesubtxt1,),
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
                    whenEmpty: "Select State",
                    listTextStyle: inputtxt,
                    checkboxFillColor:primary,
                    initiallySelected: defaultstate,
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
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("City You Coach",style: profilesubtxt1,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:MultiSelectDropdown.simpleList(
                    list: city,
                    boxDecoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    whenEmpty: "Select City",
                    duration:const Duration(microseconds: 0),
                    textStyle: inputtxt,
                    listTextStyle: inputtxt,
                    checkboxFillColor:primary,
                    initiallySelected:defaultcity,
                    onChange: (newList) {
                      List selectedCityIds = newList.map((name) {
                        var cityItem = citylistController.citydata.firstWhere((item) => item['name'] == name,
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
        ),
      ],
    );
  }

  Widget Aboutclub(){
    var clubdata=clubProfileDetailsController.clunprofiledata[0]['academieData'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ages We Training",style: profiletxtheadtxt,),
                Text("${clubdata['ageYouCoach']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gender We Training",style: profiletxtheadtxt,),
                Text("${clubdata['genderYouCoach']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About Organization",style: profiletxtheadtxt,),
                Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['bio']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("League Information",style: profiletxtheadtxt,),
                Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['leagueName']??''} ",style: profiletxtheadsubtxt,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Aboutclubedit(){
    String getdefaultages=clubProfileDetailsController.clunprofiledata[0]['academieData']['ageYouCoach']??'';
    List defaultages=getdefaultages.split(',');
    String getdefaultgender=clubProfileDetailsController.clunprofiledata[0]['academieData']['genderYouCoach']??'';
    List defaultgender=getdefaultgender.split(',');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ages We Coaching",style: profilesubtxt1,),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:  SizedBox(
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
                      initiallySelected: defaultages,
                      onChange: (newList) async{
                        print(selectedage);
                        selectedage=newList.join(',');

                      },
                    ),
                  )
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
              Text("Gender We Coaching",style: profilesubtxt1,),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:  SizedBox(

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
                      initiallySelected: defaultgender,
                      onChange: (newList) async{
                        selectedgender=newList.join(',');
                        print(selectedgender);

                      },
                    ),
                  )
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
              Text("About Organization ",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: primary,
                  keyboardType:TextInputType.text,
                  controller: aboutclubcontroller,
                  maxLines: 3,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
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
              Text("League Information",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: primary,
                  keyboardType:TextInputType.text,
                  controller: leaguenamecontroller,
                  maxLines: 3,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget socialmedia(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Website Link",style: profiletxtheadtxt,),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['websiteLink']??''}",style: linkbtntxt,)
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Youtube video Link",style: profiletxtnew,),
          //       Padding(
          //           padding: const EdgeInsets.all(0.0),
          //           child: Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['twitterLink']??''}",style: linkbtntxt,)
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("X Profile Link",style: profiletxtheadtxt,),
                Row(
                  children: [
                    Image.asset("assets/Media/xlink.png",height: 18,width: 18,),
                    Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['twitterLink']??''}",style: linkbtntxt,)
                    ),
                  ],
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("IG Profile Link",style: profiletxtheadtxt,),
                Row(
                  children: [
                    Image.asset("assets/Media/iglink.png",height: 18,width: 18,),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['instagramLink']??''}",style: linkbtntxt,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialmediaedit(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Website Link  ",style: profilesubtxt1,),
              newtextfield(websitelinkcontroller,TextInputType.text)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("X Profile Link  ",style: profilesubtxt1,),
              newtextfield(xlinkcontroller,TextInputType.text)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IG Profile Link  ",style: profilesubtxt1,),
              newtextfield(iglinkcontroller,TextInputType.text)
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text("Youtube Link  ",style: profilesubtxt1,),
        //       newtextfield(youtubelinkcontroller,TextInputType.text)
        //     ],
        //   ),
        // ),

      ],
    );
  }
}
