import 'package:flutter/cupertino.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fpod/src/common/dependency_injectors/dependency_injector.dart';
import 'package:fpod/src/common/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  dependencyInjector();
  final Routes appRoutes = Routes();
  runApp(MyApp(appRoutes: appRoutes));
}

class MyApp extends StatelessWidget {
  final Routes appRoutes;

  const MyApp({super.key, required this.appRoutes});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'fPod',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      routerConfig: appRoutes.routes,
    );
  }
}
