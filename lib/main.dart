import 'package:flutter/material.dart';
import 'package:uitoolkit1/configs/routes.dart';
import 'package:uitoolkit1/screens/account_screen.dart';
import 'package:uitoolkit1/screens/home_screen.dart';
import 'package:uitoolkit1/screens/messages_screen.dart';
import 'package:uitoolkit1/screens/wishlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _tabIndex = 0;
  String _selected = Routes.home;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _exportIndexed(_selected),
        children: const [
          HomeScreen(),
          WishlistScreen(),
          MessagesScreen(),
          AccountScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomMenu(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// build bottom menu
  Widget _buildBottomMenu() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItemMenu(Routes.home),
            _buildItemMenu(Routes.wishlist),
            const SizedBox(width: 56),
            _buildItemMenu(Routes.message),
            _buildItemMenu(Routes.account),
          ],
        ),
      ),
    );
  }

  /// Build item menu
  Widget _buildItemMenu(String route) {
    Color? color;
    String title = 'home';
    IconData iconData = Icons.help_outline;
    switch (route) {
      case Routes.home:
        iconData = Icons.home;
        title = 'Home';
        break;
      case Routes.wishlist:
        iconData = Icons.bookmark_outline;
        title = 'Wishlist';
        break;
      case Routes.message:
        iconData = Icons.chat_outlined;
        title = 'Messages';
        break;
      case Routes.account:
        iconData = Icons.account_circle_outlined;
        title = 'Account';
        break;
      default:
        iconData = Icons.home;
        title = 'Home';
    }
    if (_selected == route) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        setState(() {
          _selected = route;
        });
      },
      padding: EdgeInsets.zero,
      icon: Column(
        children: [
          Icon(iconData, color: color),
          const SizedBox(height: 2),
          Text(title,
              style: TextStyle(color: color, fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  ///Export index stack
  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.wishlist:
        return 1;
      case Routes.message:
        return 2;
      case Routes.account:
        return 3;
      default:
        return 0;
    }
  }
}
