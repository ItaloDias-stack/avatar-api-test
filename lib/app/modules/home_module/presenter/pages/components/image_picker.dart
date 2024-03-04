import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/shared/utils/custom_colors.dart';
import 'package:flutter_leap_v2/shared/utils/fonts.dart';
import 'package:flutter_leap_v2/shared/utils/helpers/image_picker_helper.dart';
import 'package:flutter_leap_v2/shared/utils/misc.dart';

showChooseCameraOrFilesModal({
  required BuildContext context,
  required Function(File) imageAdded,
}) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: CustomColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 250,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 30,
                  color: CustomColors.secondary,
                ),
                Text(
                  "CHOOSE IMAGE",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(width: 30),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBigButton(
                  width: 134,
                  height: 134,
                  onTap: () async {
                    Navigator.pop(context);
                    if (await askCameraPermission()) {
                      pushToCameraScreen(
                        context: context,
                        onFileAdded: (file) async {
                          imageAdded(
                            File(file),
                          );
                        },
                      );
                    }
                  },
                  text: "Câmera",
                  backgroundColor: CustomColors.secondary,
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                ),
                const SizedBox(width: 20),
                CustomBigButton(
                  width: 134,
                  height: 134,
                  onTap: () async {
                    Navigator.pop(context);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
                    );

                    if (result != null) {
                      for (var element in result.paths) {
                        imageAdded(
                          File(element!),
                        );
                      }
                    }
                  },
                  text: "Galeria",
                  backgroundColor: CustomColors.secondary,
                  icon: Icon(Icons.image_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

class CustomBigButton extends StatelessWidget {
  final double width;
  final double height;
  final Function() onTap;
  final Color? backgroundColor;
  final String text;
  final Widget icon;
  const CustomBigButton({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    this.backgroundColor,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor?.withOpacity(.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: CustomColors.black,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 17),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Fonts.mobileAction2,
            )
          ],
        ),
      ),
    );
  }
}
