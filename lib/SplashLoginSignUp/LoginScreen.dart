//----------------------------------------------------------------------------//
import 'package:indiaavasaram/RoutingPackage/Packages.dart';
//----------------------------------------------------------------------------//
class LoginScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagLoginScreen.toString();
 // ignore: non_constant_identifier_names
  final String SendLoginType;
  LoginScreen({
    Key key,
    // ignore: non_constant_identifier_names
    this.SendLoginType,
  }) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

//----------------------------------------------------------------------------//
class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  var _blankFocusNode = new FocusNode();
  // ignore: non_constant_identifier_names
  TextEditingController UserNameController = new TextEditingController();
  final FocusNode myFocusNodeUserName = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController PasswordController = new TextEditingController();
  final FocusNode myFocusNodePassword = FocusNode();
  bool _obscureTextLogin = true;
//------------------------------ConnectivityResult----------------------------//
  // ignore: non_constant_identifier_names
  bool NotConnected = false;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  // ignore: non_constant_identifier_names, unused_field, cancel_subscriptions
  StreamSubscription<ConnectivityResult> _ConnectivitySubscription;
//--------------------------------------_toggleLogin------------------------//
  void _toggleLogin() {
    setState(() {
      KeyboardUtil.hideKeyboard(context);
      _obscureTextLogin = !_obscureTextLogin;
      KeyboardUtil.hideKeyboard(context);
    });
  }
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
  void didUpdateWidget(covariant LoginScreen oldWidget) {
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
      onWillPop: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => IntroScreen(

            )),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _SnackBarscaffoldKey,
        backgroundColor: GlobalAppColor.WhiteColorCode,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0), // here the desired height
            child: AppBar(
              // ignore: deprecated_member_use
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: GlobalAppColor.AppColorCode,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: new GestureDetector(
                  onTap: () {
                    setState(() {
                      KeyboardUtil.hideKeyboard(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => IntroScreen(

                            )),
                      );
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      // ignore: deprecated_member_use
                      Icons.arrow_back,
                      color: GlobalAppColor.WhiteColorCode,
                      size: Adaptive.h(3),
                    ),
                  )),
              centerTitle: true,
                flexibleSpace: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 5),
                      child: new Image.asset(
                        'assets/AppIcon.png',
                        fit: BoxFit.contain,
                        height: Adaptive.h(10),
                      ),
                    ),
                    new Text(GlobalFlag.Appname.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        GlobalFlag.GoogleFonts,
                        fontStyle: FontStyle.normal,
                        color: GlobalAppColor.WhiteColorCode,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                )
            )
        ),
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
                      : new  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
                        new Align(
                          alignment: Alignment.center,
                          child:new Text(widget.SendLoginType == "Speaker Login"?"Login As Speaker".toUpperCase():"Login As Subscriber".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              GlobalFlag.GoogleFonts,
                              fontStyle: FontStyle.normal,
                              color: GlobalAppColor.titleTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              letterSpacing: 0.5,
                                decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFE60316),
                              decorationStyle: TextDecorationStyle.double,
                              height: 1.5,

                            ),
                          ),
                        ),
                        new SizedBox(height: Adaptive.h(8)),
//----------------------------------------------------------------------------//
                        new Container(
                         padding: EdgeInsets.only(left:20,right:20),
                         child:new TextFormField(
                           enableInteractiveSelection:
                           true,
                           autocorrect: true,
                           cursorColor:
                           GlobalAppColor.AppColorCode,
                           style: GoogleFonts.getFont(
                             GlobalFlag.GoogleFonts,
                             fontStyle: FontStyle.normal,
                             color:  GlobalAppColor
                                 .titleTextColor,
                             fontWeight: FontWeight.normal,
                             fontSize: 15.sp,
                             letterSpacing: 0.5,
                           ),
                           focusNode: myFocusNodeUserName,
                           controller: UserNameController,
                           textInputAction:
                           TextInputAction.done,
                           keyboardType:
                           TextInputType.name,
                           decoration: InputDecoration(
                             prefixIcon: Icon(
                               // ignore: deprecated_member_use
                               FontAwesomeIcons.user,
                               color: Color(0xFF979797),
                               size: Adaptive.h(2.0),
                             ),
                             filled: true,
                             fillColor: Colors.grey[50],
                             contentPadding:
                             const EdgeInsets.all(
                                 10.0),
                             border: OutlineInputBorder(
                                 borderRadius:
                                 BorderRadius.circular(
                                     5.0),
                                 borderSide: BorderSide(
                                     width: 1,
                                     color: Colors
                                         .grey[100])),
                             enabledBorder:
                             OutlineInputBorder(
                               borderRadius:
                               BorderRadius.all(
                                   Radius.circular(5)),
                               borderSide: BorderSide(
                                 width: 1,
                                 color:Colors.grey[300],
                               ),
                             ),
                             focusedBorder:
                             OutlineInputBorder(
                               borderRadius:
                               BorderRadius.all(
                                   Radius.circular(5)),
                               borderSide: BorderSide(
                                   width: 1,
                                   color: GlobalAppColor
                                       .AppColorCode),
                             ),
                             errorBorder:
                             OutlineInputBorder(
                                 borderRadius:
                                 BorderRadius.all(
                                     Radius
                                         .circular(
                                         5)),
                                 borderSide:
                                 BorderSide(
                                     width: 1,
                                     color: Colors
                                         .red)),
                             errorStyle:
                             GoogleFonts.getFont(
                               GlobalFlag.GoogleFonts,
                               fontStyle: FontStyle.normal,
                               color: Colors.red,
                               fontWeight:
                               FontWeight.normal,
                               fontSize: 14.sp,
                               letterSpacing: 0.5,
                             ),
                             hintText:
                             "Username",
                             hintStyle:
                             GoogleFonts.getFont(
                               GlobalFlag.GoogleFonts,
                               fontStyle: FontStyle.normal,
                               color: Color(0xFF979797),
                               fontWeight:
                               FontWeight.normal,
                               fontSize: 15.sp,
                               letterSpacing: 0.5,
                             ),
                             floatingLabelBehavior:
                             FloatingLabelBehavior
                                 .always,
                           ),
                         ),
                       ),
                        new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
                        new Container(
                          padding: EdgeInsets.only(left:20,right:20),
                          child:new TextFormField(
                            obscureText:
                            _obscureTextLogin,
                            autocorrect: true,
                            enableInteractiveSelection:
                            true,
                            cursorColor: GlobalAppColor
                                .AppColorCode,
                            style: GoogleFonts.getFont(
                              GlobalFlag.GoogleFonts,
                              fontStyle: FontStyle.normal,
                              color:  GlobalAppColor
                                  .titleTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.sp,
                              letterSpacing: 0.5,
                            ),
                            focusNode: myFocusNodePassword,
                            controller: PasswordController,
                            textInputAction:
                            TextInputAction.done,
                            keyboardType:
                            TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.lock,
                                color: Color(0xFF979797),
                                size: Adaptive.h(2.0),
                              ),
                              suffixIcon:
                              GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons
                                      .eye
                                      : FontAwesomeIcons
                                      .eyeSlash,
                                  size: Adaptive.h(3),
                                  color: PasswordController
                                      .text ==
                                      ""
                                      ? Color(0xFF979797)
                                      : GlobalAppColor
                                      .AppColorCode,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding:
                              const EdgeInsets.all(
                                  10.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      5.0),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .grey[100])),
                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(5)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color:Colors.grey[300],
                                ),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: GlobalAppColor
                                        .AppColorCode),
                              ),
                              errorBorder:
                              OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius
                                          .circular(
                                          5)),
                                  borderSide:
                                  BorderSide(
                                      width: 1,
                                      color: Colors
                                          .red)),
                              errorStyle:
                              GoogleFonts.getFont(
                                GlobalFlag.GoogleFonts,
                                fontStyle: FontStyle.normal,
                                color: Colors.red,
                                fontWeight:
                                FontWeight.normal,
                                fontSize: 14.sp,
                                letterSpacing: 0.5,
                              ),
                              hintText:
                              "Password",
                              hintStyle:
                              GoogleFonts.getFont(
                                GlobalFlag.GoogleFonts,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF979797),
                                fontWeight:
                                FontWeight.normal,
                                fontSize: 15.sp,
                                letterSpacing: 0.5,
                              ),
                              floatingLabelBehavior:
                              FloatingLabelBehavior
                                  .always,
                            ),
                          ),
                        ),
                        new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
                        new GestureDetector(
                          onTap:(){
                            setState(() {
                              KeyboardUtil.hideKeyboard(context);
                            });
                          },
                          child:new Align(
                            alignment: Alignment.centerRight,
                            child:new Container(
                              padding: EdgeInsets.only(left:20,right:20),
                              child:new Text("Forgot Password?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  GlobalFlag.GoogleFonts,
                                  fontStyle: FontStyle.normal,
                                  color: GlobalAppColor.AppColorCode,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(height: Adaptive.h(3)),
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
                                "Login",
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
                        widget.SendLoginType == "Subscriber Login"?new GestureDetector(
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
                                    builder: (context) => SignUpScreen(
                                        SendLoginType:widget.SendLoginType
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
                                  border: Border.all(
                                    color: GlobalAppColor
                                        .titleTextColor,
                                    width: 1.0,
                                  ),
                                  color:GlobalAppColor
                                      .WhiteColorCode),
                              child: Text(
                                "New Subscriber Login",
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
                                      .titleTextColor,
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
                        ):new Container(),
                        widget.SendLoginType == "Subscriber Login"?new SizedBox(height: Adaptive.h(2)):new Container(),
//----------------------------------------------------------------------------//

                      ],
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
