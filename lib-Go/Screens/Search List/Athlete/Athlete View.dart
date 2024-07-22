import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Screens/Athlete/View%20Image.dart';
import 'package:connect_athelete/Services/Favourite/Favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';
import '../../Athlete/Chat screen.dart';

class Athleteviewscreen extends StatefulWidget {
  Map<String,dynamic> data;
   Athleteviewscreen({super.key,required this.data});

  @override
  State<Athleteviewscreen> createState() => _AthleteviewscreenState();
}

class _AthleteviewscreenState extends State<Athleteviewscreen> {

  final Favourite_add_Controller favourite_add_controller=Get.find<Favourite_add_Controller>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  bool like=false;

  @override
  Widget build(BuildContext context) {
    List sportdata=widget.data['sports']??[];
    var sportdatas=sportdata.map((e) => e['sportName']).join(' , ');
    List specialitydata=widget.data['specialities']??[];
    var specialityessata=specialitydata.map((e) => e['specialityTitle']).join(' , ');
    List gallerydata = widget.data['user']['galleries'] ?? [];
    var profileimage = gallerydata.firstWhere((element) => element['fileType'] == "Profile Image", orElse: () => {'fileLocation': ''},)['fileLocation'];
    List headshotimage = widget.data['user']['galleries']?.where((element)=>element['fileType']=="Headshot Image").toList()??[];
    List headshotvideos = widget.data['user']['galleries']?.where((element)=>element['fileType']=="Headshot Video").toList()??[];


    return  Scaffold(
      backgroundColor: background,
      appBar:appbarwidget("Athlete Details"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:  Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)
                          )
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gallerydata.isEmpty
                                ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey,
                              child: Center(child: Icon(Icons.person,color: Colors.white,),),
                            )
                                :CircleAvatar(
                              radius:60,
                              backgroundImage: NetworkImage("$profileimage"),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  const EdgeInsets.only(right: 6.0),
                                  child: InkWell(
                                    // onTap:toggleSwitch,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: commonshadow,
                                      child:IconButton(onPressed: (){
                                        setState(() {
                                          like=!like;
                                        });
                                        favourite_add_controller.Favourite_Api(context, widget.data['user']['id'],"2");
                                        getallfavourite_controller.Getfavourite_Api(context, "2");
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
                                    Get.to(Chatscreen(
                                        name:widget.data['user']['firstName']??''
                                        ,id: widget.data['user']['id']??0,
                                      image:profileimage, email:widget.data['user']['email']??'',
                                    ));
                                  },child: Text("Chat",style: searchbtntxt,),)
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Athlete Profile",style: profiletxthead,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name  ",style:profiletxtheadtxt ,),
                                    Text(widget.data['user']['firstName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Last Name  ",style:profiletxtheadtxt ,),
                                    Text(widget.data['user']['lastName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Gender : ",style:profiletxtheadtxt ,),
                                    Text(widget.data['gender']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Row(
                                    children: [
                                      Text("Age : ",style:profiletxtheadtxt ,),
                                      Text(widget.data['age']??'',style:profiletxtheadsubtxt ,),
                                    ],
                                  ),
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
                                Text("Current School  ",style:profiletxtheadtxt ,),
                                Text(widget.data['school']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current Club & Academy",style:profiletxtheadtxt ,),
                                HtmlWidget('''
                                ${widget.data['currentAcademie']??''}
                                ''',textStyle:profiletxtheadsubtxt ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("City : ",style:profiletxtheadtxt ,),
                                Text(widget.data['cityData']['name']??"",style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("State : ",style:profiletxtheadtxt ,),
                                Text(widget.data['stateData']['name']??"",style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Athlete Bio",style:profiletxtheadtxt ,),
                                HtmlWidget('''
                                 ${widget.data['bio']??''}
                                ''',textStyle:profiletxtheadsubtxt ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("X profile Link : ",style:profiletxtheadtxt ,),
                                Text(widget.data['twitterLink']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("IG profile Link : ",style:profiletxtheadtxt ,),
                                Text(widget.data['instagramLink']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Athlete Achievements ",style: profiletxthead,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Achievement ",style:profiletxtheadtxt ,),
                                HtmlWidget('''
                                  ${widget.data['achievements']??''}
                                     ''',textStyle:profiletxtheadsubtxt ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sports of Interest ",style:profiletxtheadtxt ,),
                                Text(sportdatas??"",style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Speciality Position  ",style:profiletxtheadtxt ,),
                                Text(specialityessata??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Parents Profile",style: profiletxthead,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name",style:profiletxtheadtxt ,),
                                    Text(widget.data['parentFirstName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  children: [
                                    Text("Last Name",style:profiletxtheadtxt ,),
                                    Text(widget.data['parentLastName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Email : ",style:profiletxtheadtxt ,),
                                Text(widget.data['user']['email']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Mobile Number : ",style:profiletxtheadtxt ,),
                                Text(widget.data['parentPhone']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Athlete Headshot Images",style: profiletxthead,),
                          ),
                          SizedBox(
                            height: displayheight(context)*0.16,
                            width: double.infinity,
                            child: headshotimage.isEmpty?
                                Center(child: Text("No Headshot Images Found",style: profiletxtheadtxt,),)
                                :ListView.builder(
                              scrollDirection: Axis.horizontal,
                                itemCount: headshotimage.length,
                                itemBuilder: (BuildContext context,int index){
                                var imageurl=headshotimage[index]['fileLocation'];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                            onTap: (){
                                              Get.to(ViewImagescreen(image: headshotimage[index]['fileLocation']));
                                            },
                                            child: Image.network("$imageurl",height: displayheight(context)*0.16,width: displaywidth(context)*0.30,fit: BoxFit.cover,))),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Athlete Headshot Videos",style: profiletxthead,),
                          ),
                          SizedBox(
                            height: displayheight(context)*0.16,
                            width: double.infinity,
                            child: headshotimage.isEmpty?
                            Center(child: Text("No Headshot Videos Found",style: profiletxtheadtxt,),)
                                :ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: headshotvideos.length,
                                itemBuilder: (BuildContext context,int index){
                                  var imageurl=headshotvideos[index]['fileLocation'];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                            onTap: (){
                                              // Get.to(ViewImagescreen(image: headshotvideos[index]['fileLocation']));
                                            },
                                            // child: Image.network("$imageurl",height: displayheight(context)*0.16,width: displaywidth(context)*0.30,fit: BoxFit.cover,)
                                        )
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

