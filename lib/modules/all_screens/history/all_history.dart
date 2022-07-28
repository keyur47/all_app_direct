import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllHistory extends StatefulWidget {
  const AllHistory({Key? key}) : super(key: key);

  @override
  _AllHistoryState createState() => _AllHistoryState();
}

class _AllHistoryState extends State<AllHistory> {
  AllScreenController controller = Get.find();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    controller.setContactsNumberList = await SharedPrefs.getNumberList();
    controller.getContactsNumberList = controller.setContactsNumberList.toSet().toList();
    setState(() {
      controller.setContactsNumberList.join("");
      controller.getContactsNumberList.join("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller.getContactsNumberList.isNotEmpty
        ? ListView.builder(
          controller: AllScreenController.myContactScrollController,
          padding: EdgeInsets.zero,
          itemCount: controller.getContactsNumberList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: SizeUtils.horizontalBlockSize * 2.4,
                  top: SizeUtils.verticalBlockSize * 0.6,
                  bottom: SizeUtils.verticalBlockSize * 0.6,
                  right: SizeUtils.horizontalBlockSize * 2,
              ),
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
                            "+${controller.getContactsNumberList[index]}"
                                .substring(0, 3)
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
                                  controller.numberController.text =
                                  "+${controller.getContactsNumberList[index]}";
                                },
                                child: Text(
                                  "+${controller.getContactsNumberList[index]}",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize *
                                              4.5),
                                ))),
                        GestureDetector(
                          onTap: () async {
                            controller.url.value =
                            "https://wa.me/+${controller.getContactsNumberList[index]}'?text=${controller.textController.text}";
                            await launch(controller.url.value);
                            print("------${controller.url.value}");
                          },
                          child: Icon(
                            Icons.whatsapp,
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
        : Center(child: Text(""));
  }
}
