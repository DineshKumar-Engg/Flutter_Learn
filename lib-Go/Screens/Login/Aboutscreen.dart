import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:connect_athelete/widget/Backbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Common/Commonbackground.dart';
import '../Registration screens/Athlete Registration/Athelete screen.dart';
import '../Registration screens/Club Registration/Clubs screen.dart';
import '../Registration screens/Coach Registration/Coach screen.dart';

class Aboutscreen extends StatefulWidget {
  String route;
   Aboutscreen({super.key,required this.route});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  final SettingController settingController=Get.find<SettingController>();

  @override
  void initState() {
    settingController.SettingApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,top: 55.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:newyellow,
                        child: Center(
                          child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(left:40.0),
                        child: Image.asset("assets/logo/logowhite.png",height: displayheight(context)*0.15,color: newyellow, ),
                      )),
                    ),
                  ],
                ),

                Container(
                  height: displayheight(context)*0.60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Introduction",style: primaryheading,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                             child: HtmlWidget('''
                             ${settingController.settingdata[0]['appIntroduction']??''}
                             ''',textStyle: chatnametxt,),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(onPressed: (){
                                widget.route=='Athlete'?
                                 Get.to(const Atheletescreen()):
                                widget.route=='Clubs'?
                               Get.to(const Clubsscreen()) :
                                widget.route=='Coach'?
                                Get.to(const Coachscreen()) :
                                    Aboutscreen(route: "");
                              }, child: Text("Skip",style: skiptxt,))),
                        )


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
