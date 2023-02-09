// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Models
import 'package:flutter_frontend/data/models/background.dart';
import 'package:flutter_frontend/data/models/operation_result.dart';

// Repositories
import 'package:flutter_frontend/data/repositories/background_management_impl.dart';
import 'package:flutter_frontend/domain/repositories/background_management_contract.dart';

// Use Cases
import 'package:flutter_frontend/domain/usecases/background_usecases.dart';

// Datasources
import 'package:flutter_frontend/data/datasources/nodejs_datasource.dart';

// Mocking
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import './background_usecases_tests.mocks.dart';

@GenerateMocks([NodeJSDatasource])
void main() {
  group(
    "Background Use Cases Tests",
    () {},
  );
}
