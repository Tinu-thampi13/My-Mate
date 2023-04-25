import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_mate/Bill%20Split/BShomescreen.dart';
import 'package:my_mate/Calculator/calc_homeScreen.dart';
import 'package:my_mate/Expense%20Manager/models/category/category_model.dart';
import 'package:my_mate/Expense%20Manager/screens/home/widgets/bottom_nav.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_mate/Notes/page/notes_page.dart';
import 'package:my_mate/Pomodoro/screens/homeScreen.dart';
import 'package:my_mate/Pomodoro/screens/timerservice.dart';
import 'package:my_mate/todo/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'Expense Manager/models/transaction/transaction_model.dart';
import 'Expense Manager/screens/transaction/widgets/add_transactions.dart';
import 'HomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(ChangeNotifierProvider<timerservice>(
    create: (_) => timerservice(),
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime timeBackPressed = DateTime.now();
  bool isdark = false;

  void setIsDark() {
    setState(() {
      isdark = !isdark;
    });
  }

  ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.grey[100],
    brightness: Brightness.light,
  );

  ThemeData _darkTheme = ThemeData(
    primaryColor: Colors.blueGrey.shade900,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isdark ? _darkTheme : _lightTheme,
        // ignore: void_checks
        home: homeScreen(setIsDark: setIsDark),

        routes: {
          '/transaction': (ctx) => const screenAdd_transaction(),
          '/calculator': (ctx) => Calc_homeScreen(),
          '/expenseManager': (ctx) => const bottom_nav(),
          '/notes': (ctx) => NotesPage(
                changeTheme: isdark,
              ),
          '/pomodoro': (ctx) => const homescreen(),
          '/todo': (ctx) => const HomePage(),
          '/BS_HomeScreen': (ctx) => BS_homescreen(
                changeTheme: !isdark,
              ),
        },
      ));
}
