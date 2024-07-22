import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Services/CMS%20Service/cms_api.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class Aboutus_screen extends StatefulWidget {
  const Aboutus_screen({super.key});

  @override
  State<Aboutus_screen> createState() => _Aboutus_screenState();
}

class _Aboutus_screenState extends State<Aboutus_screen> {

  final CMSController cmsController=Get.find<CMSController>();
  @override
  void initState() {
    super.initState();
    cmsController.cmsapi(context,2);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarwidget("About Us"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(()=> Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget('''
             ${cmsController.cmsdata[1]['title']}
                  ''',textStyle: aboutclubtxt,),
                ),
                cmsController.cmsgallery.isEmpty?Container(): Image.network(cmsController.cmsgallery[1]['fileLocation']),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget('''
              ${cmsController.cmsdata[1]['shortDescription']}
                  ''',textStyle: inputtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget('''
              ${cmsController.cmsdata[1]['description']}
                  ''',textStyle: inputtxt,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
