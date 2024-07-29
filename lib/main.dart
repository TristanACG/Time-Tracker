import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timetracker/timer.dart';
import 'package:timetracker/widgets.dart';

import 'TimerModel.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Work Timer",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: (TimerHomePage()),
    );
  } //Build Method
}

class TimerHomePage extends StatelessWidget {
  double defaultPadding = 10;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Work Timer"),
          //style: TextStyle(color: Colors.black),
          actions: [
            PopupMenuButton<String>(itemBuilder: (BuildContext context) {
              return menuItems.toList();
            }, onSelected: (s) {
              if (s == "Settings") {
                goToSettings(context);
              }
            })
          ],
        ),
        body: Column(
          children: [
            Row(children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff009688),
                text: "Work",
                onPressed: () => timer.startWork(),
                size: 10,
              )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff607d8b),
                text: "Short Break",
                onPressed: () => timer.startBreak(true),
                size: 10,
              )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff455a64),
                text: "Long Break",
                onPressed: () => timer.startBreak(false),
                size: 10,
              )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
            ]),
            Expanded(
                child: StreamBuilder(
              initialData: '00:00',
              stream: timer.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                TimerModel timerM = (snapshot.data == '00:00')
                    ? TimerModel('00:00', 1)
                    : snapshot.data;
                return Expanded(
                  child: CircularPercentIndicator(
                    radius: 175,
                    lineWidth: 30,
                    percent: timerM.percent,
                    center: Text(timerM.time,
                        style: Theme.of(context).textTheme.headlineMedium),
                    progressColor: Color(0xff009688),
                  ),
                );
              },
            )),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                  color: Color(0xff009688),
                  text: "Stop",
                  onPressed: () => timer.stopTimer(),
                  size: 10,
                )),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                  color: Color(0xff009688),
                  text: "Resume",
                  onPressed: () => timer.startTimer(),
                  size: 10,
                )),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            )
          ],
        ));
  }

  void emptyMethod() {}

  void goToSettings(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
  }
}
