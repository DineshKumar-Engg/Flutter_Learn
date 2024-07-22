import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Screens/Athlete/View%20Video.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import '../../Common/Common Color.dart';
import 'package:get/get.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Upload Image/DeleteimageController.dart';
import '../../widget/Snackbar.dart';


class Videouploadscreen extends StatefulWidget {
  const Videouploadscreen({super.key});

  @override
  State<Videouploadscreen> createState() => _VideouploadscreenState();
}

class _VideouploadscreenState extends State<Videouploadscreen> {

  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();
  final Deleteimagecontroller deleteimagecontroller=Get.find<Deleteimagecontroller>();


  List<String?> imageUrls = [];
  String token = '';
  int? userid;
  String? filetype;
  List<File?> selectedImages = [];

  void printInChunks(Uint8List data, {int chunkSize = 1024}) {
    for (int i = 0; i < data.length; i += chunkSize) {
      int end = (i + chunkSize < data.length) ? i + chunkSize : data.length;
      print(data.sublist(i, end));
    }
  }
  Future<void> imagePicker() async {
    if (imageUrls.length >= 3) {
      StackDialog.show("Image Exceed", "Only 3 Images Allowed", Icons.video_collection_rounded, primary);
      print("Maximum limit of images reached");
      return;
    }

    final returnedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (returnedVideo == null) {
      print("No video picked");
      return;
    }

    final videoFile = File(returnedVideo.path);
    final videoPlayerController = VideoPlayerController.file(videoFile);
    await videoPlayerController.initialize();
    final videoDuration = videoPlayerController.value.duration;

    if (videoDuration > const Duration(seconds: 30)) {
      StackDialog.show("Video Too Long", "Only videos up to 30 seconds are allowed", Icons.warning, Colors.red);
      print("Selected video exceeds the maximum duration of 30 seconds");
      return;
    }

    // Compress the video
    final compressedVideo = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false, // Keep the original file
    );

    if (compressedVideo == null) {
      print("Video compression failed");
      return;
    }

    final compressedVideoFile = File(compressedVideo.path!);

    setState(() {
      selectedImages.add(compressedVideoFile);
    });

    if (selectedImages.last != null) {
      List<int> videoBytes = await selectedImages.last!.readAsBytes();
      String filename = returnedVideo.path.split('/').last;

      uploadFile(videoBytes, filename);
      printInChunks(Uint8List.fromList(videoBytes));

      // print(filename);

      // Check and print the video format
      if (filename.toLowerCase().endsWith('.mp4')) {
        filetype = "mp4";
      } else if (filename.toLowerCase().endsWith('.mov')) {
        filetype = "mov";
      } else {
        // print('The selected video format is unknown');
      }
    } else {
      // print("Video not selected");
    }
  }

  Future<void> uploadFile(videobytes, String name) async {
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var gettoken = shref.getString('token');
    token = gettoken ?? '';

    var getid = shref.getInt('userid');
    userid = (getid ?? '') as int;


    final fileData = {"buffer": videobytes, "originalname": "$name"};
    final fileLocation = json.encode(fileData);

    // print("fileLocation: $fileLocation");

    final url = 'https://api.engageathlete.com/api/v1/upload-singlefiletest';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "$token"
      },
      body: json.encode({
        "fileLocation": "$fileLocation",
        "isActive": true,
        "description": "Athlete Headshot Video",
        "fileType": "Headshot Video",
        "ImageType": "video/$filetype",
        "isApproved": "Approved",
        "userId": userid
      }),
    );

    if (response.statusCode == 201) {
      print('Video uploaded successfully');
      StackDialog.show("Successfully Uploaded", "Video Uploaded Successfully", Icons.verified, Colors.green);
    } else {
      StackDialog.show("Failed to Upload File", "Video Not Uploaded", Icons.info, Colors.red);
      print('Failed to upload file: ${response.statusCode}');
    }
  }


  @override
  void initState() {
    super.initState();
    profiledetailsController.ProfiledetailsApi(context);
  }

  @override
  Widget build(BuildContext context) {
    List headshotVideos = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Video').map((item) => item['fileLocation']).toList();
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Images"),
      body: SingleChildScrollView(
        child: Obx(
              ()=> Column(
                children: [
                  headshotVideos.length!=3?
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
                          child: Text("Upload Videos Upto 250 MB Here",style: mediatxt,),
                        )
                      ],
                    ),

                  ):const SizedBox(),
                  Headshotimagedata(),
                ],
              ),
        ),
      ),
    );
  }


  Headshotimagedata(){
    List headshotImagesid = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Video').map((item) => item['id']).toList();
    List headshotImages = profiledetailsController.profiledata[0]['galleryData'].where((item) => item['fileType'] == 'Headshot Video').map((item) => item['fileLocation']).toList();
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
                        Get.to(Viewvideoscreen(
                            image: headshotImages[index]));
                      },
                      child: Container(
                        height: displayheight(context) * 0.15,
                        width: displaywidth(context) * 0.35,
                       decoration: BoxDecoration(
                         color: Colors.black,
                         borderRadius: BorderRadius.circular(10),
                       ),
                        child: const Center(child: Icon(Icons.slow_motion_video_sharp,color: Colors.white,size:40,)),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "File Name : Headshot Video ${index + 1}",
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
          child: Text("Are you sure want to Delete this Video",style:inputtxt,textAlign: TextAlign.center,),
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
