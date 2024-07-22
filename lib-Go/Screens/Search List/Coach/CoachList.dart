import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Screens/Search%20List/Coach/Coach%20View.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/Search%20service/Coach%20search.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachListscreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  CoachListscreen({super.key, required this.data});

  @override
  State<CoachListscreen> createState() => _CoachListscreenState();
}

class _CoachListscreenState extends State<CoachListscreen> {

  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();

  @override
  void initState() {
    getallfavourite_controller.Getfavourite_Api(context, "3");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Coach List"),
      body: Column(
        children: [
          Container(
            height: displayheight(context)*0.07,
            decoration: const BoxDecoration(
              color: newyellow,
            ),

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
                      child: Text("Coach Name",style:searchbtntxt,)),
                  SizedBox(
                      width: displaywidth(context)*0.30,
                      child: Text("",style:searchbtntxt,))
                ],
              ),
            ),
          ),
          Expanded(
            child: widget.data.isEmpty?
            Center(child: Text("No Profile Found",style: profiletxtheadtxt,))
                :Obx(() {
              return RefreshIndicator(
                backgroundColor: Colors.white,
                color: newyellow,
                onRefresh: () async {
                  await widget.data;
                },
                child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var coachdata = widget.data[index];
                      List gallerydata = widget
                          .data[index]['user']['galleries'] ?? [];
                      var profileimage = gallerydata.firstWhere((
                          element) => element['fileType'] == "Profile Image",
                        orElse: () => {'fileLocation': ''},)['fileLocation'];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(
                                0.05000000074505806))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              gallerydata.isEmpty ? const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                child: Center(
                                  child: Icon(
                                    Icons.person, color: Colors.white,),
                                ),
                              ) :
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "$profileimage"),),
                              Text("${coachdata['user']['firstName']}",
                                style: chatnametxt,),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFE4E4FF)),
                                  onPressed: () {
                                    Map<String, dynamic> coachdatas = widget
                                        .data[index];
                                    Get.to(CoachViewscreen(data: coachdatas));
                                  }, child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("View Details", style: viewbtntxt,),
                              ))
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
    )
          )
        ],
      ),
    );
  }
}