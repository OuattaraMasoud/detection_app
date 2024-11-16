import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:detectionApp/widgets/image_fom_controller.dart';
import 'package:dotted_border/dotted_border.dart';
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
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: imageFormFieldMinWidth ?? 0.90.sw,
                          minHeight: imageFormFieldMinHeight ?? 0.20.sh,
                          maxHeight: imageFormFieldMaxHeight ?? double.infinity,
                          maxWidth: imageFormFieldMaxWidth ?? double.infinity,
                        ),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey.shade400,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 8.h),
                              side: BorderSide(
                                color: Colors.grey.shade800,
                                width: 0.35,
                                style: BorderStyle.solid,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ), // Text and icon color
                              backgroundColor:
                                  Colors.transparent, // Background color
                            ),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedImage = await picker.pickImage(
                                  imageQuality: 30, source: ImageSource.camera);
                              if (onChanged != null) {
                                onChanged(pickedImage);
                              }
                              state.didChange(pickedImage);
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 50.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      initialValue != null
                                          ? initialValue.name
                                          : 'Glisser ou cliquer pour choisir une image',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )),
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
                                  fontSize: 13.0,
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
