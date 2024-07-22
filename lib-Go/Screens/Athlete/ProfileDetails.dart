import 'dart:convert';
import 'dart:io';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:connect_athelete/Services/get%20data/Speciality_list.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'as Core;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Athlete Service/Profile Edit Api.dart';
import '../../Services/get data/City_list.dart';
import '../../Services/get data/state_list.dart';
import '../../widget/New Textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import '../../widget/Snackbar.dart';

class ProfileDetailscsreen extends StatefulWidget {
  const ProfileDetailscsreen({super.key});

  @override
  State<ProfileDetailscsreen> createState() => _ProfileDetailscsreenState();
}

class _ProfileDetailscsreenState extends State<ProfileDetailscsreen> {

  int container=0;
  int profilepage=1;
  int achievementpage=1;
  int parentpage=1;
  int mediapage=1;
  String ?sportid;
  String ?filetype;
  bool?profilebool=true;
  bool?achievementbool=false;
  bool?parentbool=false;
  bool?mediabool=false;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Others'];
  String ?selectedValue,selectedage,selectedgender,SelectedState,selectedcity,Coachspeciality,sportsidsvalue;

  final  TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController currentschoolcontroller=TextEditingController();
  final TextEditingController citycontroller=TextEditingController();
  final TextEditingController statecontroller=TextEditingController();
  final TextEditingController parentfirstcontroller=TextEditingController();
  final TextEditingController parentlastcontroller=TextEditingController();
  final TextEditingController parentemailcontroller=TextEditingController();
  final TextEditingController parentphoneecontroller=TextEditingController();
  final TextEditingController xlinkcontroller=TextEditingController();
  final TextEditingController biocontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController achievementscontroller=TextEditingController();
  final TextEditingController gamecontroller=TextEditingController();
  final TextEditingController positioncontroller=TextEditingController();
  final TextEditingController currentclubcontroller=TextEditingController();
  final TextEditingController specialitycontroller=TextEditingController();


  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();
  final ProfileEditController profileEditController=Get.find<ProfileEditController>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  String numbercode='+1';

  int?stateid,cityid;
  String ?stateids,cityids;
  XFile?file;
  final picker=ImagePicker();
  String?base64String;
  String token='';
  String ?athleteprofileimage;
  int?userid,imageid;

  Future<void> getimage() async {
    final _pickedimage = await picker.pickImage(source: ImageSource.gallery);
    if (_pickedimage != null) {
      setState(() {
        file = _pickedimage;
      });
      List<int> imagebytes = File(file!.path).readAsBytesSync();
      img.Image? image = img.decodeImage(imagebytes);
      List<int> compressedImageBytes = img.encodeJpg(image!, quality: 50);  // Adjust quality as needed
      base64String = base64Encode(compressedImageBytes);
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
       await profiledetailsController.ProfiledetailsApi(context);
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
      await profiledetailsController.ProfiledetailsApi(context);

    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }



  void updateCityData() async {
    final response = await citylistController.CitylistApi(context, stateid);
    setState(() {
      print(response);
    });
  }


  @override
  void initState() {
    sportslistcontroller.sportslistapi(context);
    specialitylistController.SpecialityApi(context);
    updateCityData();
    profiledetailsController.ProfiledetailsApi(context);
    firstnamecontroller.text=profiledetailsController.profiledata[0]['userData']['firstName']??'';
    lastnamecontroller.text= profiledetailsController.profiledata[0]['userData']['lastName']??'';
    currentschoolcontroller.text=profiledetailsController.profiledata[0]['athleteData']['school']??'';
    cityid= int.parse("${profiledetailsController.profiledata[0]['athleteData']['city']}");
    stateid=int.parse("${profiledetailsController.profiledata[0]['athleteData']['residentialState']}");
    biocontroller.text= profiledetailsController.profiledata[0]['athleteData']['bio']??'';
    parentfirstcontroller.text=profiledetailsController.profiledata[0]['athleteData']['parentFirstName']??'';
    parentlastcontroller.text= profiledetailsController.profiledata[0]['athleteData']['parentLastName']??'';
    parentemailcontroller.text=profiledetailsController.profiledata[0]['userData']['email']??'';
    parentphoneecontroller.text= profiledetailsController.profiledata[0]['athleteData']['parentPhone']??'';
    achievementscontroller.text=profiledetailsController.profiledata[0]['athleteData']['achievements']??'';
    xlinkcontroller.text= profiledetailsController.profiledata[0]['athleteData']['twitterLink']??'';
    iglinkcontroller.text = profiledetailsController.profiledata[0]['athleteData']['instagramLink']??'';
    currentclubcontroller.text=profiledetailsController.profiledata[0]['athleteData']['currentAcademie']??'';
    sportsidsvalue= profiledetailsController.profiledata[0]['athleteData']['sportsId']??'';
    selectedage=profiledetailsController.profiledata[0]['athleteData']['age']??'';
    selectedgender=profiledetailsController.profiledata[0]['athleteData']['gender']??'';
    Coachspeciality=profiledetailsController.profiledata[0]['athleteData']['athleteSpecialty'];
    SelectedState=profiledetailsController.profiledata[0]['stateData']['name']??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List gallerydata=profiledetailsController.profiledata[0]['galleryData']??[];
    var profileimage=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
    athleteprofileimage=profileimage??'';
    var profileimageid=gallerydata.firstWhere((element)=>element['fileType']=="Profile Image",orElse: ()=>{'id':0})['id'];
    imageid=profileimageid??'';

    return  Scaffold(
      backgroundColor: background,
      appBar:appbarwidget("Profile Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15.0),
        child: SingleChildScrollView(
          child: Obx(
              () =>
                profiledetailsController.profiledata.isEmpty?
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    ):
                Column(
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
                                       Text("${profiledetailsController.profiledata[0]['userData']['firstName']??''}",style: profiletxtheadsubtxt,),
                                     ],
                                   ),
                                   Text("${profiledetailsController.sportdata[0]['sportName']??''}",style:profiletxtheadsubtxt ,),
                                   Text("${profiledetailsController.profiledata[0]['userData']['email']??''}",style:profiletxtheadsubtxt ,),
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
                                                }, child: Row(children: [Text("Edit",style: editbtn,), const Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Icon(Icons.edit,color: primary,size: 15,),
                                                )
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
                                                       profileEditController.ProfileEditApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                       selectedage.toString(),selectedgender.toString(),currentschoolcontroller.text,
                                                       cityid,stateid,biocontroller.text,parentfirstcontroller.text,
                                                       parentlastcontroller.text,parentemailcontroller.text,parentphoneecontroller.text,
                                                       achievementscontroller.text,gamecontroller.text,positioncontroller.text,sportsidsvalue,
                                                           xlinkcontroller.text, iglinkcontroller.text,Coachspeciality.toString(),currentclubcontroller.text);
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
                                    // height: displayheight(context)*0.06,
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
                                                child: Text("Your Achievements",style: visacardtxt,),
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
                                                }, child: Row(children: [Text("Edit",style: editbtn,), const Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Icon(Icons.edit,color: primary,size: 15,),
                                                )
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
                                                    profileEditController.ProfileEditApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedage.toString(),selectedgender.toString(),currentschoolcontroller.text,
                                                        cityid,stateid,biocontroller.text,parentfirstcontroller.text,
                                                        parentlastcontroller.text,parentemailcontroller.text,parentphoneecontroller.text,
                                                        achievementscontroller.text,gamecontroller.text,positioncontroller.text,sportsidsvalue,xlinkcontroller.text,
                                                        iglinkcontroller.text,Coachspeciality.toString(),currentclubcontroller.text);
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
                            achievements() :
                            achievementbool==true && achievementpage==2?
                                achievementsedit():
                            Container(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    parentbool=!parentbool!;
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
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                child: Text("Parent Profile",style: visacardtxt,),
                                              ),
                                              parentbool==true && parentpage==1?
                                              TextButton(
                                                style: TextButton.styleFrom(backgroundColor: background
                                                  // const Color(0xFFFFF4D1)
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    parentpage=2;
                                                  });
                                                }, child: Row(children: [Text("Edit",style: editbtn,), const Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Icon(Icons.edit,color: primary,size: 15,),
                                                )
                                              ],
                                              ),
                                              ):
                                              parentbool==true && parentpage==2?
                                              TextButton(
                                                style: TextButton.styleFrom(backgroundColor: Colors.green
                                                  // const Color(0xFFFFF4D1)
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    profileEditController.ProfileEditApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedage.toString(),selectedgender.toString(),currentschoolcontroller.text,
                                                        cityid,stateid,biocontroller.text,parentfirstcontroller.text,
                                                        parentlastcontroller.text,parentemailcontroller.text,parentphoneecontroller.text,
                                                        achievementscontroller.text,gamecontroller.text,positioncontroller.text,sportsidsvalue,xlinkcontroller.text,
                                                        iglinkcontroller.text,Coachspeciality.toString(),currentclubcontroller.text);

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
                            parentbool==true && parentpage==1?
                            parents() :
                            parentbool==true && parentpage==2?
                            parentedit():
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
                                                }, child: Row(children: [Text("Edit",style: editbtn,), const Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Icon(Icons.edit,color: primary,size: 15,),
                                                )
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
                                                    profileEditController.ProfileEditApi(context,firstnamecontroller.text,lastnamecontroller.text,
                                                        selectedage.toString(),selectedgender.toString(),currentschoolcontroller.text,
                                                        cityid,stateid,biocontroller.text,parentfirstcontroller.text,
                                                        parentlastcontroller.text,parentemailcontroller.text,parentphoneecontroller.text,
                                                        achievementscontroller.text,gamecontroller.text,positioncontroller.text,sportsidsvalue,
                                                        xlinkcontroller.text,iglinkcontroller.text,Coachspeciality.toString(),currentclubcontroller.text);
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
    var specialitydata=profiledetailsController.specialitydata.map((item) => item['specialityTitle']).toList().join(' , ');
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
                    Text("${profiledetailsController.profiledata[0]['userData']['firstName']??''}",style:profiletxtheadsubtxt),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last Name",style:profiletxtheadtxt ,),
                    Text("${profiledetailsController.profiledata[0]['userData']['lastName']??''}",style:profiletxtheadsubtxt),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Gender : ",style:profiletxtheadtxt ,),
                    Text("${profiledetailsController.profiledata[0]['athleteData']['gender']??''}",style:profiletxtheadsubtxt ,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Row(
                    children: [
                      Text("Age : ",style:profiletxtheadtxt ,),
                      Text("${profiledetailsController.profiledata[0]['athleteData']['age']??''}",style:profiletxtheadsubtxt ,),
                    ],
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
                Text("Current School ",style:profiletxtheadtxt ,),
                Text("${profiledetailsController.profiledata[0]['athleteData']['school']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current Club & Academy ",style:profiletxtheadtxt ,),
                Core.HtmlWidget('''
              
                ${profiledetailsController.profiledata[0]['athleteData']['currentAcademie']??''}''',textStyle: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Specialty Position ",style:profiletxtheadtxt ,),
                Text("${specialitydata}"??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Resident State ",style:profiletxtheadtxt ,),
                Text("${profiledetailsController.profiledata[0]['stateData']['name']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Resident City ",style:profiletxtheadtxt ,),
                Text("${profiledetailsController.profiledata[0]['citiesData']['name']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Athlete Bio  ",style:profiletxtheadtxt ,),
                Core.HtmlWidget('''
                ${profiledetailsController.profiledata[0]['athleteData']['bio']??''}
                ''',textStyle:profiletxtheadsubtxt ,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileedit(){
    List speciality = specialitylistController.specialitydata.map((item) =>(item['specialityTitle'].toString())).toList();
    List defaultspeciality=profiledetailsController.specialitydata.map((element) => (element['specialityTitle'])).toList();
    return Column(
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
                    child: Text("Age",style: profilesubtxt1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.07,
                      width: displaywidth(context)*0.40,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFD9D9D9)),
                          ),
                          border: OutlineInputBorder(),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Gender",style: profilesubtxt1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.07,
                      width: displaywidth(context)*0.40,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xFFD9D9D9)),
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
                            child: Text(item,style: inputtxt,),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  )
                ],
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
              Text("Current School",style: profilesubtxt1,),
              newtextfield(currentschoolcontroller,TextInputType.text)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Club & Academy",style: profilesubtxt1,),
              newtextfield(currentclubcontroller,TextInputType.text)
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
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Athlete Residential State  ",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4.0),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Athlete Residential City  ",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: "Select City",
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
                  maxLength: 250,
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

  Widget achievements(){
    var sportdata=profiledetailsController.sportdata.map((element) => element['sportName']).toList().join(' , ');
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
                Text("Athlete Achievements  ",style:profiletxtheadtxt ,),
                Core.HtmlWidget('''
               
                ${profiledetailsController.profiledata[0]['athleteData']['achievements']??''}''',textStyle: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sports of Interest",style:profiletxtheadtxt ,),
                Text("$sportdata"??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget achievementsedit(){
    var sportdatalist=sportslistcontroller.getsportsdata.map((element) => element['sportName']).toList();
    var defaultsportdata=profiledetailsController.sportdata.map((element) => element['sportName']).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Athlete Achievements",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: inputtxt,
                  cursorColor: primary,
                  keyboardType:TextInputType.text,
                  controller: achievementscontroller,
                  maxLines: 3,
                  maxLength: 250,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sports of Interest",style: profilesubtxt1,),
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
                  numberOfItemsLabelToShow: 3,
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
        )

      ],
    );
  }

  Widget parents(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Name ",style:profiletxtheadtxt ,),
                    Text("${profiledetailsController.profiledata[0]['athleteData']['parentFirstName']??''}",style:profiletxtheadsubtxt ,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last Name ",style:profiletxtheadtxt ,),
                    Text("${profiledetailsController.profiledata[0]['athleteData']['parentLastName']??''}",style:profiletxtheadsubtxt ,),
                  ],
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Email : ",style:profiletxtheadtxt ,),
                Text("${profiledetailsController.profiledata[0]['userData']['email']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Mobile Number : ",style:profiletxtheadtxt ,),
                Text("${profiledetailsController.profiledata[0]['athleteData']['parentPhone']??''}",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget parentedit(){
    return Column(
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
                  Text("Parent First Name",style: profilesubtxt1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.40,
                      child: TextFormField(
                        keyboardType:TextInputType.text,
                        controller: parentfirstcontroller,
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
                  Text("Parent Last Name ",style: profilesubtxt1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.40,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: parentlastcontroller,
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
              Text("Parent Email",style: profilesubtxt1,),
              newtextfield(parentemailcontroller,TextInputType.emailAddress)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Parent Mobile Number",style: profilesubtxt1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    style: inputtxt,
                    controller: parentphoneecontroller,
                    cursorColor: primary,
                    decoration: InputDecoration(
                      counterText: "",
                        prefix: Text(numbercode,style: inputtxt,),
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
                  child: Text("X profile Link  ",style:profiletxtheadtxt ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset("assets/Media/xlink.png",height: 18,width: 18,),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Text("${profiledetailsController.profiledata[0]['athleteData']['twitterLink']??''}",style:profiletxtheadsubtxt ,),
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
                        child: Text("${profiledetailsController.profiledata[0]['athleteData']['instagramLink']??''}",style:profiletxtheadsubtxt ,),
                      ),
                    ],
                  ),
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
          //       Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: Text("FB profile Link  ",style:profiletxtheadtxt ,),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: Row(
          //           children: [
          //             Image.asset("assets/fblink.png",height: 22,width: 22,),
          //             Padding(
          //               padding: const EdgeInsets.only(left:10.0),
          //               child: Text("www.facebook.com",style:profiletxtheadsubtxt ,),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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

      ],
    );
  }
}
