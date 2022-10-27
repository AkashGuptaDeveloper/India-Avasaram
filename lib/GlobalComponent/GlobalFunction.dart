import 'package:indiaavasaram/RoutingPackage/Packages.dart';

//=============================GlobalFunction=================================//
class GlobalFunction {
  // ignore: non_constant_identifier_names
  final GlobalKey<ScaffoldState> _KeyExitApp = GlobalKey<ScaffoldState>();

//========================ExitAppAlert========================================//
  // ignore: non_constant_identifier_names
  Future<void> ExitAppAlert(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) =>
          ResponsiveSizer(
            builder: (context, orientation, deviceType) {
              return new WillPopScope(
                  onWillPop: () async => false,
                  key: _KeyExitApp,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
                    content: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            decoration: BoxDecoration(
                              color: GlobalAppColor.AppColorCode,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0)),
                            ),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Center(
                                  child: Text(GlobalFlag.exitanApp,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        GlobalFlag.GoogleFonts,
                                        fontStyle: FontStyle.normal,
                                        color: GlobalAppColor.WhiteColorCode,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        letterSpacing: 1,
                                      ))),
                            ),
                          ),
                          new Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: new GestureDetector(
                                    onTap: () async {
                                      KeyboardUtil.hideKeyboard(context);
                                      Navigator.pop(context);
                                      exit(0);
                                    },
                                    child: Container(
                                      color: GlobalAppColor.WhiteColorCode,
                                      alignment: Alignment.center,
                                      height: Adaptive.h(6),
                                      child: Text(
                                        GlobalFlag.Yes,
                                        style: GoogleFonts.getFont(
                                          GlobalFlag.GoogleFonts,
                                          fontStyle: FontStyle.normal,
                                          color: GlobalAppColor.AppColorCode,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                new Container(
                                  width: 2,
                                  height:45,
                                  color: GlobalAppColor.AppColorCode,
                                ),
                                Flexible(
                                  child: new GestureDetector(
                                    onTap: () async {
                                      KeyboardUtil.hideKeyboard(context);
                                      Navigator.pop(context);
                                      KeyboardUtil.hideKeyboard(context);
                                    },
                                    child: Container(
                                      color: GlobalAppColor.WhiteColorCode,
                                      alignment: Alignment.center,
                                      height: Adaptive.h(6),
                                      child: Text(
                                        GlobalFlag.No,
                                        style: GoogleFonts.getFont(
                                          GlobalFlag.GoogleFonts,
                                          fontStyle: FontStyle.normal,
                                          color: GlobalAppColor.AppColorCode,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
    );
  }

//========================_checkConnectivityState=============================//
  // ignore: non_constant_identifier_names
  Future<void> CheckConnectivityState(_connectivityResult, NotConnected) async {
    if (_connectivityResult == ConnectivityResult.none) {
      NotConnected = true;
    } else {
      NotConnected = false;
    }
  }
}