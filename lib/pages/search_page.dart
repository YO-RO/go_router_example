import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.searchQuery}) : super(key: key);

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('検索ワード：$searchQuery'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => context.goNamed(PathName.home),
                child: const Text('home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
