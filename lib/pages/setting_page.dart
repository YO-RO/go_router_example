import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth_state.dart';
import '../app_router.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(loggedInProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('setting page'),
      ),
      body: Center(
        child: Column(
          children: [
            if (loggedIn)
              ElevatedButton(
                onPressed: () {
                  context.goNamed(PathName.accountPref);
                },
                child: const Text('account pref'),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.goNamed(PathName.privacyPref);
              },
              child: const Text('privacy pref'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.goNamed(PathName.home);
              },
              child: const Text('home'),
            ),
            const SizedBox(height: 10),
            if (!loggedIn)
              ElevatedButton(
                onPressed: () {
                  context.goNamed(PathName.accountPref);
                },
                child: const Text('You cannot go to the account pref.'),
              ),
          ],
        ),
      ),
    );
  }
}
