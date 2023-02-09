// Basic Imports
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
                            "Image Quality: ${Background.imageQualityLabels[backgroundFormUI.selectedImgQuality]}"),
                        subtitle: Slider(
                          divisions: Background.imgQuality.length - 1,
                          max: Background.imgQuality.length - 1,
                          min: 0,
                          label: Background.imageQualityLabels[
                              backgroundFormUI.selectedImgQuality],
                          value: backgroundFormUI.selectedImgQuality.toDouble(),
                          onChanged: (double value) {
                            backgroundFormUI.selectedImgQuality = value.toInt();
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      FloatingActionButton.extended(
                        label: const Text("Generate"),
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          // Send information and wait for the result
                          final Result result = await showDialog<Result>(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return FutureProgressDialog(Future<Result>(
                                () async {
                                  return await widget.backgroundUseCases
                                      .generateBackground(
                                    height: backgroundFormUI.selectedHeight,
                                    width: backgroundFormUI.selectedWidth,
                                    color: backgroundFormUI.selectedColor,
                                    imageQuality:
                                        backgroundFormUI.selectedImgQuality,
                                    centerHorizontalPosition: backgroundFormUI
                                        .centerHorizontalPosition,
                                    centerVerticalPosition:
                                        backgroundFormUI.centerVerticalPosition,
                                    isVortex: backgroundFormUI.isVortexMode,
                                  );

                                  // await Future.delayed(
                                  //     const Duration(seconds: 1));
                                  // return Result(
                                  //   success: true,
                                  //   message: "aasdf",
                                  //   object: Background(
                                  //     height: 64,
                                  //     width: 64,
                                  //     imageQuality: 4,
                                  //     color: Colors.blue,
                                  //     centerVerticalPosition:
                                  //         CenterVerticalPosition.CENTER,
                                  //     centerHorizontalPosition:
                                  //         CenterHorizontalPosition.CENTER,
                                  //     isVortex: true,
                                  //     encodedBase64Img:
                                  //         "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",
                                  //   ),
                                  // );
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

                            Provider.of<BackgroundUI>(context, listen: false)
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
