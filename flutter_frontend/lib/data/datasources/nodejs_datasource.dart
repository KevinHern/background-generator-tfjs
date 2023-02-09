// Basic Imports
import 'dart:convert';

// Models
import 'package:flutter/foundation.dart';
import 'package:flutter_frontend/data/models/background.dart';
import 'package:flutter_frontend/data/models/operation_result.dart';

// Networking
import 'package:http/http.dart' as http;

class NodeJSDatasource {
  static const String nodejsURL = 'http://127.0.0.1:16000/';

  Future<Result> sendAndGenerate({required Background background}) async {
    try {
      // Send data to server
      final response = await http.post(
        Uri.parse("${nodejsURL}background"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(background.toMap()),
      );

      // Check result
      if (response.statusCode == 200) {
        // Parse JSON
        final decodedJson = jsonDecode(response.body);

        // Extract created image
        background.getImgFromJson(json: decodedJson);

        // Return result
        return Result(
          success: true,
          message: "Image successfully created.",
          object: background,
        );
      } else {
        // Return result
        return const Result(
          success: true,
          message: "An error occurred. Try again.",
        );
      }
    } catch (e) {
      // Return result
      return const Result(
        success: false,
        message: "An error occurred. Try again.",
      );
    }
  }
}
