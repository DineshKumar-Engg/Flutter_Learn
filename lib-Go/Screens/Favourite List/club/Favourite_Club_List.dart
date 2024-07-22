import 'package:connect_athelete/Screens/Favourite%20List/club/Favourite_club_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Services/Favourite/getclub_favourite_list.dart';
import '../../../widget/Appbar.dart';

class Favourite_Club_List extends StatefulWidget {
  const Favourite_Club_List({super.key});

  @override
  State<Favourite_Club_List> createState() => _Favourite_Club_ListState();
}

class _Favourite_Club_ListState extends State<Favourite_Club_List> {

  final GetClubfavourite_Controller getClubfavourite_Controller=Get.find<GetClubfavourite_Controller>();

  @override
  void initState() {
    getClubfavourite_Controller.GetClubfavourite_Api(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Favourite Club & Academy's"),
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
                            child: Text("Club Name",style:searchbtntxt,)),
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
               if (getClubfavourite_Controller.getclubfavouritedata.isEmpty) {
                 return const Center(child: CupertinoActivityIndicator());
               }
               return RefreshIndicator(
                 backgroundColor:primary,
                 color: Colors.white,
                 onRefresh: () async {
                   await getClubfavourite_Controller.GetClubfavourite_Api(context);
                 },
                 child: ListView.builder(
                     itemCount: getClubfavourite_Controller.getclubfavouritedata
                         .length,
                     itemBuilder: (BuildContext context, int index) {
                       var data = getClubfavourite_Controller
                           .getclubfavouritedata[index];
                       List favouritegetdata = getClubfavourite_Controller
                           .getclubfavouritedata[index]['galleryData'] ?? '';
                       var gallerydata = favouritegetdata.firstWhere((
                           element) => element['fileType'] == "Profile Image",
                           orElse: () => {'fileLocation': ''})['fileLocation'];
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
                               gallerydata == null ? const CircleAvatar(
                                 radius: 30,
                                 backgroundColor: Colors.grey,
                                 child: Center(
                                   child: Icon(
                                     Icons.person, color: Colors.white,),
                                 ),
                               ) : CircleAvatar(
                                 radius: 30,
                                 backgroundImage: NetworkImage(gallerydata),
                               ),
                               Text(data['favoriteUserData']['firstName'] ?? '',
                                 style: chatnametxt,),
                               TextButton(
                                   style: TextButton.styleFrom(
                                       backgroundColor: const Color(
                                           0xFFE4E4FF)),
                                   onPressed: () {
                                     Map<String,
                                         dynamic> data = getClubfavourite_Controller
                                         .getclubfavouritedata[index];
                                     Get.to(Favourite_club_view(data: data,));
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
