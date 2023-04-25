// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, camel_case_types
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';

class screenAdd_transaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const screenAdd_transaction({super.key});

  @override
  State<screenAdd_transaction> createState() => _screenAdd_transactionState();
}

class _screenAdd_transactionState extends State<screenAdd_transaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;

  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: 800,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _purposeTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Purpose'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Amount'),
                ),
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );

                    if (_selectedDateTemp == null) {
                      return;
                    }

                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategorytype = CategoryType.income;
                              _categoryID = null;
                            });
                          },
                        ),
                        const Text('Income')
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategorytype = CategoryType.expense;
                              _categoryID = null;
                            });
                          },
                        ),
                        const Text('Expense')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: _categoryID,
                  items: (_selectedCategorytype == CategoryType.income
                          ? CategoryDB().incomeCategoryListListener
                          : CategoryDB().expenseCategoryListListener)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategorymodel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      _categoryID = selectedValue;
                    });
                  },
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_selectedCategorymodel == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }

    final _parseAmount = double.tryParse(_amountText);
    if (_parseAmount == null) {
      return;
    }
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parseAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategorymodel!,
    );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
