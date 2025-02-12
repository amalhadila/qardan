import 'package:flutter/material.dart';
import 'package:qardan/features/login/presentation/views/lang_view.dart';
import 'package:qardan/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewBody extends StatefulWidget {
  @override
  _SettingViewBodyState createState() => _SettingViewBodyState();
}

class _SettingViewBodyState extends State<SettingViewBody> {
  bool isDarkMode = false;
  bool isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      isNotificationsEnabled = prefs.getBool('isNotificationsEnabled') ?? true;
    });
  }

  Future<void> _updateSettings(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _toggleDarkMode(bool value) async {
    setState(() {
      isDarkMode = value;
    });
    await _updateSettings('isDarkMode', value);
    MyApp.restartApp(context, value);
  }

  Widget buildListTile(String title, IconData icon,
      {VoidCallback? onTap, bool? switchValue, Function(bool)? onSwitchChanged}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: switchValue != null
          ? Switch(
              value: switchValue,
              onChanged: (value) {
                if (onSwitchChanged != null) {
                  onSwitchChanged(value);
                }
              },
              activeColor: Colors.green,
            )
          : Icon(Icons.arrow_forward, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildListTile("تعديل الملف", Icons.person, onTap: () {}),
            Divider(),
            buildListTile("الإشعارات", Icons.notifications,
                switchValue: isNotificationsEnabled,
                onSwitchChanged: (value) {
                  setState(() {
                    isNotificationsEnabled = value;
                  });
                  _updateSettings('isNotificationsEnabled', value);
                }),
            Divider(),
            buildListTile("الوضع الداكن", Icons.dark_mode,
                switchValue: isDarkMode, onSwitchChanged: _toggleDarkMode),
            buildListTile("اللغه", Icons.language, onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LangView()));
            }),
            buildListTile("تسجيل الخروج", Icons.logout, onTap: () {}),
            Divider(),
            buildListTile("مساعدة", Icons.help, onTap: () {}),
            buildListTile("أسئلة شائعة", Icons.question_answer, onTap: () {}),
            buildListTile("من نحن؟", Icons.info, onTap: () {}),
          ],
        ),
      ),
    );
  }
}
