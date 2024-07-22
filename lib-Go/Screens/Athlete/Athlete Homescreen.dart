import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_athelete/Screens/Athlete/About%20Us.dart';
import 'package:connect_athelete/Screens/Athlete/Imageupload.dart';
import 'package:connect_athelete/Screens/Athlete/ProfileDetails.dart';
import 'package:connect_athelete/Screens/Athlete/SubscriptionPlan.dart';
import 'package:connect_athelete/Screens/Athlete/Transaction%20History.dart';
import 'package:connect_athelete/Screens/Athlete/Video%20upload.dart';
import 'package:connect_athelete/Screens/Athlete/howits_works_screen.dart';
import 'package:connect_athelete/Screens/Favourite%20List/Coach/Favourite%20Coach%20List.dart';
import 'package:connect_athelete/Screens/Favourite%20List/Coach/Favourite_Coach_View.dart';
import 'package:connect_athelete/Screens/Favourite%20List/club/Favourite_Club_List.dart';
import 'package:connect_athelete/Screens/Login/Loginscreen.dart';
import 'package:connect_athelete/Screens/Search%20List/Club/Clubssearch.dart';
import 'package:connect_athelete/Screens/Search%20List/Coach/CoachList.dart';
import 'package:connect_athelete/Services/Announcement/Announcementbyrole.dart';
import 'package:connect_athelete/Services/Announcement/commonAnnouncement.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/Services/CMS%20Service/Announcement_Api.dart';
import 'package:connect_athelete/Services/CMS%20Service/BannerImage_Controller.dart';
import 'package:connect_athelete/Services/CMS%20Service/cms_api.dart';
import 'package:connect_athelete/Services/Chat/GetChatList.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/Favourite/getclub_favourite_list.dart';
import 'package:connect_athelete/Services/Search%20service/Coach%20search.dart';
import 'package:connect_athelete/Services/Transaction%20service/CurrentplanController.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:connect_athelete/Services/get%20data/state_list.dart';
import 'package:connect_athelete/widget/Divider.dart';
import 'package:connect_athelete/widget/Drawer%20Divider.dart';
import 'package:connect_athelete/widget/Drawer%20List%20Tile.dart';
import 'package:connect_athelete/widget/Redirect%20Link.dart';
import 'package:connect_athelete/widget/decoration%20Container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../widget/Loading.dart';
import '../Contact Us/Contact Us.dart';
import '../Favourite List/club/Favourite_club_view.dart';
import '../Password/Changepassword.dart';
import '../Search List/Coach/Coachsearch.dart';
import 'ChatList.dart';

class AthleteHomescreen extends StatefulWidget {
  const AthleteHomescreen({super.key});

  @override
  State<AthleteHomescreen> createState() => _AthleteHomescreenState();
}

class _AthleteHomescreenState extends State<AthleteHomescreen> {

  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final CoachSearchController coachSearchController=Get.find<CoachSearchController>();
  final CMSController cmsController=Get.find<CMSController>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  final GetClubfavourite_Controller getClubfavourite_Controller=Get.find<GetClubfavourite_Controller>();
  final Announcement_Controller announcement_controller=Get.find<Announcement_Controller>();
  final BannerImageController bannerImageController=Get.find<BannerImageController>();
  final SettingController settingController=Get.find<SettingController>();
  final Currentplancontroller currentplancontroller=Get.find<Currentplancontroller>();
  final CommonAnnouncementController commonAnnouncementController=Get.find<CommonAnnouncementController>();
  final AnnouncementController announcementController=Get.find<AnnouncementController>();
  final GetChatlistController getChatlistController=Get.find<GetChatlistController>();
  final ScrollController _scrollController = ScrollController();

  String?sportid;
  int selectedindex=0;
  String?allprofileimage;

  Future<void>sportdata()async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var id=shref.getString('sportid');
    setState(() {
      sportid=id??'';
      getallfavourite_controller.Getfavourite_Api(context, "3");
      getClubfavourite_Controller.GetClubfavourite_Api(context);
      announcementController.AnnouncementApi(context, 2);
      getChatlistController.GetChatListApi(context);
    });
  }
  @override
  void initState() {
    sportdata().then((_) {
      print(sportid);
      coachSearchController.CoachSearchApi(context, sportid, 0, 0);
      sportslistcontroller.sportslistapi(context);
      statelistController.StatelistApi(context);
      profiledetailsController.ProfiledetailsApi(context);
      cmsController.cmsapi(context,1);
      getallfavourite_controller.Getfavourite_Api(context, "3");
      getClubfavourite_Controller.GetClubfavourite_Api(context);
      announcement_controller.AnnouncementApi(context, 2);
      bannerImageController.bannerimageapi(context, 7);
      settingController.SettingApi(context);
      currentplancontroller.CurrentplanApi(context);
      commonAnnouncementController.CommonAnnouncementApi(context);
      List getgallerydata=profiledetailsController.profiledata[0]['galleryData']??[];
      var profileimage=getgallerydata.firstWhere((image)=>image['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
      allprofileimage=profileimage;
    });
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
    return  WillPopScope(
      onWillPop: ()=>_backpress(context),
      child: Obx(
          ()=>
             profiledetailsController.profiledata.isEmpty?
             Container(
               color:background,
               child:  Center(child: Image.asset("assets/loader.gif")),
             )
                 :
             Scaffold(
               backgroundColor:background,
                  drawer: Drawer(
                  width:displaywidth(context)*0.90,
                   backgroundColor: Colors.white,
                   surfaceTintColor: Colors.transparent,
                     child: SingleChildScrollView(
                      child:
                        Column(
                         children: [
                          Padding(
                            padding: const EdgeInsets.only(top:70.0),
                           child: Container(
                             height: displayheight(context)*0.15,
                             color:const Color(0xFFF1F1F1),
                          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               allprofileimage==null?const CircleAvatar(
                                radius: 40,
                                 child: Icon(Icons.person,color:primary,),
                              ):CircleAvatar(
                                 radius: 40,
                                 backgroundImage: NetworkImage("$allprofileimage"),
                               ),
                              Padding(
                                padding: const EdgeInsets.only(left:12.0),
                                child: Obx(
                                  ()=>
                                       Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                         Text("${profiledetailsController.profiledata[0]['userData']['firstName']+" "+profiledetailsController.profiledata[0]['userData']['lastName']??''}",style: profileheadindtxt,),
                                          Text( "Athlete",style: profilesubheadindtxt,),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                         drawerlisttile(Icons.person, "Profile Details", const ProfileDetailscsreen()),
                         drawerdivider(),
                           drawerlisttile(Icons.info, "About Us", const Aboutus_screen()),
                           drawerdivider(),
                          ListTile(
                      onTap: (){
                        setState(() {
                          media=!media!;
                        });
                           },
                            leading: const Icon(Icons.perm_media_sharp,color:primary,),title:Text("Media",style: drawertxt,),
                            trailing:  Icon(media==true?Icons.keyboard_arrow_down_sharp:Icons.arrow_forward_ios_rounded,color: primary,),),
                             media==true?expandmedia():Container(),
                            drawerdivider(),
                             drawerlisttile(Icons.lock_open_rounded, "Change Password",  ChangePasswordnew(route:"athlete")),
                              drawerdivider(),
                              drawerlisttile(Icons.currency_exchange, "Subscription Plan", const SubscriptionPlanscreen()),
                              drawerdivider(),
                               drawerlisttile(Icons.sports, "Search Coaches", const Coachsearchscreen()),
                               drawerdivider(),
                                drawerlisttile(Icons.apartment, "Search Club & Academy's", const Clubsearchscreen()),
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
                  ],),

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
      ),
    );
  }

  Widget home(BuildContext context){
    List images = bannerImageController.cmsgallery.toList();
    List getgallerydata=profiledetailsController.profiledata[0]['galleryData']??[];
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
            padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Hi",style: profiletxtyellow,),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,bottom: 2.0),
                          child: Text("${profiledetailsController.profiledata[0]['userData']['firstName'].substring(0, 1).toUpperCase()}${profiledetailsController.profiledata[0]['userData']['firstName'].substring(1).toLowerCase()}",style: profilenametxt,),
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
                      Get.to(const Aboutus_screen());
                      // contectbottomshow(context);
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
          // height: displayheight(context)*0.78,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child:
                  CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                            child: Image.network(images[itemIndex]['fileLocation']??'',height: displayheight(context)*0.28,width: double.infinity,fit: BoxFit.fill,)),
                    options: CarouselOptions(
                      height: displayheight(context)*0.28,
                      aspectRatio: 16/9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      scrollPhysics: const ScrollPhysics(),
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      disableCenter: false,
                      scrollDirection: Axis.horizontal,
                  ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Get.to(const Coachsearchscreen());
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xfff08424),
                            Color(0xfff08424),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                        child: InkWell(
                          onTap: (){
                            showloadingdialog(context);
                            List<Map<String,dynamic>> data=coachSearchController.coachsearchdata.cast();
                            Navigator.pop(context);
                            Get.to(CoachListscreen(data: data));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Hey ! ${profiledetailsController.profiledata[0]['userData']['firstName']}",style: homebantxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Find the Best coach near you",style: homesubbantxt,),
                                  )
                                ],
                              ),
                              const Padding(
                                padding:  EdgeInsets.all(4.0),
                                child:  Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 30,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ),
               commonannouncement(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)
                            ),
                            border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Favorite Coach list ",style: profiletxthead,),
                              getallfavourite_controller.getallfavouritedata.length>3?
                              TextButton(onPressed: (){
                                Get.to(const Favoritecoachscreen());
                              }, child:  Padding(
                                padding: const EdgeInsets.only(right:12.0),
                                child: Text("See All",style: profiletxthead,),
                              )):
                                  const Text("")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child:getallfavourite_controller.getallfavouritedata.isEmpty?
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30.0),
                                child: Text("No Coach Favourite Found.",style: inputtxt,),
                              ),
                            )
                            : Coachfavouritelist()
                      ),
                    ],),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)
                            ),
                            border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Favorite Club list ",style: profiletxthead,),
                              getClubfavourite_Controller.getclubfavouritedata.length>3?
                              TextButton(onPressed: (){
                                Get.to(const Favourite_Club_List());
                              }, child:  Padding(
                                padding: const EdgeInsets.only(right:12.0),
                                child: Text("See All",style: profiletxthead,),
                              ))
                                  :const Text("")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: getClubfavourite_Controller.getclubfavouritedata.isEmpty?
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text("No Club & Academy Favourite Found.",style: inputtxt,),
                          ),
                        )
                            :Clubfavouritelist()
                      ),
                    ],),
                ),
                    Sportannouncement(),


                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Container(
                          height: displayheight(context)*0.12,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,right: 8.0),
                              child: Row(
                                children: [
                                  decorationcontainer(Icons.person, "Profile", const ProfileDetailscsreen()),
                                  decorationcontainer(Icons.image, "Image", const Imageuploadscreen()),
                                  decorationcontainer(Icons.slow_motion_video_sharp, "Video", const Videouploadscreen()),
                                  decorationcontainer(Icons.currency_exchange, "Plan", const SubscriptionPlanscreen()),
                                  decorationcontainer(Icons.history, "History", const TransactionHistoryscreen()),
                                  decorationcontainer(Icons.sports, "Coach", const Coachsearchscreen()),
                                  decorationcontainer(Icons.apartment, "Clubs", const Clubsearchscreen()),
                                  decorationcontainer(Icons.lock_open_rounded, "Password",  ChangePasswordnew(route: "athlete")),
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
                )
              ],
            ),
          ),
        )


      ],
    );
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

  logout(){
    return showDialog(
        context: context, builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: Text("Are you sure you want to logout Connect Athlete.",style:drawertxt1,textAlign: TextAlign.center,),
            actions: [
              TextButton(onPressed: (){Get.back();}, child: Text("No",style: drawertxt,)),
              TextButton(onPressed: ()async{
                  SharedPreferences pref=await SharedPreferences.getInstance();
                  pref.remove('sessionid');
                  pref.remove('userid');
                  pref.remove('token');
                  pref.remove('sportid');
                  pref.remove('roleid');
                Get.to(const Loginscreen());
                }, child: Text("Yes",style: drawertxt,))
            ],
          );
    });
  }

  Widget expandmedia(){
    return Container(
      // height: displayheight(context)*0.15,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: background,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        )
      ),
      
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: drawerlisttile(Icons.ondemand_video, "Videos", const Videouploadscreen()),
          ),
          drawerdivider(),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: drawerlisttile(Icons.image, "Images", const Imageuploadscreen()),
          ),
        ],
      ),
    );
  }

  _backpress(BuildContext context){
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

  Widget Clubfavouritelist(){
    return Obx((){
      return RefreshIndicator(
        onRefresh: ()async{
          await getClubfavourite_Controller.getclubfavouritedata;
        },
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: getClubfavourite_Controller.getclubfavouritedata.take(3).length,
            itemBuilder: (BuildContext context,int index){
              var firstname=getClubfavourite_Controller.getclubfavouritedata[index];
              List favouritegetdata=getClubfavourite_Controller.getclubfavouritedata[index]['galleryData']??[];
              var gallerydata=favouritegetdata.firstWhere((element) => element['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gallerydata==null?
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: primary,
                      )
                          :
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(gallerydata),
                      ),
                      Text(firstname['favoriteUserData']['firstName'],style: chatnametxt,),
                      TextButton(
                          style: TextButton.styleFrom(backgroundColor:const  Color(0xFFE4E4FF)),
                          onPressed: (){
                            Map<String,dynamic> data=getClubfavourite_Controller.getclubfavouritedata[index];
                            Get.to(Favourite_club_view(data: data,));
                          }, child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                        child: Text("View Details",style: viewbtntxt,),
                      ))
                    ],
                  ),
                ),
              );
            }),
      );
    });
}

  Widget Coachfavouritelist(){
    return Obx((){
      return RefreshIndicator(
        onRefresh: ()async{
          await getallfavourite_controller.getallfavouritedata;
        },
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: getallfavourite_controller.getallfavouritedata.take(3).length,
            itemBuilder: (BuildContext context,int index){
              var firstname=getallfavourite_controller.getallfavouritedata[index];
              List favouritegetdata=getallfavourite_controller.getallfavouritedata[index]['galleryData']??[];
              var gallerydata=favouritegetdata.firstWhere((element) => element['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(gallerydata),
                      ),
                      Text(firstname['favoriteUserData']['firstName']??"",style: chatnametxt,),
                      TextButton(
                          style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                          onPressed: (){
                            Map<String,dynamic> data=getallfavourite_controller.getallfavouritedata[index];
                            Get.to( Favourite_coach_View(data:data));
                          }, child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                        child: Text("View Details",style: viewbtntxt,),
                      ))
                    ],
                  ),
                ),
              );
            }),
      );
    });
}

  Widget commonannouncement() {
    return Obx(
          () => announcementController.announcementdata.where((data) => data['announcement']['sportsId'] == 'general')
              .toList().isEmpty
              ? Container()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("General Announcement", style: profiletxthead),
                  ),
                  commondivider(Colors.grey.shade200),
                  SizedBox(
                    height: displayheight(context) * 0.15,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: announcementController.announcementdata
                          .where((data) => data['announcement']['sportsId'] == 'general')
                          .length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var filteredData = announcementController.announcementdata
                            .where((data) => data['announcement']['sportsId'] == 'general')
                            .toList();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: displayheight(context) * 0.07,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: displaywidth(context)*0.90,
                                child: SingleChildScrollView(
                                  child: HtmlWidget('''
                                  ${filteredData[index]['announcement']['announcementDescription']??''}
                                  ''',
                                    textStyle: chatnametxt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget Sportannouncement(){
    return Obx(() =>
    announcementController.announcementdata.isEmpty
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Sport Announcement", style: profiletxthead),
              ),
              commondivider(Colors.grey.shade200),
              SizedBox(
                height: displayheight(context) * 0.08,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: announcementController.announcementdata
                      .where((data) => data['announcement']['sportsId'] != 'general')
                      .length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var filteredData = announcementController.announcementdata
                        .where((data) => data['announcement']['sportsId'] != 'general')
                        .toList();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedindex = index;
                          });
                        },
                        child: Container(
                          height: displayheight(context) * 0.07,
                          decoration: BoxDecoration(
                            color: selectedindex == index
                                ? primary
                                : const Color(0xFFF3F2F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                filteredData[index]['sportData']['sportName'],
                                style: selectedindex == index
                                    ? profiletxtheadwhite
                                    : profiletxthead,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  '''
                    ${selectedindex != null
                      ? announcementController.announcementdata
                      .where((data) => data['announcement']['sportsId'] != 'general')
                      .toList()[selectedindex]['announcement']['announcementDescription']
                      : "Select a sport to view announcement description"}
                    ''',
                  textStyle: chatnametxt,
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}


