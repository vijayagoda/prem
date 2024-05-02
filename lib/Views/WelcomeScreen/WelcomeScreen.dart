import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:yuktiidea/Views/BoardingScreen/BoardingScreen.dart';

import '../../Constants/ApiConstants.dart';
import '../../Constants/Colors.dart';
import '../../Services/Api_Services.dart';
import '../../Utils/Utils.dart';
import '../../Widgets/Custom/CustomText.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loadLogOut = false;
  logOutFun() async {
    setState(() {
      loadLogOut = true;
    });
    String apiUrl = baseUrl + logout;
    Map<String, String> header = {"Accept": "application/json"};

    var response = await ApiService().postData(apiUrl, header, {});
    if (response!['status'] == true) {
      setState(() {
        loadLogOut = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BoardingScreen()));
      Utils().showSnackBar(context, response['message']);
    } else {
      setState(() {
        loadLogOut = false;
      });
      Utils().showSnackBar(context, response['message']);
    }
  }

  bool loadDelete = false;
  deleteFun() async {
    setState(() {
      loadDelete = true;
    });
    String apiUrl = baseUrl + delete;
    Map<String, String> header = {"Accept": "application/json"};

    var response = await ApiService().postData(apiUrl, header, {});
    if (response!['status'] == true) {
      setState(() {
        loadDelete = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BoardingScreen()));
      Utils().showSnackBar(context, response['message']);
    } else {
      setState(() {
        loadDelete = false;
      });
      Utils().showSnackBar(context, response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CustomText(
              "Welcome",
              white,
              24,
              FontWeight.w400,
              TextOverflow.clip,
              TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          loadLogOut == true
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : NeumorphicButton(
                  onPressed: () {
                    logOutFun();
                  },
                  style: NeumorphicStyle(
                    lightSource: LightSource.bottomRight,
                    shape: NeumorphicShape.flat,
                    surfaceIntensity: 0,
                    color: scaffoldColor,
                    shadowLightColor: Colors.white10,
                    shadowLightColorEmboss: Colors.white10,
                    shadowDarkColorEmboss: Colors.white10,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    shadowDarkColor: secondaryTextColor,
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 4, bottom: 4),
                    child: CustomText(
                      "Logout",
                      buttonText,
                      18,
                      FontWeight.w400,
                      TextOverflow.fade,
                      TextAlign.center,
                    ),
                  ),
                ),
          SizedBox(
            height: 40,
          ),
          loadDelete == true
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : NeumorphicButton(
                  onPressed: () {
                    deleteFun();
                  },
                  style: NeumorphicStyle(
                    lightSource: LightSource.bottomRight,
                    shape: NeumorphicShape.flat,
                    surfaceIntensity: 0,
                    color: scaffoldColor,
                    shadowLightColor: Colors.white10,
                    shadowLightColorEmboss: Colors.white10,
                    shadowDarkColorEmboss: Colors.white10,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    shadowDarkColor: secondaryTextColor,
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 4, bottom: 4),
                    child: CustomText(
                      "Delete User",
                      buttonText,
                      18,
                      FontWeight.w400,
                      TextOverflow.fade,
                      TextAlign.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
