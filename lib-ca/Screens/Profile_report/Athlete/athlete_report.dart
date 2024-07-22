import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteSearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthletepublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/Athletesearchscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/Viewathletescreen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/add_athlete_screen.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class AthleteReport extends StatefulWidget {
  final List<Map<String,dynamic>> data;
  String age,gender,city,state,sport,subscription,publish;
   AthleteReport({super.key,required this.data,required this.subscription,required this.publish,required this.city,required this.sport,required this.state,required this.gender,required this.age});

  @override
  State<AthleteReport> createState() => _AthleteReportState();
}

class _AthleteReportState extends State<AthleteReport> {
  final GetallAthleteController getallAthleteController = Get.find<GetallAthleteController>();
  final AthletepublishController athletepublishController=Get.find<AthletepublishController>();
  final AthletesearchController athletesearchController=Get.find<AthletesearchController>();
  List<bool> _switchValues = [];
  int? selectedindex;

  updateathletedata()async{
    await     athletesearchController.AthletesearchApi(context, widget.sport, widget.state, widget.city, widget.age, widget.gender, widget.publish,widget.subscription);

  }
  @override
  void initState() {
    super.initState();
    updateathletedata();
    _switchValues = widget.data.map<bool>((athlete) => athlete['isPublish'] ?? false).toList();
    athletesearchController.AthletesearchApi(context, widget.sport, widget.state, widget.city, widget.age, widget.gender, widget.publish,widget.subscription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Athlete Report"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                readOnly: true,
                onTap: (){
                  Get.to(const Athletesearchscreen());
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  prefixIcon: const Icon(CupertinoIcons.search),
                  hintText: "Search here",
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Athlete Reports", style: subscriptiontxt),
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
                        Get.to(const add_athlete_screen());
                      },
                      child: Text("+ Add Athlete", style: subscriptionbtntxtwhite),
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
                  child: widget.data.isEmpty?
                      Center(child: Text("No Athlete Profile Found",style: viewtxt,),)
                      :RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: primary,
                    onRefresh: ()async{
                      await athletesearchController.AthletesearchApi(context, widget.sport, widget.state, widget.city, widget.age, widget.gender, widget.publish,widget.subscription);
                    },
                        child: ListView.builder(
                                            physics: const BouncingScrollPhysics(),
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
                                  child: _switchValues.isEmpty?
                                  const Center(child: CupertinoActivityIndicator(),)
                                      :CupertinoSwitch(
                                    value: _switchValues[index],
                                    onChanged: (bool value) {
                                      setState(() {
                                        _switchValues[index] = value;
                                        athletepublishController.AthletepublishApi(context, data['id'],value);
                                      });
                                    },
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(backgroundColor:const Color(0xFFE4E4FF)),
                                  onPressed: () {
                                    String sportid=widget.data[index]['sportsId'].toString();
                                    Get.to(Viewathletescreen(data: data,sportid:sportid));
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
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
