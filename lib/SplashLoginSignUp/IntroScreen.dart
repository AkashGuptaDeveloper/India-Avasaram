//----------------------------------------------------------------------------//
import 'package:indiaavasaram/RoutingPackage/Packages.dart';
//----------------------------------------------------------------------------//
class IntroScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagIntroScreen.toString();

  @override
  IntroScreenState createState() => new IntroScreenState();
}

//----------------------------------------------------------------------------//
class IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  var _blankFocusNode = new FocusNode();
//------------------------------ConnectivityResult----------------------------//
  // ignore: non_constant_identifier_names
  bool NotConnected = false;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  // ignore: non_constant_identifier_names, unused_field, cancel_subscriptions
  StreamSubscription<ConnectivityResult> _ConnectivitySubscription;

//----------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
//--------------------------onInternetConnectivityChanged---------------------//
    _ConnectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
        if (_connectivityResult == ConnectivityResult.none) {
          NotConnected = true;
        } else {
          NotConnected = false;
        }
        GlobalFunction()
            .CheckConnectivityState(_connectivityResult, NotConnected);
      });
    });
//----------------------------------------------------------------------------//
  }

//========================_checkInternetConnectivity==========================//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        NotConnected = true;
      });
      _showDialog(GlobalFlag.InternetNotConnected);
    } else {
      NotConnected = false;
    }
  }

//----------------------------_showDialog-------------------------------------//
  void _showDialog(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    // ignore: deprecated_member_use
    _SnackBarscaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.start,
        style: GoogleFonts.getFont(
          GlobalFlag.GoogleFonts,
          fontStyle: FontStyle.normal,
          color: GlobalAppColor.WhiteColorCode,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          letterSpacing: 0.5,
        ),
      ),
      duration: Duration(seconds: GlobalFlag.DialogDuration),
      backgroundColor: GlobalAppColor.DialogMessageColor,
    ));
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
    _ConnectivitySubscription.cancel();
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
  void didUpdateWidget(covariant IntroScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO: implement didUpdateWidget
  }

//----------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new WillPopScope(
      onWillPop: () => GlobalFunction().ExitAppAlert(context),
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
                  child: NotConnected == true
                      ? new Center(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Container(
                              height: Adaptive.h(15),
                              child: Image.asset(
                                "assets/offline.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            new Container(
                                padding: EdgeInsets.all(15.0),
                                child: new Text(
                                  GlobalFlag.NotConnected,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.getFont(
                                    GlobalFlag.GoogleFonts,
                                    fontStyle: FontStyle.normal,
                                    color: GlobalAppColor.titleTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                )),
                          ],
                        ),
                      ))
                      : new Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//----------------------------------------------------------------------------//
                          new Image.asset(
                            'assets/AppIcon.png',
                            fit: BoxFit.contain,
                            height: Adaptive.h(15),
                          ),
                          new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
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
                          new SizedBox(height: Adaptive.h(10)),
//----------------------------------------------------------------------------//
                          new GestureDetector(
                            onTap: () async {
                              KeyboardUtil
                                  .hideKeyboard(
                                  context);
                              var result =
                              await Connectivity()
                                  .checkConnectivity();
                              if (result ==
                                  ConnectivityResult
                                      .none) {
                                _showDialog(GlobalFlag
                                    .InternetNotConnected);
                              } else {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                        SendLoginType:"Speaker Login"
                                      )),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left:25,right:25),
                              child: Container(
                                alignment:
                                Alignment.center,
                                height:
                                Adaptive.h(6.0),
                                decoration: new BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10.0),
                                    color:GlobalAppColor
                                        .ButtonColorCode),
                                child: Text(
                                  "Speaker Login",
                                  textAlign: TextAlign
                                      .center,
                                  style: GoogleFonts
                                      .getFont(
                                    GlobalFlag
                                        .GoogleFonts,
                                    fontStyle:
                                    FontStyle
                                        .normal,
                                    color: GlobalAppColor
                                        .WhiteColorCode,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                    fontSize: 16.sp,
                                    letterSpacing:
                                    0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
                          new GestureDetector(
                            onTap: () async {
                              KeyboardUtil
                                  .hideKeyboard(
                                  context);
                              var result =
                              await Connectivity()
                                  .checkConnectivity();
                              if (result ==
                                  ConnectivityResult
                                      .none) {
                                _showDialog(GlobalFlag
                                    .InternetNotConnected);
                              } else {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                          SendLoginType:"Subscriber Login"
                                      )),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left:25,right:25),
                              child: Container(
                                alignment:
                                Alignment.center,
                                height:
                                Adaptive.h(6.0),
                                decoration: new BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10.0),
                                    color:GlobalAppColor
                                        .ButtonColorCode),
                                child: Text(
                                  "Subscriber Login",
                                  textAlign: TextAlign
                                      .center,
                                  style: GoogleFonts
                                      .getFont(
                                    GlobalFlag
                                        .GoogleFonts,
                                    fontStyle:
                                    FontStyle
                                        .normal,
                                    color: GlobalAppColor
                                        .WhiteColorCode,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                    fontSize: 16.sp,
                                    letterSpacing:
                                    0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          new SizedBox(height: Adaptive.h(2)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
//---------------------------------------END-----------------------------------//
}
