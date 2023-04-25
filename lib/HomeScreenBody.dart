import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:my_mate/widget/About.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final bool _iconBool = false;
  final double _borderRadius = 24;
  late double rating;

  var items = [
    PlaceInfo('Bill Split', const Color(0xff6DC8F3), const Color(0xff73A1F9),
        3.7, 'Flutter', '/BS_HomeScreen'),
    PlaceInfo('Calculator', const Color(0xffFFB157), const Color(0xffFFA057),
        4.2, 'Flutter • Math_expressions', '/calculator'),
    PlaceInfo('Expense Manager', const Color(0xffFF5B95),
        const Color(0xffF8556D), 3.9, 'Flutter • Hive', '/expenseManager'),
    PlaceInfo('Notes', const Color(0xffD76EF5), const Color(0xff8F7AFE), 4.7,
        'Flutter • SQFlite', '/notes'),
    PlaceInfo('Pomodoro Timer', const Color(0xff42E695),
        const Color(0xff3BB2B8), 4.2, 'Flutter • Provider', '/pomodoro'),
    PlaceInfo('Todo List', const Color(0xff6DC8F3), const Color(0xff3BB2B8),
        4.5, 'Flutter • Hive', '/todo'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, items[index].routeName);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            gradient: LinearGradient(
                                colors: [
                                  items[index].startColor,
                                  items[index].endColor
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                color: items[index].endColor,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: CustomPaint(
                            size: const Size(100, 150),
                            painter: CustomCardShapePainter(_borderRadius,
                                items[index].startColor, items[index].endColor),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      items[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      items[index].category,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      items[index].rating.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    RatingBar(rating: items[index].rating),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            height: 44.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF846AFF).withOpacity(0.9),
                    const Color(0xFF755EE8).withOpacity(0.9),
                    Colors.purpleAccent.withOpacity(0.9),
                    Colors.amber.withOpacity(0.9),
                  ],
                )),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AboutPage())));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: const Icon(Icons.person_4_outlined),
            ),
          )),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do you want to Exit the app?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          );
        });
    return exitApp ?? false;
  }
}

RatingBar({required double rating}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(rating.floor(), (index) {
      return const Icon(
        Icons.star,
        color: Colors.white,
        size: 16,
      );
    }),
  );
}

class PlaceInfo {
  final String name;
  final String category;
  final double rating;
  final Color startColor;
  final Color endColor;
  final String routeName;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.category, this.routeName);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
