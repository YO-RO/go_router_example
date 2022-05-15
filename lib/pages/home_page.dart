import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/app_router.dart';
import 'package:go_router_example/auth_state.dart';
import 'package:go_router_example/search_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool loggedIn = ref.watch(loggedInProvider);
    final String searchQuery = ref.watch(searchQueryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You are ${loggedIn ? 'logged in' : 'logged out'}'),
            const SizedBox(height: 10),

            /// welcome page
            ElevatedButton(
              onPressed:
                  loggedIn ? null : () => context.goNamed(PathName.welcome),
              child: const Text('welcome'),
            ),
            const SizedBox(height: 10),

            /// user page
            ElevatedButton(
              onPressed: () => context.goNamed(
                PathName.user,
                params: {'userId': 'abc'},
              ),
              child: const Text('user: abc'),
            ),
            const SizedBox(height: 40),

            /// search query input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '検索ワード',
                  border: OutlineInputBorder(),
                ),
                onChanged: ((text) {
                  ref.read(searchQueryProvider.notifier).state = text;
                }),
              ),
            ),
            const SizedBox(height: 10),

            /// search page
            ElevatedButton(
              onPressed: searchQuery.isEmpty
                  ? null
                  : () {
                      context.goNamed(
                        PathName.search,
                        queryParams: {QueryName.searchQuery: searchQuery},
                      );
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
              child: const Text('search'),
            ),
            const SizedBox(height: 10),

            /// login page
            ElevatedButton(
              onPressed:
                  loggedIn ? null : () => context.goNamed(PathName.login),
              child: const Text('login'),
            ),
            const SizedBox(height: 10),

            /// logout page
            ElevatedButton(
              onPressed:
                  loggedIn ? () => context.goNamed(PathName.logout) : null,
              child: const Text('logout'),
            ),
            const SizedBox(height: 10),

            /// error page
            ElevatedButton(
              onPressed: () => context.go('/error'),
              child: const Text('error'),
            ),
          ],
        ),
      ),
    );
  }
}
