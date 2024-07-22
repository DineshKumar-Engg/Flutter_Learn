
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/widget/Redirect%20Link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Services/Favourite/Favourite_list.dart';
import '../../../widget/Appbar.dart';
import '../../Athlete/Chat screen.dart';

class ClubViewscreen extends StatefulWidget {
   Map<String,dynamic> data;
   ClubViewscreen({super.key,required this.data});

  @override
  State<ClubViewscreen> createState() => _ClubViewscreenState();
}

class _ClubViewscreenState extends State<ClubViewscreen> {
  final Favourite_add_Controller favourite_add_controller=Get.find<Favourite_add_Controller>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  bool like=false;


  @override
  Widget build(BuildContext context) {
    List statelist=widget.data['stateData'];
    var statedata=statelist.map((e) => e['name']).join(' , ');
    List citylist=widget.data['citiesData'];
    var citydata=citylist.map((e) => e['name']).join(' , ');
    List sportlist=widget.data['sports'];
    var sportdata=sportlist.map((e) => e['sportName']).join(' , ');
    List gallerydata=widget.data['user']['galleries'];
    var profileimage=gallerydata.firstWhere((element) => element['fileType']=="Profile Image",orElse: ()=>{'fileLocation': ''},)['fileLocation'];
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Club Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: displayheight(context)*0.50,
                width: double.infinity,
                decoration:commonshadow20,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // height: displayheight(context)*0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gallerydata.isEmpty? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              child: Center(child: Icon(Icons.person,color: Colors.white,),),
                            ):CircleAvatar(
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
                                        favourite_add_controller.Favourite_Api(context, widget.data['user']['id'],"4");
                                        getallfavourite_controller.Getfavourite_Api(context, 4);
                                      },icon: Icon(Icons.favorite,
                                          color:like?Colors.red:Colors.grey.shade200),)  ,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF009719),shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )),
                                  onPressed: (){
                                    Get.to(Chatscreen(name:widget.data['user']['firstName']??'',id: widget.data['user']['id']??0,image:profileimage,email:widget.data['user']['email']??'',
                                    ));
                                  },child: Text("Chat",style: searchbtntxt,),)
                              ],
                            )

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.data['academieName']??'',style: inputtxt,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Club & Academy Information ",style: profiletxthead,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textvalue("First Name",widget.data['user']['firstName']),
                                textvalue("Last Name",widget.data['user']['lastName']),
                              ],
                            ),
                            textvalue("Phone Number",widget.data['phone']),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sports of Interest",style: profiletxtnew,),
                                Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Text(sportdata??'',style: coachviewtxt,)
                                ),
                              ],
                            ),
                          ),

                            textvalue("Email ID",widget.data['user']['email']),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Training Information ",style: profiletxthead,),
                            ),
                            textvalue("Ages We Training",widget.data['ageYouCoach']),
                            textvalue("Gender We Training",widget.data['genderYouCoach']),
                            textvalue("City We Training", citydata),
                            textvalue("State We Training", statedata),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("About Club & Academy",style: profiletxthead,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("About Organization",style:profiletxtnew ,),
                                  HtmlWidget('''
                              ${widget.data['bio']}
                              ''',textStyle:coachviewtxt ,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("League Information",style:profiletxtnew ,),
                                  HtmlWidget('''
                              ${widget.data['leagueName']}
                              ''',textStyle:coachviewtxt ,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Social Media Links ",style: profiletxthead,),
                            ),
                            linktxt("Website Link", "assets/Media/weblink.png", widget.data['websiteLink']),
                            linktxt("X Profile Link", "assets/Media/xlink.png", widget.data['twitterLink']),
                            linktxt("IG Profile Link", "assets/Media/iglink.png", widget.data['instagramLink']),
                            linktxt("Youtube video Link", "assets/img_12.png", "www.youtube.com"),
                            const SizedBox(height: 50,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget textvalue(String title,String subtitle){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: profiletxtnew,),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(subtitle??'',style: coachviewtxt,)
          ),
        ],
      ),
    );
  }
  Widget linktxt(String title,String image,String link){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: profiletxtnew,),
          Row(
            children: [
              Image.asset("$image",height: 18,width: 18,),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: InkWell(
                    onTap: (){
                      urllauncher(link);
                    },
                    child: Text(link,style: linkbtntxt,)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
