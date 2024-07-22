import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/CMS Service/cms_api.dart';

class Howits_works_screen extends StatefulWidget {
  const Howits_works_screen({super.key});

  @override
  State<Howits_works_screen> createState() => _Howits_works_screenState();
}

class _Howits_works_screenState extends State<Howits_works_screen> {
  final CMSController cmsController=Get.find<CMSController>();
  @override
  void initState() {
    super.initState();
    cmsController.cmsapi(context,1);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarwidget("How Its Works"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cmsController.cmsdata.isEmpty?
        const Center(child: CupertinoActivityIndicator(),)
            :Obx(()=>
           cmsController.cmsdata.isEmpty?
           const Center(child: CupertinoActivityIndicator(),)
               :Column(
            children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: HtmlWidget('''
          // ${cmsController.cmsdata[4]['title']??''}
          //       ''',textStyle: aboutclubtxt,),
          //     ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget('''
            ${cmsController.cmsdata[4]['shortDescription']??''}
                ''',textStyle: inputtxt,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget('''
            ${cmsController.cmsdata[4]['description']??''}
                ''',textStyle: inputtxt,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
