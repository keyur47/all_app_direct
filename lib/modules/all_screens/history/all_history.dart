import 'package:all_app_direct/modules/appbar/popupmenubutton/setting/theme.dart';
import 'package:all_app_direct/modules/controller/all_screen_controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllHistory extends StatefulWidget {
  const AllHistory({Key? key}) : super(key: key);

  @override
  _AllHistoryState createState() => _AllHistoryState();
}

class _AllHistoryState extends State<AllHistory> {
  AllScreenController controller = Get.find();
  ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.getContactsNumberList.isNotEmpty
          ? AnimationLimiter(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // physics: const BouncingScrollPhysics(
                    //     parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: AllScreenController.myContactScrollController,
                    padding: EdgeInsets.zero,
                    itemCount: controller.getContactsNumberList.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 1000),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 2.4,
                                top: SizeUtils.verticalBlockSize * 0.6,
                                bottom: SizeUtils.verticalBlockSize * 0.6,
                                right: SizeUtils.horizontalBlockSize * 2,
                              ),
                              child: GestureDetector(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeUtils.horizontalBlockSize * 2,
                                        // top: SizeUtils.verticalBlockSize * 1,
                                        // bottom: SizeUtils.verticalBlockSize * 1,
                                        right: SizeUtils.horizontalBlockSize * 2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: themeController.isSwitched.value ? AppColor.grey[200]:AppColor.darkBlue,
                                          child: Text(
                                            "+${controller.getContactsNumberList[index]}"
                                                .substring(0, 3)
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize:
                                                    SizeUtils.horizontalBlockSize *
                                                        4,
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
                                            onLongPress: () async {
                                              controller.textController.text =
                                                  "+${controller.getContactsNumberList[index]}";
                                            },
                                            child: Text(
                                              "+${controller.getContactsNumberList[index]}",
                                              style: TextStyle(
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      4.5),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            controller.url.value =
                                                "https://wa.me/+${controller.getContactsNumberList[index]}'?text=${controller.textController.text}";
                                            await launch(controller.url.value);
                                            print("------${controller.url.value}");
                                          },
                                          child: Icon(
                                            Icons.whatsapp,
                                            color: AppColor.appGreen,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: SizeUtils.verticalBlockSize * 2.5,)
                ],
              ),
            )
          : Center(child: noData()),
    );
  }
}
