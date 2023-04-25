import 'package:flutter/material.dart';
import 'package:my_mate/Expense%20Manager/screens/home/widgets/bottom_nav.dart';

import '../category/category_screen.dart';
import '../category/widgets/category_add_popup.dart';
import '../transaction/transaction_screen.dart';

// ignore: camel_case_types
class home_screen extends StatefulWidget {
  late Function setIsDark;
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  home_screen({super.key, required this.setIsDark});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final _pages = const [
    transaction_screen(),
    category_screen(),
  ];

  bool _iconBool = false;

  IconData _lightMode = Icons.wb_sunny;

  IconData _nightMode = Icons.nights_stay;

  // theme: _iconBool ? _darkTheme : _lightTheme,
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const bottom_nav(),
        body: ValueListenableBuilder(
            valueListenable: home_screen.selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex];
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (home_screen.selectedIndexNotifier.value == 0) {
              Navigator.of(context).pushNamed('/transaction');
            } else {
              showCategoryAddPopup(context);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
