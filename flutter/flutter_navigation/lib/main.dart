import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UsersRouterDelegate _routerDelegate = UsersRouterDelegate();
  UsersRouteInformationParser _routeInformationParser =
  UsersRouteInformationParser();

  // MaterialApp that uses the Router instead of a Navigator.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class UsersScreen extends StatelessWidget {
  final List<String> users;
  final ValueChanged didSelectUser;

  UsersScreen({
    @required this.users,
    @required this.didSelectUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
                child: ListTile(
              title: Text(user),
              onTap: () => didSelectUser(user),
            ));
          }),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  static const valueKey = ValueKey('UserDetailsView');

  final String user;

  UserDetailsScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Center(child: Text('Hello, $user')));
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class UserDetailsPage extends Page {
  final String user;

  UserDetailsPage({
    this.user,
  }) : super(key: ValueKey(user));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return UserDetailsScreen(user: user);
      },
    );
  }
}

// Converts the given route information into parsed data to pass 
// to a [RouterDelegate].
class UsersRouteInformationParser extends RouteInformationParser<UsersRoutePath> {
  @override
  Future<UsersRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return UsersRoutePath.home();
    }

    // Handle '/user/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'user') return UsersRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return UsersRoutePath.unknown();
      return UsersRoutePath.details(id);
    }

    // Handle unknown routes
    return UsersRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(UsersRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/user/${path.id}');
    }
    return null;
  }
}

class UsersRouterDelegate extends RouterDelegate<UsersRoutePath>
   with ChangeNotifier, PopNavigatorRouterDelegateMixin<UsersRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  String _selectedUser;
  bool show404 = false;
  List<String> users = ["Pandora", "Camila", "Marcela", "Vini", "Gabriel"];

  UsersRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  UsersRoutePath get currentConfiguration {
    if (show404) {
      return UsersRoutePath.unknown();
    }
    return _selectedUser == null
        ? UsersRoutePath.home()
        : UsersRoutePath.details(users.indexOf(_selectedUser));
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [ 
        MaterialPage(
          key: ValueKey('UsersListPage'),
          child: UsersScreen(
            users: users,
            didSelectUser: (user) =>_handleSelectedUser(user)
        )),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()) 
        else if(_selectedUser != null) 
          UserDetailsPage(user: _selectedUser)
      ],
      onPopPage: (route, result) {
        // fail fast
        if (!route.didPop(result)) {
          return false;
        }

        _selectedUser = null;
        show404 = false;
        notifyListeners();
       
        return true;
      },
    );
  }

  // Called by the Router when the routeInformationProvider reports that a new route has been pushed
  @override
  Future<void> setNewRoutePath(UsersRoutePath path) async {
    if (path.isUnknown) {
      _selectedUser = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > users.length - 1) {
        show404 = true;
        return;
      }
      _selectedUser = users[path.id];
    } else {
      _selectedUser = null;
    }

    show404 = false;
  }

  void _handleSelectedUser(String user) {
      _selectedUser = user;
      notifyListeners();
  }
}

class UsersRoutePath {
  final int id;
  final bool isUnknown;

  UsersRoutePath.home()
      : id = null,
        isUnknown = false;

  UsersRoutePath.details(this.id) : isUnknown = false;

  UsersRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
}
