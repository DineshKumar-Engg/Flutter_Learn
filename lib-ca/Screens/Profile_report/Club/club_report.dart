import 'package:connect_athlete_admin/Screens/Profile_report/Club/Addclubscreen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubpublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/Clubsearchscreen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/GetallClubController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/Viewclubscreen.dart';
import 'package:connect_athlete_admin/service/CitylistController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class club_report extends StatefulWidget {
  final List<Map<String,dynamic>> data;
   String sport,city,state,subscription,publish;
   club_report({super.key,required this.data,required this.publish,required this.state,required this.city,required this.subscription,required this.sport});

  @override
  State<club_report> createState() => _club_reportState();
}

class _club_reportState extends State<club_report> {

  final ClubpublishController clubpublishController=Get.find<ClubpublishController>();
  final GetallCitylistController getcitylistController=Get.find<GetallCitylistController>();
  final ClubsearchController clubsearchController=Get.find<ClubsearchController>();
  int?selectedindex;
  List<bool> _switchValues = [];

  @override
  void initState() {
        _switchValues=widget.data.map<bool>((club)=>club['isPublish']??false).toList();
        getcitylistController.GetCitylistApi(context);
        clubsearchController.ClubsearchApi(context,widget.sport, widget.state, widget.city, widget.publish, widget.subscription);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Club & Academic Report"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                autofocus: false,
                readOnly: true,
                onTap: (){
                  Get.to(const Clubsearchscreen());
                },
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    prefixIcon: const Icon(CupertinoIcons.search),
                    hintText: "Search Club & Academics here",
                    hintStyle: inputtxt,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Club & Academy Reports", style: subscriptiontxt),
                  SizedBox(
                    height: displayheight(context) * 0.05,
                    width: displaywidth(context) * 0.40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.to(const Addclubscreen());
                      },
                      child: Text("+ Add Academic", style: subscriptionbtntxtwhite),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.12,
                            child: Text("Profile", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.20,
                            child: Text("First Name", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.15,
                            child: Center(child: Text("Publish", style: listheadingtxt)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.20,
                            child: Text("", style: listheadingtxt),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: displayheight(context) * 0.69,
                  width: double.infinity,
                  child:widget.data.isEmpty
                        ? Center(child: Text("No Club & Academic Profile Found",style: viewtxt,),)
                        : RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: secondary,
                      onRefresh: () async {
                        await clubsearchController.ClubsearchApi(context,widget.sport, widget.state, widget.city, widget.publish, widget.subscription);
                        setState(() {
                          _switchValues = widget.data.map<bool>((club) => club['isPublish'] ?? false).toList();
                        });
                      },
                      child: ListView.builder(
                        itemCount: widget.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data = widget.data[index];
                          List gallerydata = data['user']['galleries'] ?? [];
                          var profileimage = gallerydata.firstWhere((item) => item['fileType'] == "Profile Image", orElse: () => {'fileLocation': ''})['fileLocation'];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: selectedindex == index ? const Color(0XFFD4D5E2) : Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: displaywidth(context) * 0.15,
                                      child: gallerydata.isEmpty
                                          ? const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.grey,
                                        child: Center(child: Icon(Icons.person, color: Colors.white)),
                                      )
                                          : CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage("${profileimage}"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.35,
                                      child: Center(
                                        child: Text("${data['user']['firstName'].substring(0,1).toUpperCase()+data['user']['firstName'].substring(1).toLowerCase()}" ?? '',
                                          style: listsubheadingtxt,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: displaywidth(context) * 0.20,
                                      child: _switchValues.isEmpty?const Center(child: CupertinoActivityIndicator(),):CupertinoSwitch(
                                        value: _switchValues[index],
                                        onChanged: (bool value) {
                                          setState(() {
                                            _switchValues[index] = value;
                                            clubpublishController.ClubpublishApi(context, data['id'], value);
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                                      onPressed: () {
                                        Get.to(Viewclubscreen(data: data));
                                      },
                                      child: Text("View Details", style: viewbtntxt),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

