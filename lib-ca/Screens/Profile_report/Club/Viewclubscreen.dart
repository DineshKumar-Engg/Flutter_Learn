import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/DeleteclubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/EditclubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/GetallClubController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart'as Core;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/common_textfield.dart';
import '../../../Widget/snackbar.dart';
import '../../../service/CitylistController.dart';
import '../../../service/GetStatelistController.dart';
import '../../../service/GetallspecialityController.dart';
import '../../Sport/Getall_sport_Controller.dart';
import 'AddclubController.dart';

class Viewclubscreen extends StatefulWidget {
  Map<String,dynamic> data;
   Viewclubscreen({super.key,required this.data});

  @override
  State<Viewclubscreen> createState() => _ViewclubscreenState();
}

class _ViewclubscreenState extends State<Viewclubscreen> {

  final GetallClubController getallClubController=Get.find<GetallClubController>();
  final ClubapproveController clubapproveController=Get.find<ClubapproveController>();
  final DeleteClubController deleteClubController=Get.find<DeleteClubController>();
  final EditclubController editclubController=Get.find<EditclubController>();
  final List<String> approvalist=['Approve','Pending','Reject'];

  String?Approvalstatus;
  int selectedcontainer=0;

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
  final List<String> agelist = ['07','08','09','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Male and Female'];
int?imageid;
  Core.XFile?file;
  String?filetype,token,pickimage;
  final picker=Core.ImagePicker();
  String?base64String;

  Future<void> pickimagefromgallery() async {
    final _pickedimage = await picker.pickImage(source:Core.ImageSource.gallery);
    if (_pickedimage != null) {
      setState(() {
        file = _pickedimage;
      });
      List<int> imagebytes = File(file!.path).readAsBytesSync();
      img.Image? image = img.decodeImage(imagebytes);
      List<int> compressedImageBytes = img.encodeJpg(image!, quality: 50);  // Adjust quality as needed
      base64String = base64Encode(compressedImageBytes);

      // Extracting the file name
      String filename = file!.path.split('/').last;

      pickimage!.isEmpty?uploadFile(compressedImageBytes, filename):updateFile(compressedImageBytes, filename);

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
    // Example data
    final fileData = {"buffer":imagebytes, "originalname":"$name"};
    final fileLocation = json.encode(fileData);

    // Print the fileLocation to console
    print("fileLocation: $fileLocation");

    const url = 'https://api.engageathlete.com/api/v1/upload-singlefiletest';
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
        "userId": widget.data['user']['id']
      }),
    );
    if (response.statusCode == 201) {
      print(fileLocation);
      print('File uploaded successfully');
      StackDialog.show("Successfully Uploaded", "Image Uploaded Successfully", Icons.verified, Colors.green);
      getallClubController.GetallclubApi(context);
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
        "userId": widget.data['user']['id'],
        "id":imageid
      }),
    );
    if (response.statusCode == 201) {
      print(fileLocation);
      print('File Updated successfully');
      StackDialog.show("Successfully Uploaded", "Image Updated Successfully", Icons.verified, Colors.green);
      getallClubController.GetallclubApi(context);
    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }
  @override
  void initState() {
    getallClubController.GetallclubApi(context);
    organizationcontroller.text=widget.data['academieName']??'';
    firstnamecontroller.text=widget.data['user']['firstName']??'';
    lastnamecontroller.text=widget.data['user']['lastName']??'';
    emailcontroller.text=widget.data['user']['email']??'';
    mobilecontroller.text=widget.data['phone']??'';
    aboutcontroller.text=widget.data['bio']??'';
    leaguecontroller.text=widget.data['leagueName']??'';
    websitecontroller.text=widget.data['websiteLink']??'';
    iglinkcontroller.text=widget.data['instagramLink']??'';
    xlinkcontroller.text=widget.data['twitterLink']??'';
    Approvalstatus=widget.data['isApprove']??'';
    selectestateid=widget.data['state']??'';
    selectedcityid=widget.data['city']??'';
    sportsidsvalue=widget.data['sportsId']??'';
    // selectedgender=widget.data['genderYouCoach'];
    selectedage=widget.data['ageYouCoach'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List gallerydata = widget.data['user']['galleries'] ?? [];
    var profileimage = gallerydata.firstWhere((element) => element['fileType'] == "Profile Image", orElse: () => {'fileLocation': ''},)['fileLocation'];
    pickimage=profileimage??'';
    var profileimageid=gallerydata.firstWhere((element) => element['fileType'] == "Profile Image", orElse: () => {'id': 0},)['id'];
    imageid=profileimageid??0;
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Club & Academic Details"),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
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
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                pickimagefromgallery();
                              },
                              child: file==null?CircleAvatar(
                                radius: 70,
                                backgroundColor:Colors.grey,
                                backgroundImage: NetworkImage(profileimage),
                              ):SizedBox(
                                  height: 150,
                                  width: 150,
                                  child:ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(File(file!.path),fit: BoxFit.cover,))
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:5.0,top: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${widget.data['user']['firstName']+" "+widget.data['user']['lastName']}",style:profiletxtheadtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.data['user']['email'],style: profiletxtheadtxt,),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    selectedcontainer==1?
                    editclubreport():
                    viewclubreport(),
                    selectedcontainer==1?
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: displayheight(context)*0.06,
                            width: displaywidth(context)*0.42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )),
                              onPressed: (){
                                setState(() {
                                  selectedcontainer=2;
                                });

                              },child: Center(child: Text("Back",style: btntxtwhite,),),
                            ) ,
                          ),
                          SizedBox(
                            height: displayheight(context)*0.06,
                            width: displaywidth(context)*0.42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )),
                              onPressed: (){
                                editclubController.EditClubApi(context, widget.data['user']['id'], organizationcontroller.text, firstnamecontroller.text, lastnamecontroller.text, emailcontroller.text,
                                    selectestateid, selectedcityid, selectedage, selectedgender, aboutcontroller.text, websitecontroller.text,
                                    xlinkcontroller.text, iglinkcontroller.text, mobilecontroller.text, leaguecontroller.text,
                                    sportsidsvalue, widget.data['isPublish'], widget.data['subscriptionId'], widget.data['isApprove']);
                                getallClubController.GetallclubApi(context);
                              },child: Center(child: Text("Submit",style: btntxtwhite,),),
                            ) ,
                          )

                        ],
                      ),
                    ):
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: displayheight(context)*0.06,
                            width: displaywidth(context)*0.42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )),
                              onPressed: (){
                                setState(() {
                                  selectedcontainer=1;
                                });

                              },child: Center(child: Text("Edit",style: btntxtwhite,),),
                            ) ,
                          ),
                          SizedBox(
                            height: displayheight(context)*0.06,
                            width: displaywidth(context)*0.42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )),
                              onPressed: (){
                                delete(widget.data['user']['id']);
                              },child: Center(child: Text("Delete",style: btntxtred,),),
                            ) ,
                          )

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
    );
  }
  Widget viewclubreport(){
    List sportdata=widget.data['sports']??[];
    var sportdatas=sportdata.map((e) => e['sportName']??'').join(' , ');
    List getstatedata=widget.data['stateData']??[];
    var statedata=getstatedata.map((item)=>item['name']).join(' , ');
    List getcitydata=widget.data['citiesData']??[];
    var citydata=getcitydata.map((item)=>item['name']).join(' , ');
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Approval Status",style:profiletxtheadtxt,),
                SizedBox(
                  height: displayheight(context)*0.08,
                  width: displaywidth(context)*0.40,
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
                    value: Approvalstatus,
                    items: approvalist.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item,style: inputtxt,),
                        onTap: (){
                          setState(() {
                            Approvalstatus=item;
                          });
                        },
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        Approvalstatus = newValue as String;
                        clubapproveController.ClubapproveApi(context, widget.data['user']['id'], Approvalstatus);
                        getallClubController.GetallclubApi(context);
                      });
                    },

                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Club & Academic Profile",style: profiletxtheadwhite,),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Organization Name",style:profiletxtheadtxt ,),
                Text(widget.data['academieName']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
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
                    Text("First Name  ",style:profiletxtheadtxt ,),
                    Text(widget.data['user']['firstName']??'',style:profiletxtheadsubtxt ,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Last Name  ",style:profiletxtheadtxt ,),
                    Text(widget.data['user']['lastName']??'',style:profiletxtheadsubtxt ,),
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
                Text("Sports of Interest ",style:profiletxtheadtxt ,),
                Text(sportdatas??"",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email ID",style:profiletxtheadtxt ,),
                Text(widget.data['user']['email']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mobile Number",style:profiletxtheadtxt ,),
                Text(widget.data['phone']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("City We Coaching",style:profiletxtheadtxt ,),
                Text(citydata??"",style:profiletxtheadsubtxt ,),
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
                Text(statedata??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("About Club & Academic ",style: profiletxtheadwhite,),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age We Coaching",style:profiletxtheadtxt ,),
                HtmlWidget('''
                          ${widget.data['ageYouCoach']??''}
                                     ''',textStyle:profiletxtheadsubtxt ,)
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
                HtmlWidget('''
                          ${widget.data['genderYouCoach']??''}
                                     ''',textStyle:profiletxtheadsubtxt ,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("League Information",style:profiletxtheadtxt ,),
                HtmlWidget('''
                          ${widget.data['leagueName']??''}
                                     ''',textStyle:profiletxtheadsubtxt ,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Club Bio ",style:profiletxtheadtxt ,),
                HtmlWidget('''
                          ${widget.data['bio']??''}
                                     ''',textStyle:profiletxtheadsubtxt ,)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Social Media Links",style: profiletxtheadwhite,),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Website Link ",style:profiletxtheadtxt ,),
                Text(widget.data['websiteLink']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("X profile Link  ",style:profiletxtheadtxt ,),
                Text(widget.data['twitterLink']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("IG profile Link  ",style:profiletxtheadtxt ,),
                Text(widget.data['instagramLink']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Profile Status",style: profiletxtheadwhite,),
                )),
          ),
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
                    Text("Subscription Status",style:profiletxtheadtxt,),
                    Text(widget.data['isSubscription'],style:profiletxtheadsubtxt,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Approval Status",style:profiletxtheadtxt,),
                    Text(widget.data['isApprove'],style:profiletxtheadsubtxt,),
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
                Text("Publish Status",style:profiletxtheadtxt,),
                Text("${widget.data['isPublish']}",style:profiletxtheadsubtxt,),
              ],
            ),
          ),




        ],
      ),
    );
  }

  Widget editclubreport(){
    var sportdatalist=getall_sport_controller.getsportdata.map((element) => element['sportName']).toList();
    List state = statelistController.statedata.map((item) =>(item['name'].toString())).toList();
    List city = citylistController.getcitylistdata.map((item) =>(item['name'].toString())).toList();
    List sports=widget.data['sports']??[];
    List defaultsports=sports.map((e) => e['sportName']).toList();
    List statedata=widget.data['stateData']??[];
    List defaultstate=statedata.map((e) => e['name']).toList();
    List citydata=widget.data['citiesData']??[];
    List defaultcity=citydata.map((e) => e['name']).toList();
    String agewecoach=widget.data['ageYouCoach']??'';
    List<String> defaultageList = agewecoach.split(',');
    return Padding(
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
                        width: displaywidth(context)*0.41,
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
                        width: displaywidth(context)*0.41,
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
                    duration:const Duration(microseconds: 0),
                    numberOfItemsLabelToShow: 5,
                    textStyle: inputtxt,
                    isLarge: true,
                    listTextStyle: inputtxt,
                    checkboxFillColor:primary,
                    initiallySelected:defaultsports,
                    onChange: (newList) {
                      List specialityIds = newList.map((name) {
                        var specialityItem = getall_sport_controller.getsportdata.firstWhere((item) => item['sportName'] == name);
                        return specialityItem['id'];
                      }).toList();
                      String valuestring=specialityIds.join(',');
                      sportsidsvalue=valuestring;
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
                    initiallySelected:defaultstate,
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
                    initiallySelected:defaultcity,
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
                    padding: const EdgeInsets.all(8.0),
                    child:MultiSelectDropdown.simpleList(
                      list: agelist,
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      whenEmpty: "",
                      duration:const Duration(microseconds: 0),
                      textStyle: inputtxt,
                      listTextStyle: inputtxt,
                      checkboxFillColor:primary,
                      initiallySelected:defaultageList,
                      onChange: (newList) {
                        selectedage=newList.join(',');
                      },
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
                Text("Gender We Coaching",style: inputtxt,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: DropdownButtonFormField(
                    decoration:  InputDecoration(
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
            ],
          ),
        ],
      ),
    );
  }

  delete(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Club & Academic Profile.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deleteClubController.DeleteclubApi(context,id);
              getallClubController.GetallclubApi(context);
            });
          }, child:  Text("Yes",style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child:  Text("No",style: drawertxt,))
        ],
      );
    });

  }
}
