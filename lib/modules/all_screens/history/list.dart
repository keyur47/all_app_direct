import 'package:all_app_direct/modules/controller/controller.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ListData extends StatelessWidget {
  ListData({Key? key}) : super(key: key);
  AllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.contacts!.length,
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeUtils.horizontalBlockSize * 6,
                  right: SizeUtils.horizontalBlockSize * 6,
                  top: SizeUtils.verticalBlockSize * 1,
                  bottom: SizeUtils.horizontalBlockSize * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.darkBlue,
                    child: Text(
                      controller.contacts![index].displayName
                          .substring(0, 1)
                          .toUpperCase(),
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
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
                          child:
                              Text(controller.contacts![index].displayName))),
                  GestureDetector(
                    onTap: () async {
                      final fullContact = await FlutterContacts.getContact(
                          controller.contacts![index].id);
                      controller.numberController.text =
                          fullContact!.phones.first.number;
                    },
                    child: Icon(
                      Icons.whatsapp,
                      color: AppColor.appColors,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
