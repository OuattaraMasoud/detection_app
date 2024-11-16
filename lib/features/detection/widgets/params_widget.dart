import 'package:auto_size_text/auto_size_text.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:detectionApp/services/navigation_service.dart';
import 'package:detectionApp/utils.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../views/views.dart';

class ParamsWidget extends StatefulWidget {
  const ParamsWidget({super.key});

  @override
  State<ParamsWidget> createState() => _ParamsWidgetState();
}

class _ParamsWidgetState extends State<ParamsWidget> {
  String selectedUploadMethod = uploadTypes[0];
  String selectedInferenceResult = inferenceResults[0];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.h),
                      child: Text(
                        'Charger l\'image',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: List.generate(uploadTypes.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUploadMethod = uploadTypes[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                color:
                                    uploadTypes[index] == selectedUploadMethod
                                        ? Colors.blue.withOpacity(0.5)
                                        : null,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: index == 0
                                        ? Radius.circular(5)
                                        : Radius.zero,
                                    topLeft: index == 0
                                        ? Radius.circular(5)
                                        : Radius.zero,
                                    topRight: index == (uploadTypes.length - 1)
                                        ? Radius.circular(5)
                                        : Radius.zero,
                                    bottomRight:
                                        index == (uploadTypes.length - 1)
                                            ? Radius.circular(5)
                                            : Radius.zero),
                                border:
                                    Border.all(color: Colors.blue, width: 0.3)),
                            child: Text(
                              uploadTypes[index],
                              style: TextStyle(
                                  color:
                                      uploadTypes[index] == selectedUploadMethod
                                          ? Colors.white
                                          : Colors.grey.shade900),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.h),
                      child: Text(
                        'Résultat de la détection',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: List.generate(inferenceResults.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedInferenceResult = inferenceResults[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                color: inferenceResults[index] ==
                                        selectedInferenceResult
                                    ? Colors.blue.withOpacity(0.5)
                                    : null,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: index == 0
                                        ? Radius.circular(5)
                                        : Radius.zero,
                                    topLeft: index == 0
                                        ? Radius.circular(5)
                                        : Radius.zero,
                                    topRight:
                                        index == (inferenceResults.length - 1)
                                            ? Radius.circular(5)
                                            : Radius.zero,
                                    bottomRight:
                                        index == (inferenceResults.length - 1)
                                            ? Radius.circular(5)
                                            : Radius.zero),
                                border:
                                    Border.all(color: Colors.blue, width: 0.3)),
                            child: Text(
                              inferenceResults[index],
                              style: TextStyle(
                                  color: inferenceResults[index] ==
                                          selectedInferenceResult
                                      ? Colors.white
                                      : Colors.grey.shade900),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.h),
                      child: Text(
                        'Choisir un fichier',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            child: Center(
                                child: Text(
                              '',
                              style: TextStyle(color: Colors.grey.shade200),
                            )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: Center(
                                child: AutoSizeText(
                              'Choisir',
                              minFontSize: 10,
                              maxFontSize: 15,
                              style: TextStyle(
                                color: Colors.grey.shade200,
                              ),
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: Text('Filtrer par classes'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Entrer le nom de la classe",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            fillColor: secondaryColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: Text('Filtrer par seuil de confiance'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Seuil de confiance",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            fillColor: secondaryColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(defaultPadding * 0.25),
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(
                                Icons.star,
                                color: primaryColor,
                                size: 15,
                              ),
                            ),
                            suffixIcon: Container(
                              padding: EdgeInsets.all(defaultPadding * 0.75),
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text('%'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0.h),
                          child: Text('Filtrer par taux de chevauchement'),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Taux de chevauchement",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              fillColor: secondaryColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(defaultPadding * 0.25),
                                margin: EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Icon(
                                  Icons.layers,
                                  color: primaryColor,
                                  size: 15,
                                ),
                              ),
                              suffixIcon: Container(
                                padding: EdgeInsets.all(defaultPadding * 0.75),
                                margin: EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Text('%'),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> uploadTypes = ['Upload', 'URL'];
List<String> inferenceResults = ['Image', 'JSON'];
List<String> strockWiths = ['1px', '2px', "5px", "10px"];
List<String> labels = ['Off', 'On'];
