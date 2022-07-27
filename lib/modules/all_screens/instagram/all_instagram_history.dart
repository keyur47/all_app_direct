import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllInstgramHistory extends StatefulWidget {
  const AllInstgramHistory({Key? key}) : super(key: key);

  @override
  _AllInstgramHistoryState createState() => _AllInstgramHistoryState();
}

class _AllInstgramHistoryState extends State<AllInstgramHistory> {
  AllScreenController controller = Get.find();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    controller.setInstagramUsernameList = await SharedPrefs.getInstagramList();
    controller.getInstagramUsernameList =
        controller.setInstagramUsernameList.toSet().toList();
    setState(() {
      controller.setInstagramUsernameList.join("");
      // controller.getContactsNumberList.join("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller.getInstagramUsernameList.isNotEmpty
        ? ListView.builder(
          controller: AllScreenController.myContactScrollController,
          padding: EdgeInsets.zero,
          itemCount: controller.getInstagramUsernameList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: SizeUtils.horizontalBlockSize * 2.4,
                  top: SizeUtils.verticalBlockSize * 1.2,
                  right: SizeUtils.horizontalBlockSize * 2),
              child: GestureDetector(
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.black12,
                  //     borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeUtils.horizontalBlockSize * 2,
                        // top: SizeUtils.verticalBlockSize * 1,
                        // bottom: SizeUtils.verticalBlockSize * 1,
                        right: SizeUtils.horizontalBlockSize * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColor.darkBlue,
                          //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child: Text(
                            "${controller.getInstagramUsernameList[index]}"
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 3,
                        ),
                        Expanded(
                            child: GestureDetector(
                                onTap: () async {
                                  controller.textController.text =
                                  "@${controller.getInstagramUsernameList[index]}";
                                },
                                child: Text(
                                  "+${controller.getInstagramUsernameList[index]}",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize *
                                              4.5),
                                ))),
                        GestureDetector(
                          onTap: () async {
                            controller.url.value = "instagram://user?username=${controller.getInstagramUsernameList[index]}";
                            await launch(controller.url.value);
                            // controller.url.value =
                            // "https://wa.me/+${controller.getContactsNumberList[index]}'?text=${controller.textController.text}";
                            // await launch(controller.url.value);
                            // print("------${controller.url.value}");
                          },
                          child: Icon(
                            Icons.integration_instructions,
                            color: AppColor.appColors,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
        : Center(child: Text("sfsd"));
  }
}
