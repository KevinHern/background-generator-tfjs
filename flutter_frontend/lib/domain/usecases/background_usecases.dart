// Basic Imports
import 'dart:ui';

// Models
import 'package:flutter_frontend/data/models/background.dart';
import 'package:flutter_frontend/data/models/operation_result.dart';

// Repositories
import '../repositories/background_management_contract.dart';

// Datasources
import '../../data/datasources/nodejs_datasource.dart';

class BackgroundUseCases {
  BackgroundManagementRepository backgroundManagementRepository;
  NodeJSDatasource nodeJSDatasource;
  BackgroundUseCases({required this.backgroundManagementRepository})
      : nodeJSDatasource = NodeJSDatasource();

  Future<Result> generateBackground({
    required int height,
    required int width,
    required Color color,
    required CenterHorizontalPosition centerHorizontalPosition,
    required CenterVerticalPosition centerVerticalPosition,
    required bool isVortex,
    required int imageQuality,
    required Background oldBackground,
  }) async {
    // Create Model
    final Background newBackground =
        backgroundManagementRepository.createBackground(
            height: height,
            width: width,
            color: color,
            centerHorizontalPosition: centerHorizontalPosition,
            centerVerticalPosition: centerVerticalPosition,
            isVortex: isVortex,
            imageQuality: imageQuality);

    // Send to server and await
    final Result backgroundResult =
        await nodeJSDatasource.sendAndGenerate(background: newBackground);

    // Return result
    return backgroundResult;
  }
}
