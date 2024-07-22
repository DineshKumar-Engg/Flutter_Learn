import 'package:connect_athelete/Services/CMS%20Service/parent_contest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Common/Commonbackground.dart';
import '../../widget/Container.dart';

class Parent_Contest_screen extends StatefulWidget {
  const Parent_Contest_screen({super.key});

  @override
  State<Parent_Contest_screen> createState() => _Parent_Contest_screenState();
}

class _Parent_Contest_screenState extends State<Parent_Contest_screen> {

  final CMSParentcontestController cmsParentcontestController=Get.find<CMSParentcontestController>();

  @override
  void initState() {
cmsParentcontestController.cmsparentcontestapi(context);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: newyellow,
                        child: Center(
                          child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Parent Contest",style:paymenttitle ,),)
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
                commoncontainer(displayheight(context)*0.85,
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: HtmlWidget('''
                          ${cmsParentcontestController.cmsparentcontestdata[0]['content']??''}
                            '''),
                          )
                      
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
