import 'package:connect_athelete/Screens/Athlete/View%20Image.dart';
import 'package:connect_athelete/Services/Favourite/Favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/delete_Favourite.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';
import '../../Athlete/Chat screen.dart';
import 'package:get/get.dart';

class Favourite_Athlete_View extends StatefulWidget {
  Map<String,dynamic> data;
   Favourite_Athlete_View({super.key,required this.data});

  @override
  State<Favourite_Athlete_View> createState() => _Favourite_Athlete_ViewState();
}

class _Favourite_Athlete_ViewState extends State<Favourite_Athlete_View> {

  final Deletefavourite_Controller deletefavourite_controller=Get.find<Deletefavourite_Controller>();
  final Favourite_add_Controller favourite_add_controller=Get.find<Favourite_add_Controller>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  bool like=false;
  @override
  Widget build(BuildContext context) {
    List headshotimages=widget.data['galleryData'].where((element)=>element['fileType']=="Headshot Image").toList();
    List gallerydata = widget.data['galleryData'] ?? [];
    var profileimage = gallerydata.firstWhere((element) => element['fileType'] == "Profile Image", orElse: () => {'fileLocation': ''},)['fileLocation'];
    List profiledata=widget.data['profileData']??[];
    List getstatedata=widget.data['stateData']??[];
    var statedata=getstatedata[0]['name'];
    List getcitydata=widget.data['citiesData']??[];
    var citydata=getcitydata[0]['name'];
    List getspecialitydata=widget.data['specialityData']??[];
    var specialitydata=getspecialitydata.map((e) => e['specialityTitle']??"").join(' , ');
    List getsportdata=widget.data['sportsData']??[];
    var sportdata=getsportdata.map((e) => e['sportName']??"").join(' , ');
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
                                  padding:  const EdgeInsets.only(right: 6.0),
                                  child: InkWell(
                                    // onTap:toggleSwitch,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: commonshadow,
                                      child:IconButton(onPressed: (){
                                        setState((){
                                          like?
                                          favourite_add_controller.Favourite_Api(context, widget.data['favorite']['id'], 2)
                                              :
                                          deletefavourite_controller.Deletefavourite_Api(context, widget.data['favorite']['id']);
                                          getallfavourite_controller.Getfavourite_Api(context, 2);
                                          like=!like;
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
                                        name:widget.data['favoriteUserData']['firstName']??'',
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
                                    Text(widget.data['favoriteUserData']['firstName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Last Name  ",style:profiletxtheadtxt ,),
                                    Text(widget.data['favoriteUserData']['lastName']??'',style:profiletxtheadsubtxt ,),
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
                                    Text(profiledata[0]['gender']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Row(
                                    children: [
                                      Text("Age : ",style:profiletxtheadtxt ,),
                                      Text(profiledata[0]['age']??'',style:profiletxtheadsubtxt ,),
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
                                Text(profiledata[0]['school']??'',style:profiletxtheadsubtxt ,),
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
                                ${profiledata[0]['currentAcademie']??''}
                                ''',textStyle:profiletxtheadsubtxt ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("City : ",style:profiletxtheadtxt ,),
                                Text(citydata??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("State : ",style:profiletxtheadtxt ,),
                                Text(statedata??'',style:profiletxtheadsubtxt ,),
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
                                 ${profiledata[0]['bio']??''}
                                ''',textStyle:profiletxtheadsubtxt ,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("X profile Link : ",style:profiletxtheadtxt ,),
                                Text(profiledata[0]['twitterLink']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("IG profile Link : ",style:profiletxtheadtxt ,),
                                Text(profiledata[0]['instagramLink']??'',style:profiletxtheadsubtxt ,),
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
                                ${profiledata[0]['achievements']??''}
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
                                Text(sportdata,style:profiletxtheadsubtxt ,),
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
                                Text(specialitydata,style:profiletxtheadsubtxt ,),
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
                                    Text(profiledata[0]['parentFirstName']??'',style:profiletxtheadsubtxt ,),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  children: [
                                    Text("Last Name",style:profiletxtheadtxt ,),
                                    Text(profiledata[0]['parentLastName']??'',style:profiletxtheadsubtxt ,),
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
                                Text(widget.data['favoriteUserData']['email']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Mobile Number : ",style:profiletxtheadtxt ,),
                                Text(profiledata[0]['parentPhone']??'',style:profiletxtheadsubtxt ,),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Athlete Headshot Images ",style: profiletxthead,),
                          ),
                          SizedBox(
                            height: displayheight(context)*0.16,
                            width: double.infinity,
                            child: headshotimages.isEmpty?
                            Center(child: Text("No Headshot Images Found",style: profiletxtheadtxt,),)
                                :ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: headshotimages.length,
                                itemBuilder: (BuildContext context,int index){
                                  var imageurl=headshotimages[index]['fileLocation'];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                            onTap: (){
                                              Get.to(ViewImagescreen(image: headshotimages[index]['fileLocation']));
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
                            child: Text("Athlete Headshot Videos ",style: profiletxthead,),
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
