import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';
import '../../../services/services.dart';
import '../widgets/widgets.dart';

class ResultPageArguments {
  final Map<String, dynamic> imageResult;
  const ResultPageArguments({required this.imageResult});
}

class ResultPage extends StatefulWidget {
  static const routeName = 'ResultPageView';
  final ResultPageArguments arguments;
  const ResultPage({super.key, required this.arguments});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String selectedStrockWith = strockWiths[0];
  String selectedLabel = labels[0];
  String selectedInferenceResult = inferenceResults[0];
  late Map<String, dynamic> _imageData = {};

  @override
  void initState() {
    _imageData = widget.arguments.imageResult;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String annotatedImage = _imageData["annotated_image"]
        ?.replaceAll('http://localhost:8000/', imageBaseUrl);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
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
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade400),
                                  fillColor: secondaryColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  prefixIcon: Container(
                                    padding:
                                        EdgeInsets.all(defaultPadding * 0.25),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 2),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Icon(
                                      Icons.star,
                                      color: primaryColor,
                                      size: 15,
                                    ),
                                  ),
                                  suffixIcon: Container(
                                    padding:
                                        EdgeInsets.all(defaultPadding * 0.75),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: defaultPadding / 2),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Text('%'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0.h),
                                child:
                                    Text('Filtrer par taux de chevauchement'),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Taux de chevauchement",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    fillColor: secondaryColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    prefixIcon: Container(
                                      padding:
                                          EdgeInsets.all(defaultPadding * 0.25),
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
                                      padding:
                                          EdgeInsets.all(defaultPadding * 0.75),
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0.h),
                                    child: Text(
                                      'Annotations',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children:
                                        List.generate(labels.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedLabel = labels[index];
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: labels[index] ==
                                                      selectedLabel
                                                  ? Colors.blue.withOpacity(0.5)
                                                  : null,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: index == 0
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  topLeft: index == 0
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  topRight: index ==
                                                          (labels.length - 1)
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  bottomRight: index ==
                                                          (labels.length - 1)
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
                                                    : Colors.grey.shade900),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0.h),
                                    child: Text(
                                      'Largeur de la bordure',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(strockWiths.length,
                                        (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedStrockWith =
                                                strockWiths[index];
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: strockWiths[index] ==
                                                      selectedStrockWith
                                                  ? Colors.blue.withOpacity(0.5)
                                                  : null,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: index == 0
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  topLeft: index == 0
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  topRight: index ==
                                                          (strockWiths.length -
                                                              1)
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  bottomRight: index ==
                                                          (strockWiths.length -
                                                              1)
                                                      ? Radius.circular(5)
                                                      : Radius.zero),
                                              border: Border.all(
                                                  color: Colors.blue,
                                                  width: 0.3)),
                                          child: Text(
                                            strockWiths[index],
                                            style: TextStyle(
                                                color: strockWiths[index] ==
                                                        selectedStrockWith
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0.h),
                                    child: Text(
                                      'Résultat de la détection',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                        inferenceResults.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedInferenceResult =
                                                inferenceResults[index];
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
                                                  topRight: index ==
                                                          (inferenceResults
                                                                  .length -
                                                              1)
                                                      ? Radius.circular(5)
                                                      : Radius.zero,
                                                  bottomRight:
                                                      index == (inferenceResults.length - 1)
                                                          ? Radius.circular(5)
                                                          : Radius.zero),
                                              border: Border.all(
                                                  color: Colors.blue,
                                                  width: 0.3)),
                                          child: Text(
                                            inferenceResults[index],
                                            style: TextStyle(
                                                color: inferenceResults[
                                                            index] ==
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
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blue, width: 0.3)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.start_rounded),
                              Text(
                                "Relancer la détection",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40, top: 40),
                    width: 0.9.sw,
                    height: 0.825.sh,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        annotatedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40.0, right: 40, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nombre d\'occurrence détecté par classe',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 40, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Habitats: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                              _imageData['results']['labels']
                                  .where((label) => label == 'habitats')
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Bassins de traitements: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                              _imageData['results']['labels']
                                  .where((label) => label == 'bassins')
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Puits: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(
                              _imageData['results']['labels']
                                  .where((label) => label == 'puits')
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
