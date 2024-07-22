import 'dart:convert';
import 'dart:io';
import 'package:connect_athlete_admin/Widget/Loading.dart';
import 'package:http/http.dart'as http;
import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteApproveController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/EditAthleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/deleteathleteController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart'as Core;
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/common_textfield.dart';
import '../../../Widget/snackbar.dart';
import '../../../service/GetStatelistController.dart';
import '../../../service/GetallspecialityController.dart';
import '../../../service/GetcitylistController.dart';
import '../../Sport/Getall_sport_Controller.dart';
import 'package:get/get.dart';

class Viewathletescreen extends StatefulWidget {
  Map<String,dynamic>data;
  String sportid;
   Viewathletescreen({super.key,required this.data,required this.sportid});

  @override
  State<Viewathletescreen> createState() => _ViewathletescreenState();
}

class _ViewathletescreenState extends State<Viewathletescreen> {
  final StatelistController statelistController=Get.find<StatelistController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final DeleteAthleteController deleteAthleteController=Get.find<DeleteAthleteController>();
  final GetallAthleteController getallAthleteController=Get.find<GetallAthleteController>();
  final EditRegistrationController editRegistrationController=Get.find<EditRegistrationController>();
  final AthleteapproveController athleteapproveController=Get.find<AthleteapproveController>();


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


  bool switchvalue=true;
  int selectedcontainer=0;
  int?stateid,cityid,imageid;
  String?selectedage,selectedgender,SelectedState,selectedcity,sportsidsvalue,Coachspeciality,Approvalstatus;
  final List<String> agelist = ['7','8','9','10','11','12','13','14','15','16','17','18+'];
  final List <String> genderlist=['Male','Female','Other'];
  final List<String> approvalist=['Approve','Pending','Reject'];


  void updateCityData() async {
    final response = await citylistController.CitylistApi(context, stateid);
    setState(() {
      print(response);
    });
  }

  void updatedspecialitydata()async{
    await specialitylistController.SpecialityApi(context, widget.sportid);
  }
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
    selectedgender=widget.data['gender']??'';
    selectedage=widget.data['age']??'';
    currentschoolcontroller.text=widget.data['school']??'';
    currentacademycontroller.text=widget.data['currentAcademie']??'';
    gradecontroller.text=widget.data['grade']??'';
    xlinkcontroller.text=widget.data['twitterLink']??'';
    iglinkcontroller.text=widget.data['instagramLink']??'';
    biocontroller.text=widget.data['bio']??'';
    achievementscontroller.text=widget.data['achievements']??'';
    parentfirstnamecontroller.text=widget.data['parentFirstName']??'';
    parentlastnamecontroller.text=widget.data['parentLastName']??'';
    mobilecontroller.text=widget.data['parentPhone']??'';
    emailcontroller.text=widget.data['user']['email']??'';
    Approvalstatus=widget.data['isApprove']??'';
    SelectedState=widget.data['stateData']['name']??'';
    stateid=int.parse("${widget.data['residentialState']??''}");
    cityid=int.parse("${widget.data['city']??''}");
    sportsidsvalue=widget.data['sportsId']??'';
    Coachspeciality=widget.data['athleteSpecialty']??"";
    statelistController.StatelistApi(context);
    getall_sport_controller.GetSportApi(context);
    updateCityData();
    updatedspecialitydata();
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
      appBar: appbar_widget("Athlete Details"),
      body: Padding(
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
                        editathletereport():
                        viewathletereport(),
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
                                editRegistrationController.EditRegistrationApi(context,
                                   widget.data['user']['id'],firstnamecontroller.text, lastnamecontroller.text, selectedage, selectedgender, currentschoolcontroller.text,
                                   cityid, stateid, parentfirstnamecontroller.text, parentlastnamecontroller.text, emailcontroller.text,
                                   mobilecontroller.text, sportsidsvalue, gradecontroller.text,xlinkcontroller.text,iglinkcontroller.text
                                   ,biocontroller.text,achievementscontroller.text,currentacademycontroller.text, widget.data['isApprove'],
                                   widget.data['isPublish'], widget.data['isSubscription'], widget.data['isActive'],Coachspeciality);
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

    Widget viewathletereport(){
     List gallerydata=widget.data['user']['galleries']?.where((element)=>element['fileType']=="Headshot Image").toList();
     List galleryvideos=widget.data['user']['galleries']?.where((element)=>element['fileType']=="Headshot Video").toList();
     List sportdata=widget.data['sports']??[];
     var sportdatas=sportdata.map((e) => e['sportName']??'').join(' , ');
     List specialitydata=widget.data['specialities']??[];
     var specialityessata=specialitydata.map((e) => e['specialityTitle']??'').join(' , ');
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        athleteapproveController.AthleteapproveApi(context, widget.data['user']['id'], Approvalstatus);
                        getallAthleteController.GetallathleteApi(context);
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
                  child: Text("Athlete Profile",style: profiletxtheadwhite,),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Gender : ",style:profiletxtheadtxt ,),
                    Text(widget.data['gender']??'',style:profiletxtheadsubtxt ,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Row(
                    children: [
                      Text("Age : ",style:profiletxtheadtxt ,),
                      Text(widget.data['age']??'',style:profiletxtheadsubtxt ,),
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
                Text("Current School  ",style:profiletxtheadtxt ,),
                HtmlWidget('''
                                ${widget.data['school']??''}
                                ''',textStyle: profiletxtheadsubtxt,)

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Current Club & Academy",style:profiletxtheadtxt ,),
                HtmlWidget('''
                                ${widget.data['currentAcademie']??''}
                                ''',textStyle: profiletxtheadsubtxt,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("City : ",style:profiletxtheadtxt ,),
                Text(widget.data['cityData']['name']??"",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("State : ",style:profiletxtheadtxt ,),
                Text(widget.data['stateData']['name']??"",style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Athlete Bio",style:profiletxtheadtxt ,),
                HtmlWidget('''
                                 ${widget.data['bio']??''}
                                ''',textStyle:profiletxtheadsubtxt ,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("X profile Link : ",style:profiletxtheadtxt ,),
                Text(widget.data['twitterLink']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("IG profile Link : ",style:profiletxtheadtxt ,),
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
                  child: Text("Athlete Achievements ",style: profiletxtheadwhite,),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Achievement ",style:profiletxtheadtxt ,),
                HtmlWidget('''
                                  ${widget.data['achievements']??''}
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
                Text("Speciality Position  ",style:profiletxtheadtxt ,),
                Text(specialityessata??'',style:profiletxtheadsubtxt ,),
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
                  child: Text("Parents Profile",style: profiletxtheadwhite,),
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
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text("First Name",style:profiletxtheadtxt ,),
                    Text(widget.data['parentFirstName']??'',style:profiletxtheadsubtxt ,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: [
                    Text("Last Name",style:profiletxtheadtxt ,),
                    Text(widget.data['parentLastName']??'',style:profiletxtheadsubtxt ,),
                  ],
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Email : ",style:profiletxtheadtxt ,),
                Text(widget.data['user']['email']??'',style:profiletxtheadsubtxt ,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Mobile Number : ",style:profiletxtheadtxt ,),
                Text(widget.data['parentPhone']??'',style:profiletxtheadsubtxt ,),
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
                  child: Text("Headshot Images",style: profiletxtheadwhite,),
                )),
          ),
          SizedBox(
          height: displayheight(context)*0.16,
          child: gallerydata.isEmpty?
              Center(child: Text("No Headshot Images Found.",style: viewtxt,),)
              :ListView.builder(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: gallerydata.length,
              itemBuilder: (BuildContext context,int index){
                var imageurl=gallerydata[index]['fileLocation'];
               return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network("$imageurl",height: displayheight(context)*0.15,width: displaywidth(context)*0.30,fit: BoxFit.cover,)),
            );
           }),
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
                  child: Text("Headshot  Videos",style: profiletxtheadwhite,),
                )),
          ),
          SizedBox(
            height: displayheight(context)*0.16,
            child: galleryvideos.isEmpty?
            Center(child: Text("No Headshot Videos Found.",style: viewtxt,),)
                :ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: galleryvideos.length,
                itemBuilder: (BuildContext context,int index){
                  var videourl=galleryvideos[index]['fileLocation'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: displayheight(context)*0.15,
                            width: displaywidth(context)*0.30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(child: Icon(Icons.slow_motion_video_rounded,color: Colors.white,),),
                  )
                  )
                  );
                }),
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

    Widget editathletereport(){
      List speciality = specialitylistController.specialitydata.map((item) =>(item['specialityTitle'].toString())).toList();
      List defaultspeciality=widget.data['specialities'].toList()??[];
      List specialitydata = defaultspeciality.map((e) => e['specialityTitle']).toList();
      var sportdatalist=getall_sport_controller.getsportdata.map((element) => element['sportName']).toList();
      List getsportdata=widget.data['sports']??[];
      List defaultsportdata=getsportdata.map((element) => element['sportName']).toList();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
                          width: displaywidth(context)*0.40,
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
                          width: displaywidth(context)*0.40,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Athlete Residential State  ",style: inputtxt,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:2.0,vertical: 4.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Athlete Residential City  ",style: inputtxt,),
                  ),
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
                      initiallySelected:defaultsportdata,
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
                      initiallySelected:specialitydata,
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
                              width: displaywidth(context)*0.40,
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
                                        borderSide: BorderSide(color: textfieldcolor),
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
                              width: displaywidth(context)*0.40,
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
              ],
            ),

          ],
        ),
      ),
    );
    }

  delete(int id){
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Delete the Athlete Profile.",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            setState(() {
              Get.back();
              deleteAthleteController.DeleteathleteApi(context, id);
              getallAthleteController.GetallathleteApi(context);
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
