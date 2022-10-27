//==========================Import-Library====================================//
import 'package:indiaavasaram/RoutingPackage/Packages.dart';
import 'package:wakelock/wakelock.dart';
//----------------------------------------------------------------------------//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

//----------------------------------------------------------------------------//
Map<int, Color> color = {
  50: Color.fromRGBO(14,42,90, .1),
  100: Color.fromRGBO(14,42,90, .2),
  200: Color.fromRGBO(14,42,90, .3),
  300: Color.fromRGBO(14,42,90, .4),
  400: Color.fromRGBO(14,42,90, .5),
  500: Color.fromRGBO(14,42,90, .6),
  600: Color.fromRGBO(14,42,90, .7),
  700: Color.fromRGBO(14,42,90, .8),
  800: Color.fromRGBO(14,42,90, .9),
  900: Color.fromRGBO(14,42,90, .10),
};

//---------------------------------StatelessWidget----------------------------//
class MyApp extends StatelessWidget {
//----------------------------Generated-Widget build-------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: GlobalAppColor.AppColorCode));
    MaterialColor colorCustom = MaterialColor(0xFF0E2A5A, color);
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

//---------------------------------MyHttpOverrides----------------------------//
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//---------------------------------------END-----------------------------------//
