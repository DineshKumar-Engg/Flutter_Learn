import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Coach Service/Coach Details Api.dart';
import '../../Services/Coach Service/Coach Profile Edit Api.dart';
import '../../Services/get data/City_list.dart';
import '../../Services/get data/Speciality_list.dart';
import '../../Services/get data/state_list.dart';
import '../../widget/Appbar.dart';
import '../../widget/New Textfield.dart';
import 'package:image/image.dart' as img;

import '../../widget/Shimmer.dart';
import '../../widget/Snackbar.dart';

class CoachProfiledetails extends StatefulWidget {
  const CoachProfiledetails({super.key});

  @override
  State<CoachProfiledetails> createState() => _CoachProfiledetailsState();
}

class _CoachProfiledetailsState extends State<CoachProfiledetails> {

  late final MultiSelectController _controller = MultiSelectController();
  final MultiSelectController _controller1 = MultiSelectController();
  final MultiSelectController _controller2 = MultiSelectController();
  List state = [];

 XFile?file;
 final picker=ImagePicker();
 String?base64String;
 
  String?sendagewecoach;

  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController primarysportcontroller=TextEditingController();
  final TextEditingController specialistcontroller=TextEditingController();
  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController phonecontroller=TextEditingController();
  final TextEditingController biocontroller=TextEditingController();
  final TextEditingController websitelinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController xprofilecontroller=TextEditingController();
  final TextEditingController youtubelinkcontroller=TextEditingController();
  final TextEditingController agewecoachcontroller=TextEditingController();
  final TextEditingController genderwecoachcontroller=TextEditingController();
  final TextEditingController lookingforcontroller=TextEditingController();

  final CoachEditProfileController coachEditProfileController=Get.find<CoachEditProfileController>();
  final CoachProfileController coachProfileController=Get.find<CoachProfileController>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();

  bool?profilebool=true;
  String ?sportname;
  int profile=0;
  int profilepage=1;
  int mediapage=1;
  int achievementpage=1;
  bool?achievementbool=false;
  bool?mediabool=false;
  bool ?isactive,ispublish;
  // int ?sportid;
  String?imageurl,issubscription,isapprove,filetype;
  File ?SelectedImage;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Other'];
  String ?selectedValue,selectedgender,genderyoucoach,ageyoucoach,Coachspeciality,
      Selectedstate,SelectedCity,selectestateid,selectedcityid,sportid,selectedage;
  String ?service,athleteprofileimage;
  String token='';
  int?userid,imageid;

  Future<void> updateCityData(stateid) async {
    await citylistController.CitylistApi(context,stateid);

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

      // Check and print the image format
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
        "description": "Coach Profile Image",
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
      await coachProfileController.CoachProfileApi(context);

    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    coachProfileController.CoachProfileApi(context);
    specialitylistController.SpecialityApi(context);
    statelistController.StatelistApi(context);
    firstnamecontroller.text=coachProfileController.coachprofiledata[0]['userData']['firstName']??'';
    lastnamecontroller.text=coachProfileController.coachprofiledata[0]['userData']['lastName']??'';
    sportname=coachProfileController.coachsportdata[0]['sportName']??'';
    emailcontroller.text=coachProfileController.coachprofiledata[0]['userData']['email']??'';
    phonecontroller.text=coachProfileController.coachprofiledata[0]['coachData']['phone']??'';
    biocontroller.text=coachProfileController.coachprofiledata[0]['coachData']['bio']??'';
    lookingforcontroller.text=coachProfileController.coachprofiledata[0]['coachData']['lookingFor']??'';
    sportid=coachProfileController.coachprofiledata[0]['coachData']['sportId']??'';
    Coachspeciality=coachProfileController.coachprofiledata[0]['coachData']['coachSpecialty']??'';
    selectedValue=coachProfileController.coachprofiledata[0]['coachData']['age']??'';
    // selectedgender=coachProfileController.coachprofiledata[0]['coachData']['gender']??'';
    websitelinkcontroller.text=coachProfileController.coachprofiledata[0]['coachData']['websiteLink']??'';
    xprofilecontroller.text=coachProfileController.coachprofiledata[0]['coachData']['twitterLink']??'';
    iglinkcontroller.text=coachProfileController.coachprofiledata[0]['coachData']['instagramLink']??'';
    isactive=coachProfileController.coachprofiledata[0]['coachData']['isActive']??'';
    issubscription=coachProfileController.coachprofiledata[0]['coachData']['isSubscription']??'';
    ispublish=coachProfileController.coachprofiledata[0]['coachData']['isPublish']??'';
    isapprove=coachProfileController.coachprofiledata[0]['coachData']['isApprove']??'';
    selectedage=coachProfileController.coachprofiledata[0]['coachData']['ageYouCoach']??'';
    selectedgender=coachProfileController.coachprofiledata[0]['coachData']['genderYouCoach']??'';
    selectestateid=coachProfileController.coachprofiledata[0]['coachData']['state']??'';
    selectedcityid=coachProfileController.coachprofiledata[0]['coachData']['city']??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List gallerydata=coachProfileController.coachprofiledata[0]['galleryData']??[];
    var profileimage=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
    athleteprofileimage=profileimage??'';
    var profileimageid=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'id':0})['id'];
    imageid=profileimageid??'';
    return  Scaffold(
      backgroundColor: background,
      appBar:appbarwidget("Profile Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
        child: SingleChildScrollView(
          child: Obx(
                ()=>
            coachProfileController.coachprofiledata.isEmpty?shimmer(displayheight(context)*1):
            Column(
              children:[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child:  Column(
                    children: [
                      Container(
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
                                 child: file!=null?
                                     ClipRRect(
                                         borderRadius: BorderRadius.circular(100),
                                         child: Image.file(File(file!.path),height: 120,width: 120,fit: BoxFit.cover,))
                                     :  CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage("$profileimage"),
                                 ),
                               ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Hi, ",style: aboutclubtxt,),
                                        Text("${coachProfileController.coachprofiledata[0]['userData']['firstName']??''}",style: profiletxtheadsubtxt,),
                                      ],
                                    ),
                                    Text("${coachProfileController.coachsportdata[0]['sportName']??''}",style:profiletxtheadsubtxt ,),
                                    Text("${coachProfileController.coachprofiledata[0]['userData']['email']??''}",style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
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
                                                    coachEditProfileController.CoachEditProfileApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedValue.toString(),selectedgender.toString(),selectedcityid,
                                                        selectestateid,emailcontroller.text,phonecontroller.text,biocontroller.text,
                                                        xprofilecontroller.text,iglinkcontroller.text,youtubelinkcontroller.text,sportid,
                                                        isactive, issubscription.toString(),ispublish,isapprove.toString(),websitelinkcontroller.text,
                                                        Coachspeciality.toString(),selectedage,selectedgender.toString(),lookingforcontroller.text);
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
                            newprofile():
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
                                                child: Text("About Coach",style: visacardtxt,),
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
                                                    coachEditProfileController.CoachEditProfileApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedValue.toString(),selectedgender.toString(),selectedcityid,
                                                        selectestateid,emailcontroller.text,phonecontroller.text,biocontroller.text,
                                                        xprofilecontroller.text,iglinkcontroller.text,youtubelinkcontroller.text,sportid,
                                                        isactive.toString(), issubscription.toString(),ispublish.toString(),isapprove.toString(),
                                                        websitelinkcontroller.text,Coachspeciality.toString(),selectedage,selectedgender.toString(),lookingforcontroller.text);
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
                                  // height: displayheight(context)*0.06,
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
                                                    coachEditProfileController.CoachEditProfileApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedValue.toString(),selectedgender.toString(),selectedcityid,
                                                        selectestateid,emailcontroller.text,phonecontroller.text,biocontroller.text,
                                                        xprofilecontroller.text,iglinkcontroller.text,youtubelinkcontroller.text,sportid,
                                                        isactive.toString(), issubscription.toString(),ispublish.toString(),isapprove.toString(),
                                                        websitelinkcontroller.text,Coachspeciality.toString(),selectedage,selectedgender.toString(),lookingforcontroller.text);
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
                      )


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
  Widget newprofile(){
    var statedata=coachProfileController.coachstatedata.map((item) => item['name']).join(',');
    var citydata=coachProfileController.coachcitydata.map((item) => item['name']).join(',');
    var specialitydata=coachProfileController.coachspecialitydata.map((element) => element['specialityTitle']).join(',');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style:profiletxtheadtxt ,),
                    Text("${coachProfileController.coachprofiledata[0]['userData']['firstName']??''}",style:profiletxtheadsubtxt),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Last Name",style:profiletxtheadtxt ,),
                    Text("${coachProfileController.coachprofiledata[0]['userData']['lastName']??''}",style:profiletxtheadsubtxt),
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
                Text("Email ID ",style:profiletxtheadtxt ,),
                Text("${coachProfileController.coachprofiledata[0]['userData']['email']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone Number  ",style:profiletxtheadtxt ,),
                  Text("${coachProfileController.coachprofiledata[0]['coachData']['phone']??''}",style:profiletxtheadsubtxt ,),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Specialty Position ",style:profiletxtheadtxt ,),
                Text(specialitydata??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sport ",style:profiletxtheadtxt ,),
                Text("${coachProfileController.coachsportdata[0]['sportName']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("State We Coaching",style:profiletxtheadtxt ,),
                Text("${statedata??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("City We Coaching ",style:profiletxtheadtxt ,),
                Text("${citydata??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileedit(){
     List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
     List defaultstate=coachProfileController.coachstatedata.map((element) => (element['name'])).toList();
     List city = citylistController.citydata.map((item) =>(item['name'].toString())).toList();
     List defaultcity=coachProfileController.coachcitydata.map((element) => (element['name'])).toList();
     List speciality = specialitylistController.specialitydata.map((item) =>(item['specialityTitle'].toString())).toList();
     List defaultspeciality=coachProfileController.coachspecialitydata.map((element) => (element['specialityTitle'])).toList();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style: profilesubtxt1,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: displayheight(context)*0.08,
                        width: displaywidth(context)*0.40,
                        child: TextFormField(
                          style: inputtxt,
                          controller: firstnamecontroller,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last Name ",style: profilesubtxt1,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: displayheight(context)*0.08,
                        width: displaywidth(context)*0.40,
                        child: TextFormField(
                          style: inputtxt,
                          controller: lastnamecontroller,
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
                Text("Email ID",style: profilesubtxt1,),
                newtextfield(emailcontroller,TextInputType.text)
              ],
            ),
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
                  height: displayheight(context)*0.09,
                  child: TextFormField(
                    maxLength: 10,
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
                Text("Specialty Position",style: profilesubtxt1,),
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
                      initiallySelected:defaultspeciality,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("State You Coaching ", style: profilesubtxt1,),
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
                          Future.value(updateCityData(selectestateid));
                          // print(selectestateid);
                          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${updateCityData(selectestateid)}");

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
                Text("City You Coaching",style: profilesubtxt1,),
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Website Link  ",style:profiletxtheadtxt ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("${coachProfileController.coachprofiledata[0]['coachData']['websiteLink']??''}",style:profiletxtheadsubtxt ,),
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("X profile Link  ",style:profiletxtheadtxt ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset("assets/Media/xlink.png",height: 18,width: 18,),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Text("${coachProfileController.coachprofiledata[0]['coachData']['twitterLink']??''}",style:profiletxtheadsubtxt ,),
                      ),
                    ],
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("IG profile Link  ",style:profiletxtheadtxt ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset("assets/Media/iglink.png",height: 18,width: 18,),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Text("${coachProfileController.coachprofiledata[0]['coachData']['instagramLink']??''}",style:profiletxtheadsubtxt ,),
                      ),
                    ],
                  ),
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
              newtextfield(xprofilecontroller,TextInputType.text)
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

      ],
    );
  }

  Widget Aboutclub(){
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
                Text("Ages We Coaching",style:profiletxtheadtxt ,),
                Text("${coachProfileController.coachprofiledata[0]['coachData']['ageYouCoach']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gender We Coaching",style:profiletxtheadtxt ,),
                Text("${coachProfileController.coachprofiledata[0]['coachData']['genderYouCoach']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Coach Bio  ",style:profiletxtheadtxt ,),
                Text(" ${coachProfileController.coachprofiledata[0]['coachData']['bio']??''}",style: profiletxtheadsubtxt,)

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What Are You Looking For  ",style:profiletxtheadtxt ,),
                Text("${coachProfileController.coachprofiledata[0]['coachData']['lookingFor']??''}",style: profiletxtheadsubtxt,)
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget Aboutclubedit(){
    String getdefaultages=coachProfileController.coachprofiledata[0]['coachData']['ageYouCoach']??'';
    List defaultages=getdefaultages.split(',');
    String getdefaultgender=coachProfileController.coachprofiledata[0]['coachData']['genderYouCoach']??'';
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
              Text("Athlete Bio ",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: primary,
                  keyboardType:TextInputType.text,
                  controller: biocontroller,
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
              Text("What Are You Looking For ",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: primary,
                  keyboardType:TextInputType.text,
                  controller: lookingforcontroller,
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
}

