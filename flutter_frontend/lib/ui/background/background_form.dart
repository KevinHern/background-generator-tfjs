// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Extra Widgets
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';
import '../models/background_ui.dart';

// Repositories
import 'package:flutter_frontend/domain/repositories/background_management_contract.dart';

// Use Cases
import 'package:flutter_frontend/domain/usecases/background_usecases.dart';

class FormProviders extends StatelessWidget {
  BackgroundUseCases backgroundUseCases;
  FormProviders(
      {required BackgroundManagementRepository backgroundManagementRepository,
      super.key})
      : backgroundUseCases = BackgroundUseCases(
            backgroundManagementRepository: backgroundManagementRepository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<BackgroundUI>(
        //   create: (context) => BackgroundUI(),
        // ),
        ChangeNotifierProvider<BackgroundFormUI>(
          create: (context) => BackgroundFormUI(),
        ),
      ],
      child: const BackgroundForm(),
    );
  }
}

class BackgroundForm extends StatefulWidget {
  const BackgroundForm({super.key});

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
          child: Consumer<BackgroundFormUI>(
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
                                selected:
                                    backgroundFormUI.isRGBInputColorWheelMode,
                                onSelected: (bool selected) {
                                  backgroundFormUI.isRGBInputColorWheelMode =
                                      true;
                                  setState(() {});
                                }),
                            ChoiceChip(
                                label: const Text("RGB Sliders"),
                                selected:
                                    !backgroundFormUI.isRGBInputColorWheelMode,
                                onSelected: (bool selected) {
                                  backgroundFormUI.isRGBInputColorWheelMode =
                                      false;
                                  setState(() {});
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
                                setState(() {});
                              }),
                          ChoiceChip(
                              label: const Text("Fog Mode"),
                              selected: !backgroundFormUI.isVortexMode,
                              onSelected: (bool selected) {
                                backgroundFormUI.isVortexMode = false;
                                setState(() {});
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
                                    label: Text(Background
                                        .centerVerticalLabels[element.index]),
                                    selected: backgroundFormUI
                                            .centerVerticalPosition ==
                                        element,
                                    onSelected: (bool selected) {
                                      backgroundFormUI.centerVerticalPosition =
                                          element;
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
                                    label: Text(Background
                                        .centerHorizontalLabels[element.index]),
                                    selected: backgroundFormUI
                                            .centerHorizontalPosition ==
                                        element,
                                    onSelected: (bool selected) {
                                      backgroundFormUI
                                          .centerHorizontalPosition = element;
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
                    onPressed: () => {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
