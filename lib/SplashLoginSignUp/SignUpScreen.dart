//----------------------------------------------------------------------------//
import 'package:indiaavasaram/RoutingPackage/Packages.dart';

//----------------------------------------------------------------------------//
class SignUpScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSignUpScreen.toString();
  // ignore: non_constant_identifier_names
  final String SendLoginType;
  SignUpScreen({
    Key key,
    // ignore: non_constant_identifier_names
    this.SendLoginType,
  }) : super(key: key);
  @override
  SignUpScreenState createState() => new SignUpScreenState();
}

//----------------------------------------------------------------------------//
class SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _SnackBarscaffoldKey =
  GlobalKey<ScaffoldState>();
  var _blankFocusNode = new FocusNode();
  // ignore: non_constant_identifier_names
  TextEditingController FullNameController = new TextEditingController();
  final FocusNode myFocusNodeFullName = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController MobileController = new TextEditingController();
  final FocusNode myFocusNodeMobile = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController EmailController = new TextEditingController();
  final FocusNode myFocusNodeEmail = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController PasswordController = new TextEditingController();
  final FocusNode myFocusNodePassword = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController AddressController = new TextEditingController();
  final FocusNode myFocusNodeAddress = FocusNode();
  bool _obscureTextLogin = true;
  // ignore: non_constant_identifier_names
  File imageFile;
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
  void didUpdateWidget(covariant SignUpScreen oldWidget) {
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
            builder: (context) => LoginScreen(
                SendLoginType:widget.SendLoginType
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
                              builder: (context) => LoginScreen(
                                  SendLoginType:widget.SendLoginType
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
                      : new  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new SizedBox(height: Adaptive.h(2)),
//----------------------------------------------------------------------------//
                      new Align(
                        alignment: Alignment.center,
                        child:new Text("User Signup".toUpperCase(),
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
                      new SizedBox(height: Adaptive.h(1)),
                      new Container(
                        child: Column(
                          children: [
                            Container(
                              child: new Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: new Stack(
                                        fit: StackFit.loose,
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Center(
                                                child: imageFile == null
                                                    ? Container(
                                                  child: CircleAvatar(
                                                      radius:
                                                      Adaptive.h(
                                                          6),
                                                      backgroundImage:
                                                      new CachedNetworkImageProvider(GlobalServiceURL
                                                          .NoImagesUrl)),
                                                  decoration:
                                                  BoxDecoration(
                                                    shape: BoxShape
                                                        .circle,
                                                    border:
                                                    Border.all(
                                                      color: Colors
                                                          .grey[500],
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                )
                                                    : Container(
                                                  child: CircleAvatar(
                                                    radius:
                                                    Adaptive.h(6),
                                                    backgroundImage:
                                                    new FileImage(
                                                        imageFile),
                                                  ),
                                                  decoration:
                                                  BoxDecoration(
                                                    shape: BoxShape
                                                        .circle,
                                                    border:
                                                    Border.all(
                                                      color: Colors
                                                          .grey[500],
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 50.0, left: 100.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
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
                                                          _openImagePickerModal(
                                                              context);
                                                        }
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        GlobalAppColor
                                                            .AppColorCode,
                                                        radius:
                                                        Adaptive.h(2),
                                                        child: new Icon(
                                                          Icons.camera_alt,
                                                          color:
                                                          Colors.white,
                                                          size:
                                                          Adaptive.h(2),
                                                        ),
                                                      )),
                                                ],
                                              )),
                                        ]),
                                  )),
                              margin: EdgeInsets.only(top: 10.0),
                            ),
                            SizedBox(height: Adaptive.h(3)),
                          ],
                        ),
                      ),
//----------------------------------------------------------------------------//
                      new Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
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
                                  focusNode: myFocusNodeFullName,
                                  controller: FullNameController,
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
                                    "FullName",
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
                                  focusNode: myFocusNodeMobile,
                                  controller: MobileController,
                                  textInputAction:
                                  TextInputAction.done,
                                  keyboardType:
                                  TextInputType.phone,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      // ignore: deprecated_member_use
                                      FontAwesomeIcons.mobile,
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
                                    "Mobile",
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
                                  focusNode: myFocusNodeEmail,
                                  controller: EmailController,
                                  textInputAction:
                                  TextInputAction.done,
                                  keyboardType:
                                  TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      // ignore: deprecated_member_use
                                      FontAwesomeIcons.envelope,
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
                                    "Email",
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
                                  focusNode: myFocusNodeAddress,
                                  controller: AddressController,
                                  textInputAction:
                                  TextInputAction.done,
                                  keyboardType:
                                  TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      // ignore: deprecated_member_use
                                      FontAwesomeIcons.locationDot,
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
                                    "Address",
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
                                      "Submit",
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
//----------------------------------------------------------------------------//

                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
//-----------------------------------------------_OpenCamera------------------//
  // ignore: non_constant_identifier_names
  void _openImagePickerModal(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(0.0)),
        ),
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {
          return Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(0.0)),
              image: new DecorationImage(
                image: new AssetImage("assets/BackgroundImage.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Wrap(
              children: <Widget>[
                new Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Choose Profile photo",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      GlobalFlag.GoogleFonts,
                      fontStyle: FontStyle.normal,
                      color: GlobalAppColor.AppColorCode,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                new SizedBox(
                  height: Adaptive.h(0.5),
                ),
                new Column(
                  children: <Widget>[
                    new SizedBox(height: Adaptive.h(2)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton.icon(
                            icon: Icon(Icons.camera,
                                size: 20,
                                color: GlobalAppColor.titleTextColor),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              KeyboardUtil.hideKeyboard(context);
                              _pickImage(ImageSource.camera);
                            },
                            label: Text("Camera",
                                style: GoogleFonts.getFont(
                                  GlobalFlag.GoogleFonts,
                                  fontStyle: FontStyle.normal,
                                  color: GlobalAppColor.titleTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                )),
                          ),
                          // ignore: deprecated_member_use
                          FlatButton.icon(
                            icon: Icon(Icons.image,
                                size: 20,
                                color: GlobalAppColor.titleTextColor),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              KeyboardUtil.hideKeyboard(context);
                              _pickImage(ImageSource.gallery);
                            },
                            label: Text("Gallery",
                                style: GoogleFonts.getFont(
                                  GlobalFlag.GoogleFonts,
                                  fontStyle: FontStyle.normal,
                                  color: GlobalAppColor.titleTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                )),
                          ),
                        ])
                  ],
                ),
                new SizedBox(
                  height: Adaptive.h(0.5),
                ),
              ],
            ),
          );
        });
  }

//---------------------------------_pickImage---------------------------------//
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.imageFile = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed Image Pick: $e");
    }
  }
//---------------------------------------END-----------------------------------//
}
