import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/auth_state.dart';

import 'pages/account_pref_page.dart';
import 'pages/error_page.dart';
import 'pages/privacy_pref_page.dart';
import 'pages/search_page.dart';
import 'pages/setting_page.dart';
import 'pages/tweet_page.dart';
import 'pages/user_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/logout_page.dart';
import 'pages/welcome_page.dart';

// パスの名前を変更したとき、パスの変更を忘れないように！
class PathName {
  static const welcome = 'welcome';
  static const home = 'home';
  static const logout = 'logout';
  static const login = 'login';
  static const tweet = 'tweet';
  static const user = 'user';
  static const search = 'search';
  static const settings = 'settings';
  static const privacyPref = 'privacyPref';
  static const accountPref = 'accountPref';
}

class ParamName {
  static const userId = 'userId';
  static const tweetId = 'tweetId';
}

class QueryName {
  static const searchQuery = 'q';

  /// This query have a [state.location] like /user/34?q=hello+world.
  static const from = 'from';
}

final goRouterProvider = Provider((ref) {
  // watchすると動かない。
  // ref.watch(loggedInProvider.notifier).state;
  // 可能性1
  // loginStateが変更 → watchしているのでloggedInが更新された
  // GoRouterの新しいインスタンスがreturn → URLを再マッチングせず終了
  // 可能性2
  // loginStateが変更 → notifyListeners()により、
  // 再度loggedInが更新される前にURLのマッチング処理 → watchしているのでloggedInが更新された
  // GoRouterのinstanceがreturn → リダイレクトせずに終了
  //
  // GoRouterのloggedInの更新、URLの再マッチングのどちらが先に行われようが
  // 期待した動作にならない。
  return GoRouter(
    // debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: _NeedRefreshNotifier(ref),
    initialLocation: '/',
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: ErrorPage()),
    routes: [
      GoRoute(
        name: PathName.welcome,
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: WelcomePage()),
        redirect: (state) {
          final loggedIn = ref.read(loggedInProvider);
          if (!loggedIn) return null;
          return state.namedLocation(PathName.home);
        },
      ),
      GoRoute(
        name: PathName.home,
        path: '/home',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        name: PathName.user,
        // ↓の書き方では例外が発生する
        // path: '/:userId',
        path: '/home/:${ParamName.userId}',
        pageBuilder: (context, state) {
          final id = state.params[ParamName.userId]!;
          return NoTransitionPage(
            child: UserPage(userId: id),
          );
        },
        routes: [
          GoRoute(
            name: PathName.tweet,
            path: 'status/:${ParamName.tweetId}',
            pageBuilder: (context, state) {
              final id = state.params[ParamName.tweetId]!;
              return NoTransitionPage(child: TweetPage(tweetId: id));
            },
          ),
        ],
      ),
      GoRoute(
        name: PathName.search,
        path: '/search',
        pageBuilder: (context, state) {
          final q = state.queryParams[QueryName.searchQuery]!;
          return NoTransitionPage(
            child: SearchPage(searchQuery: q),
          );
        },
        redirect: (state) {
          final loggedIn = ref.read(loggedInProvider);
          if (loggedIn) return null;
          return state.namedLocation(
            PathName.login,
            queryParams: {QueryName.from: state.location},
          );
        },
      ),
      GoRoute(
        name: PathName.settings,
        path: '/settings',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SettingPage());
        },
        redirect: (state) {
          final bool loggedIn = ref.read(loggedInProvider);
          final bool inPrivacyPref = state.name == PathName.privacyPref;
          if (loggedIn || inPrivacyPref) return null;
          return state.namedLocation(
            PathName.login,
            params: {QueryName.from: state.location},
          );
        },
        routes: [
          GoRoute(
            // login required
            name: PathName.accountPref,
            path: 'account',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: AccountPrefPage());
            },
          ),
          GoRoute(
            name: PathName.privacyPref,
            path: 'privacy',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: PrivacyPrefPage());
            },
          ),
        ],
      ),
      GoRoute(
        name: PathName.logout,
        path: '/logout',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LogoutPage()),
        redirect: (state) {
          final loggedIn = ref.read(loggedInProvider);
          if (!loggedIn) return state.namedLocation(PathName.home);
          return null;
        },
      ),
      GoRoute(
        name: PathName.login,
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginPage()),
        redirect: (state) {
          final bool loggedIn = ref.read(loggedInProvider);
          if (!loggedIn) return null;

          final String? fromLocation = state.queryParams[QueryName.from];
          if (fromLocation == null) return state.namedLocation(PathName.home);

          return fromLocation;
        },
      )
    ],
  );
});

// GoRouterにURLの再マッチングを通知する用
class _NeedRefreshNotifier extends ChangeNotifier {
  _NeedRefreshNotifier(this._ref) {
    _ref.listen<bool>(loggedInProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;
}
