import 'package:auto_size_text/auto_size_text.dart';
import 'package:detectionApp/constants.dart';
import 'package:detectionApp/features/dashboard/components/header.dart';
import 'package:detectionApp/features/detection/bloc/file_picker_bloc.dart';
import 'package:detectionApp/features/detection/views/views.dart';
import 'package:detectionApp/global_app/cubit/global_app_cubit.dart';
import 'package:detectionApp/repositories/repository.dart';
import 'package:detectionApp/services/dio_service.dart';
import 'package:detectionApp/widgets/image_fom_controller.dart';
import 'package:detectionApp/widgets/image_fom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/locator.dart';
import '../../../services/services.dart';
import '../widgets/build_result_page_widget.dart';
import '../widgets/widgets.dart';

class InitDetectionPage extends StatefulWidget {
  static const routeName = 'InitDetectionPageView';
  const InitDetectionPage({super.key});

  @override
  State<InitDetectionPage> createState() => _InitDetectionPageState();
}

class _InitDetectionPageState extends State<InitDetectionPage> {
  bool _shouldShowResultWidget = false;
  bool _isLoading = false;

  String selectedLabel = labels[0];
  String selectedStrockWith = strockWiths[0];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocProvider(
            create: (context) => FilePickerBloc(FilePickerState()),
            child: BlocBuilder<FilePickerBloc, FilePickerState>(
              builder: (context, filePickerState) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(title: 'Détection'),
                          _buildContent(context, filePickerState),
                          SizedBox(height: 15.h),
                          _buildButtonsRow(),
                          _buildDeployModelSection(context, filePickerState),
                          ParamsWidget(),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0.h),
                                          child: Text(
                                            'Annotations',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(labels.length,
                                              (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedLabel = labels[index];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: labels[index] ==
                                                            selectedLabel
                                                        ? Colors.blue
                                                            .withOpacity(0.5)
                                                        : null,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: index == 0
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        topLeft: index == 0
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        topRight: index ==
                                                                (labels.length -
                                                                    1)
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        bottomRight: index ==
                                                                (labels.length -
                                                                    1)
                                                            ? Radius.circular(5)
                                                            : Radius.zero),
                                                    border: Border.all(
                                                        color: Colors.blue,
                                                        width: 0.3)),
                                                child: Text(
                                                  labels[index],
                                                  style: TextStyle(
                                                      color: labels[index] ==
                                                              selectedLabel
                                                          ? Colors.white
                                                          : Colors
                                                              .grey.shade900),
                                                ),
                                              ),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0.h),
                                          child: Text(
                                            'Largeur de la bordure',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                              strockWiths.length, (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedStrockWith =
                                                      strockWiths[index];
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: strockWiths[index] ==
                                                            selectedStrockWith
                                                        ? Colors.blue
                                                            .withOpacity(0.5)
                                                        : null,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: index == 0
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        topLeft: index == 0
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        topRight: index == (strockWiths.length - 1)
                                                            ? Radius.circular(5)
                                                            : Radius.zero,
                                                        bottomRight: index ==
                                                                (strockWiths
                                                                        .length -
                                                                    1)
                                                            ? Radius.circular(5)
                                                            : Radius.zero),
                                                    border: Border.all(
                                                        color: Colors.blue,
                                                        width: 0.3)),
                                                child: Text(
                                                  strockWiths[index],
                                                  style: TextStyle(
                                                      color: strockWiths[
                                                                  index] ==
                                                              selectedStrockWith
                                                          ? Colors.white
                                                          : Colors
                                                              .grey.shade900),
                                                ),
                                              ),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0.h),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        BlocBuilder<FilePickerBloc,
                                            FilePickerState>(
                                          builder: (context, filePickerState) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (filePickerState
                                                        .pickedImage !=
                                                    null) {
                                                  XFile filePath =
                                                      filePickerState
                                                          .pickedImage!;
                                                  setState(() {
                                                    _isLoading = true;
                                                  });

                                                  Map<String, dynamic>?
                                                      jsonResponse =
                                                      await DetectionRepository(
                                                              DioService())
                                                          .submitImage(
                                                              filePath.path,
                                                              filePath.name);
                                                  print(jsonResponse);
                                                  if (jsonResponse == null) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  }
                                                  if (jsonResponse != null) {
                                                    Map<String, dynamic>?
                                                        imageResponse =
                                                        await DetectionRepository(
                                                                DioService())
                                                            .downLoadImage(
                                                                jsonResponse[
                                                                    'id']);
                                                    setState(() {
                                                      _isLoading = false;
                                                    });

                                                    if (imageResponse != null) {
                                                      locator<NavigationService>()
                                                          .navigateTo(
                                                              ResultPage
                                                                  .routeName,
                                                              arguments:
                                                                  ResultPageArguments(
                                                                      imageResult:
                                                                          imageResponse));
                                                    }
                                                  }
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: Border.all(
                                                        color: Colors.blue,
                                                        width: 0.3)),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons
                                                              .start_rounded),
                                                          Text(
                                                            "Lancer la détection",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      _isLoading
                                                          ? Container(
                                                              width: 24,
                                                              height: 24,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child:
                                                                  PlatformCircularProgressIndicator(),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        _shouldShowResultWidget
            ? buildResultPageWidget(
                context,
                () {
                  setState(() {
                    _shouldShowResultWidget = false;
                  });
                },
              )
            : SizedBox()
      ],
    );
  }

  Widget _buildContent(BuildContext context, FilePickerState filePickerState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Decide the layout based on available width.
        return constraints.maxWidth > 600
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextDetails()),
                  _buildIndicators(),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextDetails(),
                  SizedBox(height: 10.h),
                  _buildIndicators(),
                ],
              );
      },
    );
  }

  Widget _buildTextDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "Caracteristiques minières",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        Text("Type de modèle: Détection Faster-RCCN version 1.0.0"),
        Text("Base de données d'entrainement: Images aériennes"),
      ],
    );
  }

  Widget _buildIndicators() {
    return Row(
      children: [
        _buildIndicatorComponent("mAP", 95.0, Colors.pink),
        _buildIndicatorComponent("Précision", 94.0, Colors.blue),
        _buildIndicatorComponent("Rappel", 94.0, Colors.amber),
      ],
    );
  }

  Widget _buildButtonsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the width is smaller than a threshold (e.g., 600 pixels)
        bool isNarrow = constraints.maxWidth < 600;

        return isNarrow
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildOutlinedButton(
                    icon: Icons.assessment_outlined,
                    label: 'Modele d\'évaluation détaillé',
                    color: Colors.pink,
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  SizedBox(height: 10), // Space between buttons
                  _buildOutlinedButton(
                    icon: Icons.stacked_bar_chart_outlined,
                    label: 'Performance par classe',
                    color: Colors.grey.shade900,
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  SizedBox(height: 10), // Space between buttons
                  _buildOutlinedButton(
                    icon: Icons.ssid_chart_outlined,
                    label: 'Visualiser le modèle',
                    color: Colors.grey.shade900,
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildOutlinedButton(
                        icon: Icons.assessment_outlined,
                        label: 'Modele d\'évaluation détaillé',
                        color: Colors.pink,
                        onPressed: () {
                          // Handle button press
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildOutlinedButton(
                        icon: Icons.stacked_bar_chart_outlined,
                        label: 'Performance par classe',
                        color: Colors.grey.shade900,
                        onPressed: () {
                          // Handle button press
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildOutlinedButton(
                        icon: Icons.ssid_chart_outlined,
                        label: 'Visualisation du modèle',
                        color: Colors.grey.shade900,
                        onPressed: () {
                          // Handle button press
                        },
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget _buildOutlinedButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.all(5),
        side: BorderSide(color: color, width: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 14),
            SizedBox(width: 5.w),
            AutoSizeText(
              label,
              minFontSize: 10,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeployModelSection(
      BuildContext context, FilePickerState filePickerState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text("Charger l'image"),
        ),
        BlocProvider(
          create: (context) => FilePickerBloc(
            FilePickerState(pickedImage: XFile("")),
          ),
          child: ImageFormField(
            initialValue: filePickerState.pickedImage,
            imageName: "Sélectionner une image",
            validator: (value) => filePickerState.pickedImage == null
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
    );
  }

  Widget _buildIndicatorComponent(
      String label, double percentage, Color color) {
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.pink,
                        size: 15,
                      ))
                ],
              ),
              Text(
                "$percentage%",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
