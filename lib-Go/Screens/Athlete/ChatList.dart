import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Screens/Athlete/Chat%20screen.dart';
import 'package:connect_athelete/Services/Chat/GetChatList.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:connect_athelete/widget/Loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListscreen extends StatefulWidget {
  const ChatListscreen({super.key});

  @override
  State<ChatListscreen> createState() => _ChatListscreenState();
}

class _ChatListscreenState extends State<ChatListscreen> {
  final GetChatlistController getChatlistController = Get.find<GetChatlistController>();

  @override
  void initState() {
    super.initState();
    getChatlistController.GetChatListApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Chat"),
      body: SizedBox(
        height: displayheight(context) * 1,
        width: double.infinity,
        child: getChatlistController.getchatlistdata.isEmpty
            ? Center(child: Text("No Profile Found", style: inputtxt,))
            : Obx(
              () => RefreshIndicator(
            backgroundColor: primary,
            color: Colors.white,
            onRefresh: () async {
              await getChatlistController.GetChatListApi(context);
            },
            child: ListView.builder(
              itemCount: getChatlistController.getchatlistdata.length,
              itemBuilder: (BuildContext context, int index) {
                var galleries = getChatlistController.getchatlistdata[index]['galleries'];
                String imageUrl = galleries.isNotEmpty ? galleries[0]['fileLocation'] : '';
                return InkWell(
                  onTap: () {
                    Get.to(Chatscreen(
                      name: getChatlistController.getchatlistdata[index]['firstName'],
                      id: getChatlistController.getchatlistdata[index]['id'],
                      image:imageUrl,
                      email:getChatlistController.getchatlistdata[index]['email']
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: newgrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : null,
                                child: imageUrl.isEmpty ? const Icon(Icons.person) : null,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  getChatlistController.getchatlistdata[index]['firstName'] +
                                      " " +
                                      getChatlistController.getchatlistdata[index]['lastName'],
                                  style: chatnametxt,
                                ),
                              )
                            ],
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
      ),
    );
  }
}
