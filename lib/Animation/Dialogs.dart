import 'package:indiaavasaram/RoutingPackage/Packages.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ResponsiveSizer(
            builder: (context, orientation, deviceType) {
              return SimpleDialog(
                  key: key,
                  backgroundColor: GlobalAppColor.WhiteColorCode,
                  children: <Widget>[
                    new Container(
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/BackgroundImage.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Column(children: [
                            CircularProgressIndicator(
                              backgroundColor: GlobalAppColor.AppColorCode,
                              color: Colors.grey[500],
                              strokeWidth: Adaptive.w(1.0),
                            ),
                            new SizedBox(height: Adaptive.h(1)),
                            Text(
                              GlobalFlag.PleaseWait,
                              style: GoogleFonts.getFont(
                                GlobalFlag.GoogleFonts,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                letterSpacing: 0.5,
                              ),
                            )
                          ]),
                        )),
                  ]);
            },
          );
        });
  }
}
//=====================================End====================================//
