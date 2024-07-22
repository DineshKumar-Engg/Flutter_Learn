import 'package:connect_athelete/Screens/Favourite%20List/Athlete/Favourite_Athlete_View.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';

class Favourite_athlete_list_screen extends StatefulWidget {
  List<Map<String, dynamic>> data;
  Favourite_athlete_list_screen({super.key, required this.data});

  @override
  State<Favourite_athlete_list_screen> createState() => _Favourite_athlete_list_screenState();
}

class _Favourite_athlete_list_screenState extends State<Favourite_athlete_list_screen> {
  final Getallfavourite_Controller getallfavourite_controller = Get.find<Getallfavourite_Controller>();

  getallfavouritedata(BuildContext context)async{
    await getallfavourite_controller.Getfavourite_Api(context, "2");
  }
  @override
  void initState() {
    super.initState();
    getallfavouritedata(context);
    getallfavourite_controller.Getfavourite_Api(context, "2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Favourite Athletes"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: newyellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: displaywidth(context) * 0.25,
                            child: Text("Profile", style: searchbtntxt,)),
                        SizedBox(
                            width: displaywidth(context) * 0.30,
                            child: Text("Athlete Name", style: searchbtntxt,)),
                        SizedBox(
                            width: displaywidth(context) * 0.30,
                            child: Text("", style: searchbtntxt,))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (getallfavourite_controller.getallfavouritedata.isEmpty) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return RefreshIndicator(
                  backgroundColor:primary,
                  color: Colors.white,
                  onRefresh: () async {
                    await getallfavourite_controller.Getfavourite_Api(context, "2");
                    getallfavouritedata(context);
                  },
                  child: ListView.builder(
                    itemCount: getallfavourite_controller.getallfavouritedata.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = getallfavourite_controller.getallfavouritedata[index];
                      List favouritegetdata = widget.data[index]['galleryData'] ?? '';
                      var gallerydata = favouritegetdata.firstWhere(
                              (element) => element['fileType'] == "Profile Image",
                          orElse: () => {'fileLocation': ''})['fileLocation'];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.05000000074505806))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              gallerydata == null ? const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                child: Center(
                                  child: Icon(Icons.person, color: Colors.white,),
                                ),
                              ) : CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(gallerydata),
                              ),
                              Text(data['favoriteUserData']['firstName'], style: chatnametxt,),
                              TextButton(
                                  style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                                  onPressed: () {
                                    Map<String, dynamic> data = widget.data[index];
                                    Get.to(Favourite_Athlete_View(data: data));
                                  }, child: Text("View Details", style: viewbtntxt,))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
