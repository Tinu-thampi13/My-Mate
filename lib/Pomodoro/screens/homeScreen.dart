import 'package:flutter/material.dart';
import 'package:my_mate/Pomodoro/screens/timerservice.dart';
import 'package:my_mate/Pomodoro/screens/widgets/progress.dart';
import 'package:my_mate/Pomodoro/screens/widgets/timecontroller.dart';
import 'package:my_mate/Pomodoro/screens/widgets/timercard.dart';
import 'package:my_mate/Pomodoro/screens/widgets/timeroptions.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class homescreen extends StatelessWidget {
  const homescreen({super.key});
  Color renderColor(String currentState) {
    if (currentState == "FOCUS") {
      return Colors.redAccent;
    } else {
      return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<timerservice>(context);
    return Scaffold(
      backgroundColor: renderColor(provider.currentState),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: renderColor(provider.currentState),
        title: Row(
          children: [
            const Text(
              'POMOTIMER',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 113,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              'How to use:\n\n1. Set the focus time as much as you want.\n\n2. Start the timer.\n\n 3. A break time will be provided after every round of focus time.\n\n4. This POMODORO Timer will gradually increase your productivity.\n\n'),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const TimerCard(),
              const SizedBox(
                height: 50,
              ),
              timerOptions(),
              const SizedBox(
                height: 100,
              ),
              const timeController(),
              const SizedBox(
                height: 80,
              ),
              const progress()
            ],
          ),
        ),
      ),
    );
  }
}
