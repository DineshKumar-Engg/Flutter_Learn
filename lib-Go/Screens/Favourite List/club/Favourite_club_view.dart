import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/getclub_favourite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Services/Favourite/Favourite_list.dart';
import '../../../Services/Favourite/delete_Favourite.dart';
import '../../../widget/Appbar.dart';
import '../../../widget/Redirect Link.dart';
import '../../Athlete/Chat screen.dart';

class Favourite_club_view extends StatefulWidget {
  Map<String,dynamic> data;
   Favourite_club_view({super.key,required this.data});

  @override
  State<Favourite_club_view> createState() => _Favourite_club_viewState();
}

class _Favourite_club_viewState extends State<Favourite_club_view> {
  final Deletefavourite_Controller deletefavourite_controller=Get.find<Deletefavourite_Controller>();
  final Favourite_add_Controller favourite_add_controller=Get.find<Favourite_add_Controller>();
  final GetClubfavourite_Controller getClubfavourite_Controller=Get.find<GetClubfavourite_Controller>();
  bool like=false;
  @override
  Widget build(BuildContext context) {
    List getprofiledata=widget.data['profileData'];
    var profiledata=getprofiledata[0];
    List gallerydata = widget.data['galleryData'] ?? [];
    var profileimage = gallerydata.firstWhere((element) => element['fileType'] == "Profile Image", orElse: () => {'fileLocation': ''},)['fileLocation'];
    List getstatedata=widget.data['stateData']??[];
    var statedata=getstatedata.map((e) => e['name']).join(' , ');
    List getcitydata=widget.data['citiesData']??[];
    var citydata=getcitydata.map((e) => e['name']).join(' , ');
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Club & Academy Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration:commonshadow20,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gallerydata.isEmpty
                                  ? const
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Center(child: Icon(Icons.person,color: Colors.white,),),
                              )
                                  :CircleAvatar(
                                radius:60,
                                backgroundImage: NetworkImage(profileimage),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: commonshadow,
                                        child:IconButton(onPressed: (){
                                          setState(() {
                                            deletefavourite_controller.Deletefavourite_Api(context, widget.data['favorite']['id']);
                                            like=!like;
                                            getClubfavourite_Controller.GetClubfavourite_Api(context);
                                          });
                                        },icon: Icon(Icons.favorite,
                                            color:like?Colors.grey.shade200:Colors.red),) ,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF009719),shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )),
                                    onPressed: (){
                                      Get.to(Chatscreen(
                                          name: widget.data['favoriteUserData']['firstName']??'',
                                          id: widget.data['favoriteUserData']['id']??0,
                                          image:profileimage,
                                          email:widget.data['favoriteUserData']['email']??''
                                      ));
                                    },child: Text("Chat",style: searchbtntxt,),)
                                ],
                              )

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Coach Information ",style: profiletxthead,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("First Name",style: profiletxtnew,),
                                  Text(widget.data['favoriteUserData']['firstName']??'',style: coachviewtxt,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Last Name",style: profiletxtnew,),
                                  Text(widget.data['favoriteUserData']['lastName']??'',style: coachviewtxt,)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email ID",style: profiletxtnew,),
                              Text(widget.data['favoriteUserData']['email']??'',style: coachviewtxt,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone Number",style: profiletxtnew,),
                              Text(profiledata['phone']??'',style: coachviewtxt,)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Speciality ",style: profiletxtnew,),
                              Text('',style: coachviewtxt,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sports",style: profiletxtnew,),
                              Text('',style: coachviewtxt,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Coaching Information ",style: profiletxthead,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ages We Coaching ",style: profiletxtnew,),
                              Text(profiledata['ageYouCoach']??'',style: coachviewtxt,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender We Coaching ",style: profiletxtnew,),
                              Text(profiledata['genderYouCoach']??'',style: coachviewtxt,)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("City We Coaching",style: profiletxtnew,),
                              Text(citydata,style: coachviewtxt,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State We Coaching",style: profiletxtnew,),
                              Text(statedata,style: coachviewtxt,)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Coach Bio ",style: profiletxthead,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bio",style: profiletxtnew,),
                              HtmlWidget('''
                              ${profiledata['bio']??''}
                              ''',textStyle:coachviewtxt)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("What Are You Looking For",style: profiletxtnew,),
                              HtmlWidget('''
                              ${profiledata['lookingFor']??''}
                              ''',textStyle:coachviewtxt)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Social Media Links ",style: profiletxthead,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Website Link",style: profiletxtnew,),
                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child:  Row(
                                    children: [
                                      Image.asset("assets/Media/weblink.png",height: 18,width: 18,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child:  InkWell(
                                            onTap: (){
                                              urllauncher(profiledata['websiteLink']??'');
                                            },
                                            child: Text(profiledata['websiteLink']??'',style: linkbtntxt,))
                                      ),
                                    ],
                                  ),


                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("X Profile Link",style: profiletxtnew,),
                              Row(
                                children: [
                                  Image.asset("assets/Media/xlink.png",height: 18,width: 18,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: InkWell(
                                        onTap: (){
                                          urllauncher(profiledata['twitterLink']??'');
                                        },
                                        child: Text(profiledata['twitterLink']??'',style: linkbtntxt,)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("IG Profile Link",style: profiletxtnew,),
                              Row(
                                children: [
                                  Image.asset("assets/Media/iglink.png",height: 18,width: 18,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: InkWell(
                                        onTap: (){
                                          urllauncher(profiledata['instagramLink']??'');
                                        },
                                        child: Text(profiledata['instagramLink']??'',style: linkbtntxt,)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text("Youtube video Link",style: profiletxtnew,),
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //         child: Row(
                        //           children: [
                        //             Image.asset("assets/img_12.png",height: 15,width: 15,),
                        //             Padding(
                        //               padding: const EdgeInsets.only(left:8.0),
                        //               child: InkWell(
                        //                   onTap: (){
                        //                     urllauncher("www.youtube.com");
                        //                   },
                        //                   child: Text("www.connectathletcoach.com",style: linkbtntxt,)),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
