import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';
import 'ClubView.dart';

class ClubListscreen extends StatefulWidget {
  final List<Map<String,dynamic>> data;
   ClubListscreen({super.key,required this.data});

  @override
  State<ClubListscreen> createState() => _ClubListscreenState();
}

class _ClubListscreenState extends State<ClubListscreen> {

  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  @override
  void initState() {
    getallfavourite_controller.Getfavourite_Api(context, 4);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Clubs List"),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: newyellow,
            ),
            height: displayheight(context)*0.08,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: displaywidth(context)*0.25,
                      child: Text("Profile",style:searchbtntxt,)),
                  SizedBox(
                      width: displaywidth(context)*0.30,
                      child: Text("Clubs Name",style:searchbtntxt,)),
                  SizedBox(
                      width: displaywidth(context)*0.30,
                      child: Text("",style:searchbtntxt,))
                ],
              ),
            ),
          ),
          Expanded(
            // height: displayheight(context)*0.80,
            child: widget.data.isEmpty? Center(child: Text("No Profile Found",style: profiletxtheadtxt,),):ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context,int index){
                  List gallerydata=widget.data[index]['user']['galleries']??[];
                  var profileimage=gallerydata.firstWhere((element) => element['fileType']=="Profile Image",orElse: () => {'fileLocation': ''},)['fileLocation'];
                  return Container(
                    // height: displayheight(context)*0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          gallerydata.isEmpty? const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            child: Center(
                              child: Icon(Icons.person,color: Colors.white,),
                            ),
                          ):
                          CircleAvatar(
                            radius:30,
                            backgroundImage: NetworkImage("$profileimage"),),
                          Text(widget.data[index]['academieName']??'',style: chatnametxt,),
                          TextButton(
                              style: TextButton.styleFrom(backgroundColor:const  Color(0xFFE4E4FF)),
                              onPressed: (){
                                Map<String,dynamic> data=widget.data[index];
                                Get.to( ClubViewscreen(data:data));
                              }, child: Text("View Details",style: viewbtntxt,))
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
