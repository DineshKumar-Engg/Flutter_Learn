import 'package:connect_athlete_admin/Screens/Profile_report/Coach/Addcoachscreen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachPublishController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/Coachsearchscreen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/GetallCoachController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/Viewcoachscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class coach_report extends StatefulWidget {
  final List<Map<String,dynamic>> data;
  String city,state,sport,publish;
   coach_report({super.key,required this.data,required this.city,required this.state,required this.sport,required this.publish});

  @override
  State<coach_report> createState() => _coach_reportState();
}

class _coach_reportState extends State<coach_report> {

  final GetallCoachController getallCoachController=Get.find<GetallCoachController>();
  final CoachpublishController coachpublishController=Get.find<CoachpublishController>();
  int?selectedindex;
  List <bool> _switchValues=[];

  @override
  void initState() {
        _switchValues=widget.data.map<bool>((coach)=>coach['isPublish']??false).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Coach Report"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                readOnly: true,
                onTap: (){
                  Get.to(const Coachsearchscreen());
                },
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    prefixIcon: const Icon(CupertinoIcons.search),
                    hintText: "Search Coach here",
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
                  Text("Coach Reports", style: subscriptiontxt),
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
                        Get.to(const Addcoachscreen());
                      },
                      child: Text("+ Add Coach", style: subscriptionbtntxtwhite),
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
                  height: displayheight(context) * 0.68,
                  width: double.infinity,
                  child:widget.data.isEmpty
                        ? Center(child: Text("Coach Profile Not Found",style: viewtxt,))
                        : RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: secondary,
                      onRefresh: () async {
                        await widget.data;
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
                                        child: Text("${data['user']['firstName'].substring(0, 1).toUpperCase()+data['user']['firstName'].substring(1).toLowerCase()}",
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
                                            coachpublishController.CoachpublishApi(context, data['id'], value);
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                                      onPressed: () {
                                        Get.to(Viewcoachscreen(data: data));
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
