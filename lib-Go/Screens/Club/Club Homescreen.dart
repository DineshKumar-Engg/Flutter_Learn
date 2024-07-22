import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_athelete/Screens/Club/Club%20Pofile.dart';
import 'package:connect_athelete/Services/Announcement/Announcementbyrole.dart';
import 'package:connect_athelete/Services/Announcement/commonAnnouncement.dart';
import 'package:connect_athelete/Services/CMS%20Service/cms_api.dart';
import 'package:connect_athelete/Services/Transaction%20service/CurrentplanController.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/CMS Service/BannerImage_Controller.dart';
import '../../Services/Club Service/Club Details Api.dart';
import '../../widget/Divider.dart';
import '../../widget/Drawer Divider.dart';
import '../../widget/Drawer List Tile.dart';
import '../../widget/decoration Container.dart';
import '../Athlete/About Us.dart';
import '../Athlete/ChatList.dart';
import '../Athlete/SubscriptionPlan.dart';
import '../Athlete/Transaction History.dart';
import '../Athlete/howits_works_screen.dart';
import '../Contact Us/Contact Us.dart';
import '../Login/Loginscreen.dart';
import '../Password/Changepassword.dart';


class ClubsHomescreen extends StatefulWidget {
  const ClubsHomescreen({super.key});

  @override
  State<ClubsHomescreen> createState() => _ClubsHomescreenState();
}

class _ClubsHomescreenState extends State<ClubsHomescreen> {
  final ScrollController _scrollController = ScrollController();

  final ClubProfileDetailsController clubProfileDetailsController=Get.find<ClubProfileDetailsController>();
  final CMSController cmsController=Get.find<CMSController>();
  final BannerImageController bannerImageController=Get.find<BannerImageController>();
  final CommonAnnouncementController commonAnnouncementController=Get.find<CommonAnnouncementController>();
  final AnnouncementController announcementController=Get.find<AnnouncementController>();
  final Currentplancontroller currentplancontroller=Get.find<Currentplancontroller>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final SettingController settingController=Get.find<SettingController>();

  int selectedindex=0;
  String?allprofileimage;

  @override
  void initState() {
    clubProfileDetailsController.ClubProfileDetailsApi(context);
    cmsController.cmsapi(context,1);
    bannerImageController.bannerimageapi(context, 9);
    commonAnnouncementController.CommonAnnouncementApi(context);
    announcementController.AnnouncementApi(context,4);
    currentplancontroller.CurrentplanApi(context);
    sportslistcontroller.sportslistapi(context);
    settingController.SettingApi(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  bool?media=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_backpress(),
            child:Obx(()=>clubProfileDetailsController.clunprofiledata.isEmpty?
            Container(
             color:background,
             child:  Center(child: Image.asset("assets/loader.gif")),
            )
                :Scaffold(
                 backgroundColor:background,
                 drawer: Drawer(
                   width:displaywidth(context)*0.92,
                   backgroundColor: Colors.white,
                   surfaceTintColor: Colors.transparent,
                  child: SingleChildScrollView(
                  child: Column(
                  children: [
                   Padding(
                    padding: const EdgeInsets.only(top:70.0),
                    child: Container(
                     height: displayheight(context)*0.15,
                    color:const Color(0xFFF1F1F1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          allprofileimage==null?const CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.person,color: primary,),
                          ):CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage("$allprofileimage"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${clubProfileDetailsController.clunprofiledata[0]['academieData']['academieName']??''}",style: profileheadindtxt,),
                                Text("Club & academy",style: profilesubheadindtxt,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                drawerlisttile(Icons.person, "Profile Details", const ClubProfilescreen()),
                drawerdivider(),
                    drawerlisttile(Icons.info, "About Us", const Aboutus_screen()),
                    drawerdivider(),
                drawerlisttile(Icons.lock_open_rounded, "Change Password",  ChangePasswordnew(route:"athlete")),
                drawerdivider(),
                drawerlisttile(Icons.currency_exchange, "Subscription Plan", const SubscriptionPlanscreen()),
                drawerdivider(),
                drawerlisttile(Icons.history, "Transaction History", const TransactionHistoryscreen()),
                drawerdivider(),
                    drawerlisttile(Icons.work_outlined, "How Its Works", const Howits_works_screen()),
                    drawerdivider(),
                ListTile(
                  onTap: (){logout();},
                  leading: const Icon(Icons.logout_sharp,color: primary,),
                  title:Text("Logout ",style: drawertxt,),
                ),
                drawerdivider()

              ],
            ),
          ),
        ),
               appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.sort,color: primary,size: 30),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
          ),
        ),
                 body:Stack(
          children: [
            home(context),
            Align(
                alignment: Alignment.bottomCenter,
                child: bottomnavbar())
          ],
        )

      ),
          )
        );

  }
  
  Widget home(BuildContext context){
    List images = bannerImageController.cmsgallery.toList();
    List getgallerydata=clubProfileDetailsController.clunprofiledata[0]['galleryData']??[];
    var profileimage=getgallerydata.firstWhere((image)=>image['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
    allprofileimage=profileimage;
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Hi",style: profiletxtyellow,),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("${clubProfileDetailsController.clunprofiledata[0]['userData']['firstName']}",style: profilenametxt,),
                        ),
                      ],
                    ),
                    Text("Welcome to Connect Athlete",style: upitxt,)
                  ],
                ),
                 Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: (){
                      Get.to(Aboutus_screen());
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/logo/newlogo.png",color: newyellow,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                    child:CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(images[itemIndex]['fileLocation'],height: displayheight(context)*0.28,width: double.infinity,fit: BoxFit.fill,)),
                      options: CarouselOptions(
                        height: displayheight(context)*0.28,
                        aspectRatio: 16/9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                        // disableCenter: true,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                ),
                commonAnnouncementController.commonannouncementdata.isEmpty?
                Container()
                    :commonannouncement(),
                bannerImageController.cmsdata[1].isEmpty?
                    Container():Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("More About",style: aboutclubtxt,),
                            Text("Connect Athlete",style: aboutclubtxt1,),
                            const Divider(
                              color:newyellow,
                              thickness: 2,
                              indent: 170,
                              endIndent: 170,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  HtmlWidget('''
                              ${bannerImageController.cmsdata[1]['shortDescription']??''}
                                  ''',textStyle: chatnametxt,),
                                  HtmlWidget('''
                              ${bannerImageController.cmsdata[1]['description']??''}
                                  ''',textStyle: chatnametxt,),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                announcementController.announcementdata.isEmpty?
                Container()
                    :Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Announcement",style: profiletxthead,),
                          ),
                          commondivider(Colors.grey.shade200),
                          SizedBox(
                            height: displayheight(context)*0.08,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: announcementController.announcementdata.length,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,int index){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selectedindex=index;
                                        });
                                      },
                                      child: Container(
                                        height: displayheight(context)*0.07,
                                        decoration: BoxDecoration(
                                            color:selectedindex==index?primary:const Color(0xFFF3F2F9),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(announcementController.announcementdata[index]['sportData']['sportName'],style:selectedindex==index?profiletxtheadwhite:profiletxthead,),
                                        )),

                                      ),
                                    ),
                                  );

                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: selectedindex != null?HtmlWidget('''
                            ${announcementController.announcementdata[selectedindex]['announcement']['announcementDescription']}
                            ''',
                              textStyle: chatnametxt,
                            ):  const Text("Select a sport to view announcement description"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: displayheight(context)*0.12,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            decorationcontainer(Icons.person, "Profile", const ClubProfilescreen()),
                            decorationcontainer(Icons.currency_exchange, "Plan", const SubscriptionPlanscreen()),
                            decorationcontainer(Icons.history, "History", const TransactionHistoryscreen()),
                            decorationcontainer(Icons.lock_open_rounded, "Password",  ChangePasswordnew(route:"club")),
                            decorationcontainer(Icons.info, "About Us", const Aboutus_screen()),
                            decorationcontainer(Icons.settings, "Howit's Work", const Howits_works_screen()),

                          ],
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        )

      ],
    );
  }


  logout(){
    return showDialog(
        context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text("Are you sure you want to logout Connect Athlete!",style:drawertxt1 ,),
        actions: [
          TextButton(onPressed: (){Get.back();}, child: Text("No",style: drawertxt,)),
          TextButton(onPressed: ()async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            pref.remove('sessionid');
            pref.remove('userid');
            pref.remove('token');
            pref.remove('token');
            Get.to(const Loginscreen());
          }, child: Text("Yes",style: drawertxt,))
        ],
      );
    });
  }

  Widget bottomnavbar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:70.0,vertical: 5.0),
      child: ScrollToHide(
        duration: const Duration(milliseconds: 1000),
        scrollController: _scrollController,
        hideDirection: Axis.vertical,
        child: AnimatedContainer(
          height: displayheight(context)*0.07,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(15)
          ),
          duration: const Duration(milliseconds:2),
          curve: Curves.fastOutSlowIn,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                Get.to(const Conactusscreen());
              }, icon:   const Icon(CupertinoIcons.phone,color: Colors.white,),),
              IconButton(onPressed: (){
              }, icon:   const Icon(CupertinoIcons.home,color: Colors.white,),),
              IconButton(onPressed: (){
                Get.to(const ChatListscreen());
              }, icon:   const Icon(CupertinoIcons.chat_bubble_text_fill,color: Colors.white,),)
            ],
          ),
        ),
      ),
    );
  }

  _backpress(){
    return showDialog(
        context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text("Are you sure you want to Exit Connect Athlete!",style:drawertxt1,textAlign: TextAlign.center,),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context,false);}, child: Text("No",style: drawertxt,)),
          TextButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Yes",style: drawertxt,))
        ],
      );
    });
  }

  Widget commonannouncement(){
    return Obx(()=>Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xFFF3F2F9),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("General Announcements",style: profiletxthead,),
                  const Icon(Icons.announcement,color: primary,)
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:HtmlWidget('''
                          ${commonAnnouncementController.commonannouncementdata[0]['announcement']['announcementDescription']??''}
                          ''',textStyle:aboutsubheading ,)
              // Text("",style: aboutsubheading,textAlign: TextAlign.start,),
            )
          ],
        ),
      ),
    ));
  }
}
