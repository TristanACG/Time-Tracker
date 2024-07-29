import 'package:flutter/material.dart';
import 'package:timetracker/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
          child: Settings(),
        ));
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  // late int workTime;
  // late int shortBreak;
  // late int longBreak;

  late SharedPreferences prefs;

  @override
  void initState()
  {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();

    readSettings();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize:24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget> [
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xFF455A64), "-", -1, WORKTIME, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(Color(0xFF009688), "+", 1,WORKTIME, updateSettings),


          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xFF455A64), "-", -1,SHORTBREAK, updateSettings),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtWork,
          ),
          SettingsButton(Color(0xFF009688), "+", 1, SHORTBREAK, updateSettings),


          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xFF455A64), "-", -1, LONGBREAK, updateSettings),
          TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtWork,
          ),
          SettingsButton(Color(0xFF009688), "+", 1, LONGBREAK, updateSettings),
        ],
        padding: EdgeInsets.all(20.0),
      )
    );
  }
  readSettings() async
  {
    prefs = await SharedPreferences.getInstance();

    int? workTime = prefs.getInt(WORKTIME);
    if(workTime == null)
    {
      await prefs.setInt(WORKTIME, int.parse('30'));
      workTime = 30;
    }

    int? shortBreak = prefs.getInt(SHORTBREAK);
    if(shortBreak == null)
    {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
      shortBreak = 5;
    }

    int? longBreak = prefs.getInt(LONGBREAK);
    if(longBreak == null)
    {
      await prefs.setInt(LONGBREAK, int.parse('20'));
      longBreak = 20;
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value)
  {
    switch(key)
        {
        case WORKTIME:
          {
            int? workTime = prefs.getInt(WORKTIME);
            workTime = workTime != null ? workTime += value : 30;
            if (workTime >= 1 && workTime <= 180)
              {
                prefs.setInt(WORKTIME, workTime);
                setState(() {
                  txtWork.text = workTime.toString();
                });
              }
          }
        case SHORTBREAK:
          {
            int? shortBreak = prefs.getInt(SHORTBREAK);
            shortBreak = shortBreak != null ? shortBreak += value : 5;
            if (shortBreak >= 1 && shortBreak <= 180)
            {
              prefs.setInt(SHORTBREAK, shortBreak);
              setState(() {
                txtShort.text = shortBreak.toString();
              });
            }

          }
        case LONGBREAK:
          {
            int? longBreak = prefs.getInt(LONGBREAK);
            longBreak = longBreak != null ? longBreak += value : 20;
            if (longBreak >= 1 && longBreak <= 180)
            {
              prefs.setInt(LONGBREAK, longBreak);
              setState(() {
                txtLong.text = longBreak.toString();
              });
            }

          }
    }

  }
}

