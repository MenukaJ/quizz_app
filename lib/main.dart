import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/page/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/services/category_service.dart';
import 'package:quiz_app/services/options_service.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/services/questions_service.dart';


void setupLocator() {
  GetIt.instance.registerLazySingleton(() => CategoryService());
  GetIt.instance.registerLazySingleton(() => QuizService());
  GetIt.instance.registerLazySingleton(() => QuestionsService());
  GetIt.instance.registerLazySingleton(() => OptionsService());
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
