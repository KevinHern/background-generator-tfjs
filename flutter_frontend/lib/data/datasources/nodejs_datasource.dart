// Basic Imports
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Models
import 'package:flutter_frontend/data/models/background.dart';
import 'package:flutter_frontend/data/models/operation_result.dart';

// Networking
import 'package:http/http.dart' as http;

class NodeJSDatasource {
  Future<String> loadIpAddress() async {
    return await rootBundle.loadString("ip_address.txt");
  }

  Future<Result> sendAndGenerate(
      {required Background background, required String nodejsIPAddress}) async {
    try {
      // Send data to server
      final response = await http.post(
        Uri.parse("http://$nodejsIPAddress:43000/background"),
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
