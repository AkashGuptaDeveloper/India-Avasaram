import 'package:indiaavasaram/RoutingPackage/Packages.dart';

//============================================================================//
class Preferences {
  // ignore: non_constant_identifier_names
  static var KEY_AstrologerID = "Astrologer_id";

  // ignore: non_constant_identifier_names
  static var KEY_FirstName = "First_name";

  // ignore: non_constant_identifier_names
  static var KEY_LastName = "Last_name";

  // ignore: non_constant_identifier_names
  static var KEY_Dob = "Dob";

  // ignore: non_constant_identifier_names
  static var KEY_Gender = "Gender";

  // ignore: non_constant_identifier_names
  static var KEY_Mobile = "Mobile";

  // ignore: non_constant_identifier_names
  static var KEY_Email = "Email";

  // ignore: non_constant_identifier_names
  static var KEY_Address = "Address";

  // ignore: non_constant_identifier_names
  static var KEY_ProfilePic = "ProfilePic";

  // ignore: non_constant_identifier_names
  static var KEY_About = "About";

  // ignore: non_constant_identifier_names
  static var KEY_FullName = "";

//==storeDataAtLogin==========================================================//
  storeDataAtLogin(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_AstrologerID, data[0]["Astrologer_id"].toString());
    prefs.setString(KEY_FirstName, data[0]["First_name"].toString());
    prefs.setString(KEY_LastName, data[0]["Last_name"].toString());
    prefs.setString(KEY_Dob, data[0]["Dob"].toString());
    prefs.setString(KEY_Gender, data[0]["Gender"].toString());
    prefs.setString(KEY_Mobile, data[0]["Mobile"].toString());
    prefs.setString(KEY_Email, data[0]["Email"].toString());
    prefs.setString(KEY_Address, data[0]["Address"].toString());
    prefs.setString(KEY_ProfilePic, data[0]["ProfilePic"].toString());
    prefs.setString(KEY_About, data[0]["About"].toString());
    prefs.setString(KEY_FullName,
        data[0]["First_name"] + " " + data[0]["Last_name"].toString());
//==Print=====================================================================//
    /*print("KEY_AstrologerID" + data[0]["Astrologer_id"].toString());
    print("KEY_FirstName" + data[0]["First_name"].toString());
    print("KEY_LastName" + data[0]["Last_name"].toString());
    print("KEY_FullName" + data[0]["First_name"]+" "+data[0]["Last_name"].toString().toString());*/
  }
}
//============================================================================//
