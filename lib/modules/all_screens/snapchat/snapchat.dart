import 'package:all_app_direct/ads/ads.dart';
import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/modules/openbutton/oepn_username_snapchat.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/assets_path.dart';
import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:all_app_direct/widgets/custom_textfield.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class Snapchat extends StatefulWidget {

  @override
  _SnapchatState createState() => _SnapchatState();
}

class _SnapchatState extends State<Snapchat> {
  AllScreenController controller = Get.find();



  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    controller.setSnapchatUsernameList = await SharedPrefs.getSnapchatString();
    controller.getSnapchatUsernameList = controller.setSnapchatUsernameList.toSet().toList();
    setState(() {
      controller.setSnapchatUsernameList.join("");
      controller.getSnapchatUsernameList.join("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigation.popAndPushNamed(Routes.telegram);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                customAppbar(
                  text: StringsUtils.snapchatDirects,
                  icon: Icons.snapchat,
                  iconColor: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.darkBlue,
                        AppColor.darkBlue,

                      ]),
                  top: SizeUtils.horizontalBlockSize *1,
                  bottom: SizeUtils.horizontalBlockSize *1.1,
                  right: SizeUtils.horizontalBlockSize *1.4,
                  left:SizeUtils.horizontalBlockSize * 1.4,
                  size: SizeUtils.horizontalBlockSize *10,
                  directText: StringsUtils.snapchatDirects,
                ),
                Padding(
                  padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4, right:SizeUtils.horizontalBlockSize *  4, top:SizeUtils.horizontalBlockSize *  2),
                  child: Column(
                    children: [
                      usernameTextField(
                          controller: controller.snapchatUsernameController,
                          showCursor: false,
                          hintText: StringsUtils.username,
                          textInputType: TextInputType.none,
                          onTap: () async {
                            controller.snapchatUsernameController.clear();
                          },
                    longPress: ()async {
                      controller.instagramUsernameController.clear();
                    }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize* 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [OpenUserNameSnapchat()],
                ),

                Expanded(
                    child: controller.getSnapchatUsernameList.isNotEmpty
                        ? ListView.builder(
                      controller:
                      AllScreenController.myContactScrollController,
                      padding: EdgeInsets.zero,
                      itemCount:
                      controller.getSnapchatUsernameList.length,
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
                                    left:
                                    SizeUtils.horizontalBlockSize * 2,
                                    // top: SizeUtils.verticalBlockSize * 1,
                                    // bottom: SizeUtils.verticalBlockSize * 1,
                                    right: SizeUtils.horizontalBlockSize *
                                        2),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.darkBlue,
                                      //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                      child: Text(
                                        "${controller.getSnapchatUsernameList[index]}"
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: SizeUtils
                                                .horizontalBlockSize *
                                                4,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      SizeUtils.horizontalBlockSize *
                                          3,
                                    ),
                                    Expanded(
                                        child: GestureDetector(
                                            onTap: () async {
                                              controller.textController
                                                  .text =
                                              "${controller.getSnapchatUsernameList[index]}";
                                            },
                                            child: Text(
                                              "${controller.getSnapchatUsernameList[index]}",
                                              style: TextStyle(
                                                  fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                      4.5),
                                            ))),
                                    GestureDetector(
                                      onTap: () async {
                                        controller.url.value =
                                        "instagram://user?username=${controller.getSnapchatUsernameList[index]}";
                                        await launch(
                                            controller.url.value);
                                        print(
                                            "------${controller.url.value}");
                                      },
                                      child: Icon(
                                        BootstrapIcons.snapchat,
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
                        : Center(child: Image.asset(AssetsPath.noData)))

              ],
            ),
            Container(
              child:  BannerAds(),
            ),
          ],
        ),
      ),
    );
  }
}
