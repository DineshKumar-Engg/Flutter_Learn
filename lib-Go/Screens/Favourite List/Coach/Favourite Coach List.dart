import 'package:connect_athelete/Screens/Favourite%20List/Coach/Favourite_Coach_View.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';

class Favoritecoachscreen extends StatefulWidget {
  const Favoritecoachscreen({super.key});

  @override
  State<Favoritecoachscreen> createState() => _FavoritecoachscreenState();
}

class _FavoritecoachscreenState extends State<Favoritecoachscreen> {

  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();

  getallfavouritedata(BuildContext context)async{
    await getallfavourite_controller.Getfavourite_Api(context, "3");
  }
  @override
  void initState() {
  getallfavourite_controller.Getfavourite_Api(context, "3") ;
  getallfavouritedata(context);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Favourite Coaches"),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: displayheight(context)*0.07,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              ),
            ),
            Expanded(
              child:Obx(() {
                if (getallfavourite_controller.getallfavouritedata.isEmpty) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return RefreshIndicator(
                  backgroundColor:primary,
                  color: Colors.white,
                  onRefresh: () async {
                   await getallfavourite_controller.Getfavourite_Api(context, 3);
                     getallfavouritedata(context);
                  },
                  child: ListView.builder(
                      itemCount: getallfavourite_controller.getallfavouritedata
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = getallfavourite_controller
                            .getallfavouritedata[index];
                        List favouritegetdata = getallfavourite_controller
                            .getallfavouritedata[index]['galleryData'] ?? '';
                        var gallerydata = favouritegetdata.firstWhere((
                            element) => element['fileType'] == "Profile Image",
                            orElse: () => {'fileLocation': ''})['fileLocation'];
                        return Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(
                                      0.05000000074505806))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                gallerydata == null ? const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.person, color: Colors.white,),
                                  ),
                                ) : CircleAvatar(
                                  radius: 30,
                                  // child: Image.network(gallerydata),
                                  backgroundImage: NetworkImage(gallerydata),
                                ),
                                Text(
                                  data['favoriteUserData']['firstName'] ?? '',
                                  style: chatnametxt,),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFE4E4FF)),
                                    onPressed: () {
                                      Map<String,
                                          dynamic> data = getallfavourite_controller
                                          .getallfavouritedata[index];
                                      Get.to(Favourite_coach_View(data: data,));
                                    },
                                    child: Text(
                                      "View Details", style: viewbtntxt,))
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              ),
            )
          ],
        ),
      ),
    );
  }
}
