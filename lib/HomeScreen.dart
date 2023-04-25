import 'package:flutter/material.dart';
import 'HomeScreenBody.dart';

class homeScreen extends StatefulWidget {
  late Function setIsDark;
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  homeScreen({super.key, required this.setIsDark});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isdark = false;
  bool _iconBool = false;

  final IconData _lightMode = Icons.wb_sunny;

  final IconData _nightMode = Icons.nights_stay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            iconTheme: _iconBool
                ? const IconThemeData(color: Colors.white)
                : const IconThemeData(color: Colors.white),
            elevation: 5,
            title: Text(
              'My Mate',
              style: _iconBool
                  ? const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF846AFF),
                  Color(0xFF755EE8),
                  Colors.purpleAccent,
                  Colors.amber,
                ],
              )),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 10),
                child: IconButton(
                  onPressed: () {
                    widget.setIsDark();

                    setState(() {
                      _iconBool = !_iconBool;
                    });
                  },
                  icon: Icon(_iconBool ? _nightMode : _lightMode),
                ),
              ),
            ],
          ),
        ),
        body: const HomeScreenBody());
  }
}
