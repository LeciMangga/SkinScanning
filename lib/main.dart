import 'package:skinscanning/src/startup/startup_view.dart';
import 'package:skinscanning/src/core/base_import.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Auth());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppPages.routes,
      title: 'Skin Scanning',
      theme: ThemeData.light(),
      home: const StartupView(),
    );
  }
}
