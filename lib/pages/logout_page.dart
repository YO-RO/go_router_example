import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/auth_state.dart';

import '../app_router.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('logout')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
                  ref.read(loggedInProvider.notifier).state = false,
              child: const Text('logout'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.goNamed(PathName.home),
              child: const Text('go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
