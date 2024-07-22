import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Services/CMS%20Service/Terms_api.dart';
import 'package:connect_athelete/widget/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../Common/Common Textstyle.dart';

class Termscreen extends StatefulWidget {
  const Termscreen({super.key});

  @override
  State<Termscreen> createState() => _TermscreenState();
}

class _TermscreenState extends State<Termscreen> {

  final CMSTermsController cmsTermsController=Get.find<CMSTermsController>();

  @override
  void initState() {
cmsTermsController.cmstermsapi(context);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.only(top:45.0),
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
                        child: Center(child: Text("Terms & Conditions",style:paymenttitle ,),)
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
                            ${cmsTermsController.cmstermsdata[0]['content']}
                            ''',textStyle: signuptxt,)
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
