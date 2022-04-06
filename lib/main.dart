import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_ii_example/model/CategoryNew.dart';
import 'package:quiz_app_ii_example/page/category_page.dart';
import 'package:quiz_app_ii_example/page/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app_ii_example/services/notes_service.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => NotesService());
}

Future main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Quiz App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(), // CategoryPage(category: categories.first),
      );
}
