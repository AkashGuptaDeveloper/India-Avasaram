//----------------------------------------------------------------------------//
import 'package:indiaavasaram/RoutingPackage/Packages.dart';

//----------------------------------------------------------------------------//
class SplashScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSplashScreen.toString();

  @override
  SplashScreenState createState() => new SplashScreenState();
}

//----------------------------------------------------------------------------//
class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  double Height;

  // ignore: non_constant_identifier_names
  double Width;

  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  var _blankFocusNode = new FocusNode();
//----------------------------------------------------------------------------//
  void handleTimeout() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => IntroScreen(

          )),
    );
  }

//----------------------------------------------------------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return new Timer(
      duration,
      handleTimeout,
    );
  }

//----------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

//============================================================================//
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

//============================================================================//
  @override
  dispose() {
    super.dispose();
  }

//============================================================================//
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

//============================================================================//
  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO: implement didUpdateWidget
  }

//----------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    Height = MediaQuery.of(context).size.height;
    Width = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: _SnackBarscaffoldKey,
            backgroundColor: GlobalAppColor.AppColorCode,
            body: FadeAnimation(
                2,
                new SafeArea(
                  child: new Container(
                      child: new GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_blankFocusNode);
                          KeyboardUtil.hideKeyboard(context);
                        },
                        child: new Center(
                          child: SingleChildScrollView(
                              child:new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Image.asset(
                                    'assets/AppIcon.png',
                                    fit: BoxFit.contain,
                                    // height: Adaptive.h(25),
                                  ),
                                  new Text(GlobalFlag.Appname.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      GlobalFlag.GoogleFonts,
                                      fontStyle: FontStyle.normal,
                                      color: GlobalAppColor.WhiteColorCode,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19.sp,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )),
                )),
          ),
        );
      },
    );
  }
//---------------------------------------END-----------------------------------//
}
