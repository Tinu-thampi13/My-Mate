// import 'package:flutter/material.dart';
// import 'package:my_mate/HomeScreen.dart';
// import '../home_screen.dart';

// // ignore: camel_case_types
// class bottom_nav extends StatelessWidget {
//   const bottom_nav({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: home_screen.selectedIndexNotifier,
//       builder: (BuildContext ctx, int updatedIndex, Widget? _) {
//         return BottomNavigationBar(
//             selectedItemColor: Colors.blue,
//             unselectedItemColor: Colors.grey,
//             currentIndex: updatedIndex,
//             onTap: (newIndex) {
//               home_screen.selectedIndexNotifier.value = newIndex;
//               print(homeScreen.selectedIndexNotifier.value);
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_balance_wallet_outlined),
//                 label: 'Transactions',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.category_outlined),
//                 label: 'Categories',
//               )
//             ]);
//       },
//     );
//   }
// }

///////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:my_mate/Expense%20Manager/screens/category/category_screen.dart';
import 'package:my_mate/Expense%20Manager/screens/category/widgets/category_add_popup.dart';
import 'package:my_mate/Expense%20Manager/screens/transaction/transaction_screen.dart';
import 'package:my_mate/Expense%20Manager/screens/transaction/widgets/add_transactions.dart';
import 'package:my_mate/HomeScreen.dart';
import '../home_screen.dart';

// ignore: camel_case_types
class bottom_nav extends StatefulWidget {
  const bottom_nav({super.key});

  @override
  State<bottom_nav> createState() => _bottom_navState();
}

class _bottom_navState extends State<bottom_nav> {
  int pageCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('PEM'),
              const SizedBox(
                width: 205,
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'How to use:\n\n1. Create your personalised categories by clicking on categories icon and press add button. \n\n2. Add all the transactions of this month by clicking on transaction icon and then press the add button.\n\n3. Your transaction will automatically get sorted according to the date and category.\n\n4. Swipe right to delete a transaction.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'))
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.info_outline, color: Colors.white))
            ],
          ),
        ),
        body: pageCurrentIndex == 0
            ? const transaction_screen()
            : const category_screen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pageCurrentIndex == 0
                ? Navigator.of(context).pushNamed('/transaction')
                : showCategoryAddPopup(context);
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: pageCurrentIndex,
            onTap: (newIndex) {
              setState(() {
                pageCurrentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories',
              )
            ]));
  }
}
