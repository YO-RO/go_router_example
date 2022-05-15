import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    // TODO: tabを作る
    return Scaffold(
      appBar: AppBar(
        title: Text('user page: @$userId'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// home
            ElevatedButton(
              onPressed: () => context.goNamed(PathName.home),
              child: const Text('home'),
            ),
            const SizedBox(height: 10),

            /// tweet 1
            ElevatedButton(
                onPressed: () => context.goNamed(
                      PathName.tweet,
                      params: {
                        ParamName.userId: userId,
                        ParamName.tweetId: '1',
                      },
                    ),
                child: const Text('tweet 1')),
            const SizedBox(height: 10),

            /// tweet 2
            ElevatedButton(
                onPressed: () => context.goNamed(
                      PathName.tweet,
                      params: {
                        ParamName.userId: userId,
                        ParamName.tweetId: '2',
                      },
                    ),
                child: const Text('this tweet does not exist')),
          ],
        ),
      ),
    );
  }
}
