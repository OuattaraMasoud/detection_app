import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:detectionApp/widgets/image_fom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ImageFormField extends FormField<XFile> {
  ImageFormField({
    String? imageName,
    double? imageFormFieldMinHeight,
    double? imageFormFieldMaxHeight,
    double? imageFormFieldMinWidth,
    double? imageFormFieldMaxWidth,
    Key? key,
    FormFieldSetter<XFile>? onSaved,
    FormFieldSetter<XFile>? onChanged,
    required FormFieldValidator<XFile> validator,
    XFile? initialValue,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<XFile> state) {
              return Builder(
                builder: (context) {
                  return Column(
                    children: [
                      initialValue == null
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: imageFormFieldMinWidth ?? 0.90.sw,
                                minHeight: imageFormFieldMinHeight ?? 0.20.sh,
                                maxHeight:
                                    imageFormFieldMaxHeight ?? double.infinity,
                                maxWidth:
                                    imageFormFieldMaxWidth ?? double.infinity,
                              ),
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 8.h),
                                    side: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    primary: Colors
                                        .grey.shade200, // Text and icon color
                                    backgroundColor:
                                        Colors.transparent, // Background color
                                  ),
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedImage = await picker.pickImage(
                                        imageQuality: 30,
                                        source: ImageSource.camera);
                                    if (onChanged != null) {
                                      onChanged(pickedImage);
                                    }
                                    state.didChange(pickedImage);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60.h,
                                        width: 15.w,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: secondaryColor),
                                        child: Icon(
                                          Icons.arrow_upward,
                                          size: 20.h,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        imageName ?? 'Photo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          : ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 0.7.sw,
                                maxWidth: 0.7.sw,
                                minHeight: 150.h,
                              ),
                              child: Column(
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      child: Ink.image(
                                        image: FileImage(
                                          File(initialValue.path),
                                        ),
                                        fit: BoxFit.cover,
                                        height: 150.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.grey.withOpacity(0.9),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final picker = ImagePicker();
                                        final pickedImage =
                                            await picker.pickImage(
                                                source: ImageSource.camera);
                                        if (onChanged != null) {
                                          onChanged(pickedImage);
                                        }
                                        state.didChange(pickedImage);
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      if (state.hasError) ...[
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              AutoSizeText(
                                state.errorText!,
                                style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 13.0.sp,
                                ),
                                maxLines: 2,
                                minFontSize: 11,
                              ),
                            ],
                          ),
                        )
                      ]
                    ],
                  );
                },
              );
            });
}
