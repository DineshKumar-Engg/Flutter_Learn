import 'dart:convert';
import 'dart:io';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Screens/Sport/addsport_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/common_textfield.dart';
import '../../Widget/elevation_button.dart';
import '../Home/home_screen.dart';

class add_sport extends StatefulWidget {
  const add_sport({super.key});

  @override
  State<add_sport> createState() => _add_sportState();
}

class _add_sportState extends State<add_sport> {

  final TextEditingController sportnamecontroller=TextEditingController();
  final TextEditingController sportdescriptioncontroller=TextEditingController();

  XFile?file;
  String?filetype,getimageurl;
  final picker=ImagePicker();
  String?base64String;

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

      // Extracting the file name
      String filename = file!.path.split('/').last;

      getimageurl=base64String??'';
      print(getimageurl);
      // uploadFile(compressedImageBytes, filename);

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

  final addsport_Controller addsport_controller=Get.find<addsport_Controller>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Add Sport"),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
              child: Padding(
                padding: const EdgeInsets.only(top:50.0,bottom: 20.0),
                child: InkWell(
                  onTap: (){
                    getimage();
                  },
                  child: file==null?
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 70,
                      )
                      :SizedBox(
                    height: 150,
                      width: 150,
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                          child: Image.file(File(file!.path),fit: BoxFit.cover,))                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Sport Name",style: subscriptiontxt,),
            ),
            common_textfield(sportnamecontroller, "", TextInputType.name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Sport Description",style: subscriptiontxt,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: inputtxt,
                maxLines: 3,
                maxLength: 500,
                cursorColor: Colors.black,
                controller: sportdescriptioncontroller,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: displayheight(context)*0.06,
                  width: displaywidth(context)*0.45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primary,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )),
                    onPressed: (){
                      if(sportnamecontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Sport Name", Icons.info, Colors.red);
                      }
                      else if(sportdescriptioncontroller.text.isEmpty){
                        StackDialog.show("Required Field is Empty", "Enter Sport Description", Icons.info, Colors.red);
                      }
                      else{
                        addsport_controller.AddSportApi(context, sportnamecontroller.text, sportdescriptioncontroller.text,getimageurl??'');
                        sportnamecontroller.text='';
                        sportdescriptioncontroller.text='';
                      }
                    },child: Center(child: Text("Submit",style: btntxtwhite,),),
                  ) ,
                ),
                SizedBox(
                  height: displayheight(context)*0.06,
                  width: displaywidth(context)*0.45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
                    onPressed: (){
                      Get.back();
                    },child: Center(child: Text("Cancel",style: btntxtred,),),
                  ) ,
                )

              ],
            )


          ],
        ),
      ),
    );
  }
}
