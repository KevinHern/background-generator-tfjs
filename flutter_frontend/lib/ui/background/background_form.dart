// Basic Imports
import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Extra Widgets
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';
import '../../data/models/operation_result.dart';
import '../models/background_ui.dart';

// Repositories
import 'package:flutter_frontend/domain/repositories/background_management_contract.dart';

// Use Cases
import 'package:flutter_frontend/domain/usecases/background_usecases.dart';

// Datasources
import 'package:flutter_frontend/data/datasources/nodejs_datasource.dart';

class FormProviders extends StatelessWidget {
  final BackgroundUseCases backgroundUseCases;
  FormProviders(
      {required BackgroundManagementRepository backgroundManagementRepository,
      super.key})
      : backgroundUseCases = BackgroundUseCases(
          backgroundManagementRepository: backgroundManagementRepository,
          nodeJSDatasource: NodeJSDatasource(),
        );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BackgroundUI>(
          create: (context) => BackgroundUI(),
        ),
        ChangeNotifierProvider<BackgroundFormUI>(
          create: (context) => BackgroundFormUI(),
        ),
      ],
      child: BackgroundForm(
        backgroundUseCases: backgroundUseCases,
      ),
    );
  }
}

class BackgroundForm extends StatefulWidget {
  final BackgroundUseCases backgroundUseCases;
  const BackgroundForm({required this.backgroundUseCases, super.key});

  @override
  BackgroundFormState createState() => BackgroundFormState();
}

class BackgroundFormState extends State<BackgroundForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: MediaQuery.of(context).size.width * 0.075,
          ),
          child: Column(
            children: [
              Consumer<BackgroundFormUI>(
                builder: (_, backgroundFormUI, __) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(
                            "Image Height: ${Background.imgDimensions[backgroundFormUI.selectedHeight]} px"),
                        subtitle: Slider(
                          divisions: Background.imgDimensions.length - 1,
                          max: Background.imgDimensions.length - 1,
                          min: 0,
                          label:
                              "${Background.imgDimensions[backgroundFormUI.selectedHeight]}",
                          value: backgroundFormUI.selectedHeight.toDouble(),
                          onChanged: (double value) {
                            backgroundFormUI.selectedHeight = value.toInt();
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: Text(
                            "Image Width: ${Background.imgDimensions[backgroundFormUI.selectedWidth]} px"),
                        subtitle: Slider(
                          divisions: Background.imgDimensions.length - 1,
                          max: Background.imgDimensions.length - 1,
                          min: 0,
                          label:
                              "${Background.imgDimensions[backgroundFormUI.selectedWidth]}",
                          value: backgroundFormUI.selectedWidth.toDouble(),
                          onChanged: (double value) {
                            backgroundFormUI.selectedWidth = value.toInt();
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.palette),
                        title: const Text("Color Picker"),
                        subtitle: Column(
                          children: [
                            Wrap(
                              spacing: MediaQuery.of(context).size.width * 0.05,
                              children: [
                                ChoiceChip(
                                    label: const Text("Color Wheel"),
                                    selected: backgroundFormUI
                                        .isRGBInputColorWheelMode,
                                    onSelected: (bool selected) {
                                      backgroundFormUI
                                          .isRGBInputColorWheelMode = true;
                                      backgroundFormUI.update();
                                    }),
                                ChoiceChip(
                                    label: const Text("RGB Sliders"),
                                    selected: !backgroundFormUI
                                        .isRGBInputColorWheelMode,
                                    onSelected: (bool selected) {
                                      backgroundFormUI
                                          .isRGBInputColorWheelMode = false;
                                      backgroundFormUI.update();
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            backgroundFormUI.isRGBInputColorWheelMode
                                ? HueRingPicker(
                                    pickerColor: backgroundFormUI.selectedColor,
                                    onColorChanged: (Color color) {
                                      backgroundFormUI.selectedColor = color;
                                    },
                                    enableAlpha: false,
                                  )
                                : SlidePicker(
                                    pickerColor: backgroundFormUI.selectedColor,
                                    onColorChanged: (Color color) {
                                      backgroundFormUI.selectedColor = color;
                                    },
                                    enableAlpha: false,
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.ac_unit),
                        title: const Text("Background Style"),
                        subtitle: Center(
                          child: Wrap(
                            spacing: MediaQuery.of(context).size.width * 0.05,
                            children: [
                              ChoiceChip(
                                  label: const Text("Vortex Mode"),
                                  selected: backgroundFormUI.isVortexMode,
                                  onSelected: (bool selected) {
                                    backgroundFormUI.isVortexMode = true;
                                    backgroundFormUI.update();
                                  }),
                              ChoiceChip(
                                  label: const Text("Fog Mode"),
                                  selected: !backgroundFormUI.isVortexMode,
                                  onSelected: (bool selected) {
                                    backgroundFormUI.isVortexMode = false;
                                    backgroundFormUI.update();
                                  }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.center_focus_strong),
                        title: const Text("Center Position"),
                        subtitle: Table(
                          children: [
                            TableRow(
                              children: CenterVerticalPosition.values
                                  .map(
                                    (element) => ChoiceChip(
                                        label: Text(
                                            Background.centerVerticalLabels[
                                                element.index]),
                                        selected: backgroundFormUI
                                                .centerVerticalPosition ==
                                            element,
                                        onSelected: (bool selected) {
                                          backgroundFormUI
                                              .centerVerticalPosition = element;
                                          backgroundFormUI.update();
                                        }),
                                  )
                                  .toList(),
                            ),
                            TableRow(
                              children: CenterVerticalPosition.values
                                  .map(
                                    (element) => const SizedBox(
                                      height: 8.0,
                                    ),
                                  )
                                  .toList(),
                            ),
                            TableRow(
                              children: CenterHorizontalPosition.values
                                  .map(
                                    (element) => ChoiceChip(
                                        label: Text(
                                            Background.centerHorizontalLabels[
                                                element.index]),
                                        selected: backgroundFormUI
                                                .centerHorizontalPosition ==
                                            element,
                                        onSelected: (bool selected) {
                                          backgroundFormUI
                                                  .centerHorizontalPosition =
                                              element;
                                          backgroundFormUI.update();
                                        }),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListTile(
                        leading: const Icon(Icons.filter),
                        title: Text(
                            "Image Complexity: ${Background.imageQualityLabels[backgroundFormUI.selectedimageComplexity]}"),
                        subtitle: Slider(
                          divisions: Background.imgComplexity.length - 1,
                          max: Background.imgComplexity.length - 1,
                          min: 0,
                          label: Background.imageQualityLabels[
                              backgroundFormUI.selectedimageComplexity],
                          value: backgroundFormUI.selectedimageComplexity
                              .toDouble(),
                          onChanged: (double value) {
                            backgroundFormUI.selectedimageComplexity =
                                value.toInt();
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ChoiceChip(
                          label: const Text("Auto Generate"),
                          selected: backgroundFormUI.autoGenerate,
                          onSelected: (bool selected) {
                            backgroundFormUI.autoGenerate =
                                !backgroundFormUI.autoGenerate;

                            if (backgroundFormUI.autoGenerate) {
                              Timer.periodic(
                                const Duration(seconds: 7),
                                (timer) async {
                                  if (!backgroundFormUI.autoGenerate) {
                                    timer.cancel();
                                  } else {
                                    final Result result = await widget
                                        .backgroundUseCases
                                        .randomBackground();
                                    if (result.success) {
                                      Provider.of<BackgroundUI>(context,
                                              listen: false)
                                          .background = result.object;
                                    }
                                  }
                                },
                              );
                            }

                            backgroundFormUI.update();
                          }),
                      const SizedBox(
                        height: 16.0,
                      ),
                      FloatingActionButton.extended(
                        label: const Text("Generate"),
                        icon: const Icon(Icons.send),
                        onPressed: backgroundFormUI.autoGenerate
                            ? null
                            : () async {
                                // Send information and wait for the result
                                final Result result = await showDialog<Result>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return FutureProgressDialog(Future<Result>(
                                      () async {
                                        return await widget.backgroundUseCases
                                            .generateBackground(
                                          height:
                                              backgroundFormUI.selectedHeight,
                                          width: backgroundFormUI.selectedWidth,
                                          color: backgroundFormUI.selectedColor,
                                          imageComplexity: backgroundFormUI
                                              .selectedimageComplexity,
                                          centerHorizontalPosition:
                                              backgroundFormUI
                                                  .centerHorizontalPosition,
                                          centerVerticalPosition:
                                              backgroundFormUI
                                                  .centerVerticalPosition,
                                          isVortex:
                                              backgroundFormUI.isVortexMode,
                                        );
                                      },
                                    ));
                                  },
                                ) as Result;

                                // Check and extract the image
                                if (result.success) {
                                  // An image was generated. Retrieve image, show it and display information
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    title: 'Warning',
                                    desc: result.message,
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.check,
                                    btnOkColor: Colors.green,
                                  ).show();

                                  Provider.of<BackgroundUI>(context,
                                          listen: false)
                                      .background = result.object;
                                } else {
                                  // An error occurred. Just display de error message
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    title: 'Error',
                                    desc: result.message,
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: Colors.red,
                                  ).show();
                                }
                              },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              ListTile(
                title: const Text("Generated Image"),
                leading: const Icon(Icons.image),
                subtitle: Consumer<BackgroundUI>(
                  builder: (_, backgroundUI, __) {
                    return backgroundUI.background != null
                        ? SizedBox.square(
                            dimension: 256,
                            child: Image.memory(
                              base64.decode(
                                backgroundUI.background!.encodedBase64Img!,
                              ),
                              //width: backgroundUI.background!.width.toDouble(),
                              //height: backgroundUI.background!.height.toDouble(),
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : const SizedBox(
                            height: 200,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
