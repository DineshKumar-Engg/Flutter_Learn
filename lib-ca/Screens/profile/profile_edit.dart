import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:connect_athlete_admin/Screens/profile/EditprofileController.dart';
import 'package:connect_athlete_admin/Screens/profile/GetprofiileController.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/snackbar.dart';

class Profile_edit_screen extends StatefulWidget {
  const Profile_edit_screen({super.key});

  @override
  State<Profile_edit_screen> createState() => _Profile_edit_screenState();
}

class _Profile_edit_screenState extends State<Profile_edit_screen> {

  final GetProfileController getProfileController=Get.find<GetProfileController>();
  final EditprofileController editprofileController=Get.find<EditprofileController>();

  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();

  String?token,adminimage;
  int?userid,imageid;
  XFile?file;
  String?filetype;
  final picker=ImagePicker();
  String?base64String;

  Future<void> pickimage() async {
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

      adminimage==null?uploadFile(compressedImageBytes, filename):updateFile(compressedImageBytes, filename);
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
        "fileType": "admin Profile",
        "ImageType":"image/$filetype",
        "isApproved": "Approved",
        "userId": userid
      }),
    );
    if (response.statusCode == 200) {
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

    var getid = shref.getInt('userid');
    userid = getid??0;

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
        "fileType": "admin Profile",
        "ImageType":"image/$filetype",
        "isApproved": "Approved",
        "userId": userid,
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
 getProfileController.GetProfileApi(context);
  super.initState();
  firstnamecontroller.text=getProfileController.getprofiledata[0]['firstName'];
  lastnamecontroller.text=getProfileController.getprofiledata[0]['lastName'];
  emailcontroller.text=getProfileController.getprofiledata[0]['email'];

  }
  @override
  Widget build(BuildContext context) {
    List getimage=getProfileController.getprofiledata[0]['galleries'];
    var profileimage=getimage.firstWhere((element)=>element['fileType']=="admin Profile",orElse: ()=>{'fileLocation':''})['fileLocation'];
    adminimage=profileimage??'';
    var profileimageid=getimage.firstWhere((element)=>element['fileType']=="admin Profile",orElse: ()=>{'id':''})['id'];
    imageid=profileimageid??'';
    print(profileimageid);
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Admin Profile"),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
              child: Padding(
                padding:const EdgeInsets.only(top:50.0,bottom: 20.0),
                child: InkWell(
                  onTap: (){
                    pickimage();
                  },
                  child: file==null?CircleAvatar(
                    radius: 70,
                    backgroundColor:Colors.grey,
                    backgroundImage: NetworkImage("$adminimage"),
                ):SizedBox(
                    height: 150,
                    width: 150,
                    child:ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(File(file!.path),fit: BoxFit.cover,))
                ),
              )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("First Name",style: subscriptiontxt,),
            ),
            common_textfield(firstnamecontroller, "", TextInputType.name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Last Name",style: subscriptiontxt,),
            ),
            common_textfield(lastnamecontroller, "", TextInputType.name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Email ID",style: subscriptiontxt,),
            ),
            common_textfield(emailcontroller, "", TextInputType.emailAddress),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: displayheight(context)*0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor:secondary,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )),
                  onPressed: (){
                   editprofileController.EditprofileApi(context, firstnamecontroller.text, lastnamecontroller.text, emailcontroller.text);
                  },child: Center(child: Text("Update",style: btntxtwhite,),),
                ) ,
              ),
            )

          ],
        ),
      ),
    );
  }
}
