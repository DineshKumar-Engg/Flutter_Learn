import 'dart:convert';
import 'dart:io';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/Services/Upload%20Image/DeleteimageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart'as http;
import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Screens/Athlete/View%20Image.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';

class Imageuploadscreen extends StatefulWidget {
  const Imageuploadscreen({super.key});

  @override
  State<Imageuploadscreen> createState() => _ImageuploadscreenState();
}

class _ImageuploadscreenState extends State<Imageuploadscreen> {
  
  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();
  final Deleteimagecontroller deleteimagecontroller=Get.find<Deleteimagecontroller>();

  List<String?> imageUrls = [];
  String token = '';
  int?userid;
  String ?filetype;
  List<File?> selectedImages = [];

  Future<void> imagePicker() async {
    if (imageUrls.length >= 3) {
      StackDialog.show("Image Exceed", "Only 3 Images Allowed", Icons.image, primary);
      print("Maximum limit of images reached");
      return;
    }

    final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (returnedImage == null) {
      print("No image picked");
      return;
    }

    setState(() {
      selectedImages.add(File(returnedImage.path));
    });

    if (selectedImages.last != null) {
      List<int> imageBytes = await selectedImages.last!.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);
      List<int> compressedImageBytes = img.encodeJpg(image!, quality: 50);
      String filename = returnedImage!.path.split('/').last;

      uploadFile(compressedImageBytes, filename);

      // Check and print the image format
      if (filename.toLowerCase().endsWith('.png')) {
        print('The selected image is in PNG format');
        filetype = "png";
        print(filetype);
      } else if (filename.toLowerCase().endsWith('.jpg')) {
        print('The selected image is in JPG format');
        filetype = "jpg";
        print(filetype);
      }
      else if (filename.toLowerCase().endsWith('.jpeg')) {
        filetype = "jpeg";
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
        "description": "Athlete Headshot Images",
        "fileType": "Headshot Image",
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
      await profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Image').map((item) => item['fileLocation']).toList();
    } else {
      print(fileLocation);
      StackDialog.show("File to Upload File", "Image Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    profiledetailsController.ProfiledetailsApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List headshotImages = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Image').map((item) => item['fileLocation']).toList();
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Images"),
      body: SingleChildScrollView(
        child: Obx(
            ()=> RefreshIndicator(
              backgroundColor: primary,
              color: Colors.white,
              onRefresh: ()async{
                await profiledetailsController.ProfiledetailsApi(context);
              },
              child: Column(
              children: [
                headshotImages.length!=3?
                 SizedBox(
                  height: displayheight(context)*0.30,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()async{
                         imagePicker();
                        },
                        child: Container(
                          height: displayheight(context)*0.12,
                          width: displaywidth(context)*0.25,
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Center(
                            child: Icon(Icons.upload,color: Color(0XFFECAC1A),size: 50,),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Upload Image Here",style: mediatxt,),
                      )
                    ],
                  ),

                ):const SizedBox(),
                Headshotimagedata(),
              ],
                        ),
            ),
        ),
      ),
    );
  }


  Headshotimagedata(){
    List headshotImagesid = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Image').map((item) => item['id']).toList();
    List headshotImages = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Image').map((item) => item['fileLocation']).toList();
    return RefreshIndicator(
      backgroundColor:primary,
      color: Colors.white,
      onRefresh: ()async{
        await profiledetailsController.ProfiledetailsApi(context);
      },
      child: SizedBox(
        height: displayheight(context) * 0.56,
        width: double.infinity,
        child: ListView.builder(
          itemCount: headshotImages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: displayheight(context) * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(ViewImagescreen(
                            image: headshotImages[index]));
                      },
                      child: SizedBox(
                        height: displayheight(context) * 0.15,
                        width: displaywidth(context) * 0.35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(headshotImages[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "File Name : Headshot Image ${index + 1}",
                          style: imagetxt,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        removeimage(headshotImagesid[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFFA0A0A0),
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  removeimage(id){
    return showDialog(
        context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: const Icon(CupertinoIcons.delete,color: Colors.red,size: 40,),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 12.0),
          child: Text("Are you sure want to Delete this Image",style:inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(
              onPressed: ()async{
                deleteimagecontroller.DeleteimageApi(context, id);
                await profiledetailsController.ProfiledetailsApi(context);
                Get.back();
              }, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Yes",style: inputtxt,),
              )),
          CupertinoButton(
              onPressed: (){
                Navigator.pop(context);
              }, child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
               child: Text("No",style: inputtxt,),
          ))

        ],
      );
    });
  }
}
