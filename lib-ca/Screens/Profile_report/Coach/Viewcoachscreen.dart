import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/DeletecoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/EditcoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/GetallCoachController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart'as Core;
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/common_textfield.dart';
import '../../../Widget/snackbar.dart';
import '../../../service/CitylistController.dart';
import '../../../service/GetStatelistController.dart';
import '../../../service/GetallspecialityController.dart';
import '../../Sport/Getall_sport_Controller.dart';

class Viewcoachscreen extends StatefulWidget {
  Map<String,dynamic>data;
   Viewcoachscreen({super.key,required this.data});

  @override
  State<Viewcoachscreen> createState() => _ViewcoachscreenState();
}

class _ViewcoachscreenState extends State<Viewcoachscreen> {

  final GetallCoachController getallCoachController=Get.find<GetallCoachController>();
  final CoachapproveController coachapproveController=Get.find<CoachapproveController>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final GetallCitylistController citylistController=Get.find<GetallCitylistController>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final DeleteCoachController deleteCoachController=Get.find<DeleteCoachController>();
  final EditcoachController editcoachController=Get.find<EditcoachController>();


  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController mobilecontroller=TextEditingController();
  final TextEditingController xlinkcontroller=TextEditingController();
  final TextEditingController iglinkcontroller=TextEditingController();
  final TextEditingController websitecontroller=TextEditingController();
  final TextEditingController biocontroller=TextEditingController();
  final TextEditingController lookinforcontroller=TextEditingController();

  final List<String> approvalist=['Approve','Pending','Reject'];
  int?stateid,cityid;
  int?imageid;
  String?selectedage,selectedgender,selectestateid,selectedcityid,sportsidsvalue,Coachspeciality,sendagewecoach;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List<String> genderlist=['Male','Female','Others'];
  String?Approvalstatus,token,pickimage;
  int selectedcontainer=0;
  Core.XFile?file;
  String?filetype;
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
    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    firstnamecontroller.text=widget.data['user']['firstName']??'';
    lastnamecontroller.text=widget.data['user']['lastName']??'';
    emailcontroller.text=widget.data['user']['email']??'';
    mobilecontroller.text=widget.data['phone']??'';
    websitecontroller.text=widget.data['websiteLink']??'';
    iglinkcontroller.text=widget.data['instagramLink']??'';
    xlinkcontroller.text=widget.data['twitterLink']??'';
    biocontroller.text=widget.data['bio']??'';
    lookinforcontroller.text=widget.data['lookingFor']??'';
    Approvalstatus=widget.data['isApprove']??'';
    selectestateid=widget.data['state']??'';
    selectedcityid=widget.data['city']??'';
    sportsidsvalue=widget.data['sportsId']??'';
    selectedage=widget.data['ageYouCoach']??'';
    statelistController.StatelistApi(context);
    getall_sport_controller.GetSportApi(context);
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
      appBar: appbar_widget("Coach Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      Padding(
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
                      selectedcontainer==1?
                      editcoachreport():
                      viewcoachreport(),
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
                                  editcoachController.EditCoachApi(context, widget.data['user']['id'], firstnamecontroller.text, lastnamecontroller.text,
                                      emailcontroller.text, selectedage, biocontroller.text, selectedcityid, selectestateid,
                                      selectedgender, iglinkcontroller.text, xlinkcontroller.text, widget.data['isApprove'], lookinforcontroller.text, websitecontroller.text,
                                      mobilecontroller.text, widget.data['isPublish'], sportsidsvalue, Coachspeciality, widget.data['isSubscription']);
                                  getallCoachController.GetallcoachApi(context);

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
              )

            ],
          ),
        ),
      ),
    );
  }
  Widget viewcoachreport(){
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
                        coachapproveController.CoachapproveApi(context, widget.data['user']['id'], Approvalstatus);
                        getallCoachController.GetallcoachApi(context);
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
                  child: Text("Coach Profile",style: profiletxtheadwhite,),
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
                  child: Text("About Coach ",style: profiletxtheadwhite,),
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
                Text(widget.data['genderYouCoach']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Coach Bio ",style:profiletxtheadtxt ,),
                HtmlWidget('''
                          ${widget.data['bio']??''}
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
                Text("What are you Looking for ",style:profiletxtheadtxt ,),
                HtmlWidget('''
                          ${widget.data['lookingFor']??''}
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

  Widget editcoachreport(){
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
    String genderwecoach=widget.data['genderYouCoach']??'';
    List<String> defaultgenderlist=genderwecoach.split(',');
    return  Column(
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
            child: Center(child: Text("Coach Details",style: listheadingtxt,)),
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
                      width: displaywidth(context)*0.43,
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
                      width: displaywidth(context)*0.43,
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
                  initiallySelected: defaultstate,
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
            child: Center(child: Text("About Coach",style: listheadingtxt,)),
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
                  padding: const EdgeInsets.all(8.0),
                  child:MultiSelectDropdown.simpleList(
                    list: genderlist,
                    boxDecoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    whenEmpty: "",
                    duration:const Duration(microseconds: 0),
                    textStyle: inputtxt,
                    listTextStyle: inputtxt,
                    checkboxFillColor:primary,
                    initiallySelected:defaultgenderlist,
                    onChange: (newList) {
                      selectedgender=newList.join(',');
                    },
                  )
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Coach bio",style: inputtxt,),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("What Are You Looking For",style: inputtxt,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: inputtxt,
            maxLines: 3,
            maxLength: 500,
            cursorColor: Colors.black,
            controller: lookinforcontroller,
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
    );
  }

  delete(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Coach Profile.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deleteCoachController.DeletecoachApi(context, id);
              getallCoachController.GetallcoachApi(context);
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
