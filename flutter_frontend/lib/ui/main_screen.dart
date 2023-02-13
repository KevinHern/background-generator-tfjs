// Basic Imports
import 'package:flutter/material.dart';

// Repositories
import '../data/repositories/background_management_impl.dart';
import '../domain/repositories/background_management_contract.dart';

// Screens
import 'background/background_form.dart';

class MainScreen extends StatelessWidget {
  final BackgroundManagementRepository backgroundManagementRepository;
  MainScreen({super.key})
      : backgroundManagementRepository = BackgroundManagementImpl();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "AI Background Generator",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          centerTitle: true,
        ),
        body: FormProviders(
          backgroundManagementRepository: backgroundManagementRepository,
        ),
      ),
    );
  }
}
