import 'dart:typed_data';

import 'package:all_app_direct/helper/shared_preferences.dart';
import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyContactList extends StatefulWidget {
  MyContactList({Key? key}) : super(key: key);

  @override
  State<MyContactList> createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>   ListView.builder(
        controller: AllScreenController.myContactScrollController,
        padding: EdgeInsets.zero,
        itemCount: controller.contacts!.length,
        itemBuilder: (context, index) {
          Uint8List? image = controller.contacts![index].photo;
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
                        child: (controller.contacts![index].photo == null)
                            ? CircleAvatar(
                                backgroundColor: AppColor.darkBlue,
                                //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                child: Text(
                                  controller.contacts![index].displayName
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: SizeUtils.horizontalBlockSize * 5,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: MemoryImage(image!)),
                      ),
                      SizedBox(
                        width: SizeUtils.horizontalBlockSize * 3,
                      ),
                      Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final fullContact =
                                    await FlutterContacts.getContact(
                                        controller.contacts![index].id);
                                controller.numberController.text =
                                    fullContact!.phones.first.number;
                              },
                              child: Text(controller
                                  .contacts![index].displayName,style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4.5),))),
                      GestureDetector(
                        onTap: () async {
                          // controller.photo.value =
                          //     await FlutterContacts.openExternalPick().toString();
                          // final fullContact = await FlutterContacts.getContact(
                          //     controller.contacts![index].id);
                          // controller.numberController.text =
                          //     fullContact!.phones.first.number;
                          final fullContact =
                              await FlutterContacts.getContact(
                                  controller.contacts![index].id);
                          controller.url.value =
                              "https://wa.me/+${fullContact!.phones.first.number}'?text=${controller.textController.text}";
                          await launch(controller.url.value);
                          print("------${controller.url.value}");
                          controller.contactsNumberList.addAll([
                            (controller
                                    .contactListHistory[index].number ??
                                "")
                          ]);
                          await SharedPrefs.setNumberList(
                              controller.contactsNumberList);
                          print(
                              "contactsNumberList:-${controller.contactsNumberList}");
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
      ),
    );
  }
}
