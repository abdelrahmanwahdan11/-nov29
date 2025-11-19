
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/app_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ControllerScope.of(context).search;
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AppSearchBar(
            onChanged: controller.search,
          ),
          const SizedBox(height: 20),
          ...controller.results.map(
            (result) => ListTile(
              title: Text(result.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
