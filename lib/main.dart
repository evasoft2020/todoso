import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoso/db/db_helper.dart';
import 'package:todoso/services/theme_service.dart';
import 'package:todoso/ui/home_page.dart';
import 'package:todoso/ui/theme.dart';

Future<void> main() async {
  await DBHelper.initDb();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      title: 'ToDoSo',
      themeMode: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
