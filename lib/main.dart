// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fpod/src/dependency_injector/dependency_injector.dart';
import 'package:fpod/src/routes/routes.dart';

void main() {
  runApp(
    const DependencyInjector(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'fPod',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      routerConfig: routesApp.routes,
    );
  }
}
