import 'package:connect_athelete/Screens/Search%20List/Athlete/Athlete%20View.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../widget/Appbar.dart';
import '../Coach/Coach View.dart';

class Athletelistscreen extends StatefulWidget {
  List<Map<String,dynamic>> data;
   Athletelistscreen({super.key,required this.data});

  @override
  State<Athletelistscreen> createState() => _AthletelistscreenState();
}

class _AthletelistscreenState extends State<Athletelistscreen> {

  void data() async{
    await widget.data;
}
  @override
  void initState() {
    data();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar: appbarwidget("Athlete List"),
      body: Column(
        children: [
          Container(
            height: displayheight(context)*0.08,
            color: newyellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: displaywidth(context)*0.25,
                      child: Text("Profile",style:searchbtntxt,)),
                  SizedBox(
                      width: displaywidth(context)*0.30,
                      child: Text("Athlete Name",style:searchbtntxt,)),
                  SizedBox(
                      width: displaywidth(context)*0.30,
                      child: Text("",style:searchbtntxt,))
                ],
              ),
            ),
          ),
          Expanded(
            // height: displayheight(context)*0.79,
            child: widget.data.isEmpty? Center(
              child: Text("No Profile Found",style: profiletxtheadtxt,),):ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context,int index){
                  List gallerydata=widget.data[index]['user']['galleries']??[];
                  var profileimage=gallerydata.firstWhere((element) => element['fileType']=="Profile Image",orElse: () => {'fileLocation': ''},)['fileLocation'];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:  Colors.black.withOpacity(0.05000000074505806))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          gallerydata.isEmpty?const CircleAvatar(
                             radius: 30,
                            backgroundColor: Colors.grey,
                            child: Center(
                              child: Icon(Icons.person,color: Colors.white,),
                            ),
                          ):
                          CircleAvatar(
                              radius:30,
                              backgroundImage: NetworkImage("$profileimage"),),
                          Text(widget.data[index]['user']['firstName']??'',style: chatnametxt,),
                          TextButton(
                              style: TextButton.styleFrom(backgroundColor:const  Color(0xFFE4E4FF)),
                              onPressed: (){
                                  Map<String,dynamic>data=widget.data[index];
                                  Get.to( Athleteviewscreen(data:data));

                              }, child: Text("View Details",style: viewbtntxt,))
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
