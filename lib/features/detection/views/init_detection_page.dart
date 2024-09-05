import 'package:detectionApp/constants.dart';
import 'package:detectionApp/features/dashboard/components/header.dart';
import 'package:detectionApp/features/detection/bloc/file_picker_bloc.dart';
import 'package:detectionApp/widgets/image_fom_controller.dart';
import 'package:detectionApp/widgets/image_fom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitDetectionPage extends StatefulWidget {
  static const routeName = 'InitDetectionPageView';
  const InitDetectionPage({super.key});

  @override
  State<InitDetectionPage> createState() => _InitDetectionPageState();
}

class _InitDetectionPageState extends State<InitDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: BlocProvider(
          create: (context) => FilePickerBloc(FilePickerState()),
          child: BlocBuilder<FilePickerBloc, FilePickerState>(
            builder: (context, filePickerState) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Header(title: 'Détection'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First Column with text details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      "Caracteristique-minier-ofmap/1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  Text(
                                      "Model Type: RobotFlow 3.0 Object Detection (Fast)"),
                                  Text("Checkpoint: COCO"),
                                ],
                              ),
                            ),
                            // Wrap with indicator components
                            Wrap(
                              spacing: 5.w, // Space between components
                              runSpacing: 5.h, // Space between rows if wrapped
                              children: [
                                _buildIndicatorComponent(
                                    "mAP", 50.0, Colors.pink),
                                _buildIndicatorComponent(
                                    "Precision", 43.6, Colors.blue),
                                _buildIndicatorComponent(
                                    "Recall", 56.6, Colors.amber),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0.h),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      side: BorderSide(
                                          color: Colors.pink, width: 0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary:
                                          Colors.pink, // Text and icon color
                                      backgroundColor: Colors
                                          .transparent, // Background color
                                    ),
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.assessment_outlined,
                                          color: Colors.pink,
                                          size: 14.sp,
                                        ),
                                        SizedBox(
                                            width: 5
                                                .w), // Add spacing between icon and text
                                        Text(
                                          'Detailed Modele Evaluation',
                                          style: TextStyle(color: Colors.pink),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      side: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary: Colors
                                          .grey.shade200, // Text and icon color
                                      backgroundColor: Colors
                                          .transparent, // Background color
                                    ),
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.stacked_bar_chart_outlined,
                                          size: 14.sp,
                                        ),
                                        SizedBox(
                                            width: 5
                                                .w), // Add spacing between icon and text
                                        Text(
                                          'Performance By Class',
                                          style: TextStyle(
                                              color: Colors.grey.shade200),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(5),
                                      side: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      primary: Colors
                                          .grey.shade200, // Text and icon color
                                      backgroundColor: Colors
                                          .transparent, // Background color
                                    ),
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.ssid_chart_outlined,
                                          size: 14.sp,
                                        ),
                                        SizedBox(
                                            width: 5
                                                .w), // Add spacing between icon and text
                                        Text(
                                          'Visualize Model',
                                          style: TextStyle(
                                              color: Colors.grey.shade200),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text("Deploy Your Model"),
                            ),
                            BlocProvider(
                              create: (context) => FilePickerBloc(
                                  FilePickerState(pickedImage: XFile(""))),
                              child: ImageFormField(
                                initialValue: filePickerState.pickedImage,
                                imageName: "Sélectionner une image",
                                validator: (value) => filePickerState
                                            .pickedImage ==
                                        null
                                    ? 'Vous devez choisir une image pour la détection'
                                    : null,
                                onChanged: (image) => image != null
                                    ? context.read<FilePickerBloc>().add(
                                          AddPictureEvent(pickedImage: image),
                                        )
                                    : null,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

// Helper method to build each indicator component
Widget _buildIndicatorComponent(String label, double percentage, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0.w),
    child: Row(
      children: [
        // Vertical indicator (a red line as an example)
        IndicatorProgressLine(
          percentage: percentage,
          color: color,
        ),
        SizedBox(width: 2.w), // Space between the indicator and text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.pink,
                      size: 15.sp,
                    ))
              ],
            ),
            Text(
              "$percentage%",
              style: TextStyle(fontSize: 10.sp),
            ),
          ],
        ),
      ],
    ),
  );
}

class IndicatorProgressLine extends StatelessWidget {
  const IndicatorProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      height: 35.h,
      child: Stack(
        children: [
          Container(
            width: 2.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: color!.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 2.w,
              height: 50.h * (percentage! / 100),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
