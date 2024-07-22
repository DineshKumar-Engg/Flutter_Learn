import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_athelete/Screens/Coach/Coach%20Profile%20Details.dart';
import 'package:connect_athelete/Screens/Favourite%20List/Athlete/Favourite_Athlete_List.dart';
import 'package:connect_athelete/Screens/Favourite%20List/Athlete/Favourite_Athlete_View.dart';
import 'package:connect_athelete/Screens/Search%20List/Athlete/Athlete%20List.dart';
import 'package:connect_athelete/Screens/Search%20List/Athlete/Athlete%20search.dart';
import 'package:connect_athelete/Services/Announcement/Announcementbyrole.dart';
import 'package:connect_athelete/Services/Announcement/commonAnnouncement.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/Search%20service/athlete_search_api.dart';
import 'package:connect_athelete/Services/get%20data/City_list.dart';
import 'package:connect_athelete/Services/get%20data/Speciality_list.dart';
import 'package:connect_athelete/Services/get%20data/getall_cities.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/CMS Service/BannerImage_Controller.dart';
import '../../Services/CMS Service/cms_api.dart';
import '../../Services/Chat/GetChatList.dart';
import '../../Services/Coach Service/Coach Details Api.dart';
import '../../Services/get data/List Sports.dart';
import '../../Services/get data/state_list.dart';
import '../../widget/Divider.dart';
import '../../widget/Drawer Divider.dart';
import '../../widget/Drawer List Tile.dart';
import '../../widget/Loading.dart';
import '../../widget/decoration Container.dart';
import '../Athlete/About Us.dart';
import '../Athlete/ChatList.dart';
import '../Athlete/howits_works_screen.dart';
import '../Contact Us/Contact Us.dart';
import '../Favourite List/Coach/Favourite Coach List.dart';
import '../Login/Loginscreen.dart';
import '../Password/Changepassword.dart';
import '../Search List/Coach/Coach View.dart';


class CoachHomescreen extends StatefulWidget {
  const CoachHomescreen({super.key});

  @override
  State<CoachHomescreen> createState() => _CoachHomescreenState();
}

class _CoachHomescreenState extends State<CoachHomescreen> {

  String?stateid,cityid='0';
  String?sportid;
  String?allprofileimage;

  final ScrollController _scrollController = ScrollController();
  final CoachProfileController coachProfileController=Get.find<CoachProfileController>();
  final SpecialitylistController specialitylistController=Get.find<SpecialitylistController>();
  final Sportslistcontroller sportslistcontroller=Get.find<Sportslistcontroller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final AthleteSearchController athleteSearchController=Get.find<AthleteSearchController>();
  final CitylistController citylistController=Get.find<CitylistController>();
  final GetallCitiesController getallCitiesController=Get.find<GetallCitiesController>();
  final CMSController cmsController=Get.find<CMSController>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  final BannerImageController bannerImageController=Get.find<BannerImageController>();
  final CommonAnnouncementController commonAnnouncementController=Get.find<CommonAnnouncementController>();
  final AnnouncementController announcementController=Get.find<AnnouncementController>();
  final GetChatlistController getChatlistController=Get.find<GetChatlistController>();
  final SettingController settingController=Get.find<SettingController>();



  Future<void> sportdata()async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var id=shref.getString("sportid");
    sportid=id??'';
  }
  @override
  void initState() {
    sportdata().then((_) {
      athleteSearchController.AthleteSearchApi(context, sportid, 0, 0,"09,10,11,12,13,14,15,16,17,18+","Male,Female,Others");
      sportslistcontroller.sportslistapi(context);
      statelistController.StatelistApi(context);
      coachProfileController.CoachProfileApi(context);
      specialitylistController.SpecialityApi(context);
      getallCitiesController.GetallCitiesApi(context);
      cmsController.cmsapi(context,1);
      bannerImageController.bannerimageapi(context, 8);
      commonAnnouncementController.CommonAnnouncementApi(context);
      Future.value( getallfavourite_controller.Getfavourite_Api(context,"2"));
      announcementController.AnnouncementApi(context, 3);
      getChatlistController.GetChatListApi(context);
      settingController.SettingApi(context);
      List getgallerydata=coachProfileController.coachprofiledata[0]['galleryData']??[];
      var profileimage=getgallerydata.firstWhere((image)=>image['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
      allprofileimage=profileimage;
    }
    );
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  int container=1;
  bool?media=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()=>_backpress(),
        child: Obx(
              ()=>
          coachProfileController.coachprofiledata.isEmpty?
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:70.0),
                        child: Container(
                          height: displayheight(context)*0.15,
                          color:const Color(0xFFF1F1F1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                allprofileimage==null?const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: primary,
                                  child: Icon(Icons.person,color: Colors.white,),
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
                                      Text("${coachProfileController.coachprofiledata[0]['userData']['firstName']+" "+coachProfileController.coachprofiledata[0]['userData']['lastName']??''}",style: profileheadindtxt,),
                                      Text("Coach",style: profilesubheadindtxt,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      drawerlisttile(Icons.person, "Profile Details", const CoachProfiledetails()),
                      drawerdivider(),
                      drawerlisttile(Icons.info, "About Us", const Aboutus_screen()),
                      drawerdivider(),
                      drawerlisttile(Icons.lock_open_rounded, "Change Password",  ChangePasswordnew(route:"coach")),
                      drawerdivider(),
                      drawerlisttile(Icons.sports, "Search Athlete", const Athletesearchscreen()),
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
    var sportname=coachProfileController.coachsportdata.map((element) => element['sportName']).toList().join(',');
    List images = bannerImageController.cmsgallery.toList();
    List getgallerydata=coachProfileController.coachprofiledata[0]['galleryData']??[];
    var profileimage=getgallerydata.firstWhere((image)=>image['fileType']=="Profile Image",orElse: ()=>{'fileLocation':''})['fileLocation'];
    allprofileimage=profileimage;
    return Column(
      children: [
        Container(
          // height: displayheight(context)*0.12,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Hi",style: profiletxtyellow,),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("${coachProfileController.coachprofiledata[0]['userData']['firstName']??''}",style: profilenametxt,),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: CarouselSlider.builder(
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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        showloadingdialog(context);
                        List<Map<String,dynamic>> data=athleteSearchController.athletesearchdata.cast();
                        Navigator.pop(context);
                        Get.to( Athletelistscreen(data: data));
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
                                    child: Text("Hey ! ${coachProfileController.coachprofiledata[0]['userData']['firstName']??''}",style: homebantxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Find the best $sportname Player near you",style: homesubbantxt,),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded,color:Colors.white,size: 30,)
                            ],
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
                        decoration:   BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Favorite Athlete list ",style: profiletxthead,),
                              TextButton(onPressed: (){
                                List<Map<String,dynamic>> data=getallfavourite_controller.getallfavouritedata.cast();
                                Get.to( Favourite_athlete_list_screen(data: data,));
                              }, child:  Text("See All",style: profiletxthead,))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: getallfavourite_controller.getallfavouritedata.isEmpty?
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No Profile Found in Favourite"),
                              ),
                            )
                            :Athletefavouritelist()
                      ),
                    ],),
                ),
                announcementController.announcementdata.where((data) => data['announcement']['sportsId'] != 'general').toList().isEmpty?
                    Container()
                    :Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sport Announcement",style: profiletxthead,),
                          ),
                          commondivider(Colors.grey.shade200),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  HtmlWidget(
                              '''
                    ${announcementController.announcementdata.where((data) => data['announcement']['sportsId'] != 'general').toList()[0]['announcement']['announcementDescription']??''
                                  }
                    ''',
                              textStyle: chatnametxt,
                            ),
                          )
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
                            decorationcontainer(Icons.person, "Profile", const CoachProfiledetails()),
                            decorationcontainer(Icons.sports_handball, "Athlete", const Athletesearchscreen()),
                            decorationcontainer(Icons.lock_open_rounded, "Password",  ChangePasswordnew(route: "coach")),
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

  _backpress(){
    return showDialog(
        context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text("Are you sure you want to Exit Connect Athlete!",style:drawertxt1 ,),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context,false);}, child: Text("No",style: drawertxt,)),
          TextButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Yes",style: drawertxt,))
        ],
      );
    });
  }

  Widget Athletefavouritelist(){
    return Obx((){
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: getallfavourite_controller.getallfavouritedata.take(3).length,
          itemBuilder: (BuildContext context,int index){
            var data=getallfavourite_controller.getallfavouritedata[index];
            List favouritegetdata=getallfavourite_controller.getallfavouritedata[index]['galleryData']??'';
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
                    gallerydata==null? const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    ):CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(gallerydata),
                    ),
                    Text(data['favoriteUserData']['firstName']??'',style: chatnametxt,),
                    TextButton(
                        style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                        onPressed: (){
                          Get.to( Favourite_Athlete_View(data: data));
                        }, child: Text("View Details",style: viewbtntxt,))
                  ],
                ),
              ),
            );
          });
    });
  }
  Widget commonannouncement() {
    return Obx(
          () =>announcementController
              .announcementdata
              .where((data) =>
          data['announcement']['sportsId'] == 'general')
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
                child: Text(
                  "General Announcement",
                  style: profiletxthead,
                ),
              ),
              commondivider(Colors.grey.shade200),
              SizedBox(
                height: displayheight(context) * 0.20,
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    var filteredData = announcementController
                        .announcementdata
                        .where((data) =>
                    data['announcement']['sportsId'] == 'general')
                        .toList();
                    return filteredData.isEmpty
                        ? Container()
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredData.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: displayheight(context) * 0.07,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SizedBox(
                                width:
                                displaywidth(context) * 0.90,
                                child: SingleChildScrollView(
                                  child: HtmlWidget(
                                    '''
                                              ${filteredData[index]['announcement']['announcementDescription'] ?? ''}
                                              ''',
                                    textStyle: chatnametxt,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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

}
