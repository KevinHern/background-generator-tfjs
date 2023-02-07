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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Form",
                  icon: Icon(
                    Icons.menu,
                    size: 40,
                  ),
                ),
                Tab(
                  text: "Collection",
                  icon: Icon(
                    Icons.collections,
                    size: 40,
                  ),
                ),
              ],
            ),
            title: Text(
              "AI Background Generator",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              FormProviders(
                backgroundManagementRepository: backgroundManagementRepository,
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
