import 'package:flutter/material.dart';
import 'package:my_mate/expense%20Manager/db/category/category_db.dart';
import 'package:my_mate/Expense%20Manager/screens/category/widgets/expense_category_list.dart';
import 'package:my_mate/Expense%20Manager/screens/category/widgets/income_category_list.dart';

// ignore: camel_case_types
class category_screen extends StatefulWidget {
  const category_screen({super.key});

  @override
  State<category_screen> createState() => _category_screenState();
}

// ignore: camel_case_types
class _category_screenState extends State<category_screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Column(
        children: [
          TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              income_category_list(),
              expense_category_list(),
            ]),
          )
        ],
      ),
    );
  }
}
