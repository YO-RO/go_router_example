import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('404 Not Found'),
            ElevatedButton(
              onPressed: () => context.goNamed(PathName.home),
              child: const Text('go home'),
            ),
          ],
        ),
      ),
    );
  }
}
