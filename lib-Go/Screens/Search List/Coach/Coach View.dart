import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Screens/Athlete/Chat%20screen.dart';
import 'package:connect_athelete/Services/Favourite/Favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:connect_athelete/widget/Redirect%20Link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CoachViewscreen extends StatefulWidget {
  final Map<String,dynamic> data;

   CoachViewscreen({super.key,required this.data});

  @override
  State<CoachViewscreen> createState() => _CoachViewscreenState();
}

class _CoachViewscreenState extends State<CoachViewscreen> {

  final Favourite_add_Controller favourite_add_controller=Get.find<Favourite_add_Controller>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();

  bool like=false;
  void toggleSwitch() {
    setState(() {
      like = !like;
    });
  }

  @override
  Widget build(BuildContext context) {
    List statelist=widget.data['stateData'];
    var statedata=statelist.map((e) => e['name']).join(' , ');
    List citylist=widget.data['citiesData'];
    var citydata=citylist.map((e) => e['name']).join(' , ');
    List specialitylist=widget.data['specialities'];
    var specialitydata=specialitylist.map((e) => e['specialityTitle']).join(' , ');
    List sportlist=widget.data['sports'];
    var sportdata=sportlist.map((e) => e['sportName']).join(' , ');
    List gallerydata=widget.data['user']['galleries'];
    var profileimage=gallerydata.firstWhere((element) => element['fileType']=="Profile Image",orElse: ()=>{'fileLocation': ''},)['fileLocation'];
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Coach Details"),
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
                              gallerydata.isEmpty? const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Center(child: Icon(Icons.person,color: Colors.white,),),
                                ):
                              CircleAvatar(
                                radius:60,
                                backgroundImage: NetworkImage("$profileimage"),),
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
                                            like=!like;
                                          });
                                          favourite_add_controller.Favourite_Api(context, widget.data['user']['id'],"3");
                                          getallfavourite_controller.Getfavourite_Api(context, "3");
                                        },icon: Icon(Icons.favorite,
                                            color:like?Colors.red:Colors.grey.shade200),) ,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF009719),shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )),
                                    onPressed: (){
                                      Get.to(Chatscreen(name: widget.data['user']['firstName']??'',id: widget.data['user']['id']??0,image:profileimage,email:widget.data['user']['email']??'',
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
                                  Text(widget.data['user']['firstName']??'',style: coachviewtxt,)
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
                                  Text(widget.data['user']['lastName']??'',style: coachviewtxt,)
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
                              Text(widget.data['user']['email'],style: coachviewtxt,)
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
                              Text(widget.data['phone'],style: coachviewtxt,)
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
                              Text(specialitydata??"",style: coachviewtxt,)
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
                              Text(sportdata??'',style: coachviewtxt,)
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
                              Text(widget.data['ageYouCoach']??'',style: coachviewtxt,)
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
                              Text(widget.data['genderYouCoach']??'',style: coachviewtxt,)
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
                              Text(citydata??"",style: coachviewtxt,)
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
                              Text(statedata??"",style: coachviewtxt,)
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
                              ${widget.data['bio']??''}
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
                              ${widget.data['lookingFor']??''}
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
                                  child:    Row(
                                    children: [
                                      Image.asset("assets/Media/weblink.png",height: 18,width: 18,),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: InkWell(
                                            onTap: (){
                                              urllauncher(widget.data['websiteLink']??'');
                                            },
                                            child: Text(widget.data['websiteLink']??'',style: linkbtntxt,))
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
                                          urllauncher(widget.data['twitterLink']??'');
                                        },
                                        child: Text(widget.data['twitterLink']??'',style: linkbtntxt,)),
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
                                          urllauncher(widget.data['instagramLink']??'');
                                        },
                                        child: Text(widget.data['instagramLink']??'',style: linkbtntxt,)),
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
                              Text("Youtube video Link",style: profiletxtnew,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Image.asset("assets/img_12.png",height: 15,width: 15,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: InkWell(
                                          onTap: (){
                                            urllauncher("www.youtube.com");
                                          },
                                          child: Text("www.connectathletcoach.com",style: linkbtntxt,)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
