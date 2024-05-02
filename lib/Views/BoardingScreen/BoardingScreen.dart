import 'package:flutter/gestures.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktiidea/Constants/Colors.dart';
import 'package:yuktiidea/Views/AuthenticationScreen/CountryScreen.dart';
import 'package:yuktiidea/Views/BoardingScreen/TermsAndConditions.dart';
import 'package:yuktiidea/Widgets/Custom/CustomText.dart';

import '../../Constants/Images.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              boardingbackground,
            ),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 300,
              decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomText("Welcome to Study Lancer", white, 24,
                      FontWeight.w600, TextOverflow.ellipsis, TextAlign.center),
                  SizedBox(
                    height: 6,
                  ),
                  CustomText(
                      "Please select your role to get registered",
                      white,
                      14,
                      FontWeight.w400,
                      TextOverflow.ellipsis,
                      TextAlign.center),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CountryScreen()));
                            },
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                lightSource: LightSource.bottomRight,
                                surfaceIntensity: 0,
                                color: scaffoldColor,
                                shadowLightColor: transparent,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(16)),
                                shadowDarkColor: grey),
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                boardingstudent,
                                scale: 5,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            "Student",
                            white,
                            14,
                            FontWeight.w600,
                            TextOverflow.fade,
                            TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CountryScreen()));
                            },
                            style: NeumorphicStyle(
                                lightSource: LightSource.bottomRight,
                                shape: NeumorphicShape.flat,
                                surfaceIntensity: 0,
                                color: scaffoldColor,
                                shadowLightColor: transparent,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(16)),
                                shadowDarkColor: grey),
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                boardingagent,
                                scale: 5,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            "Agent",
                            white,
                            14,
                            FontWeight.w600,
                            TextOverflow.fade,
                            TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "By continuing you agree to our ",
                              style: GoogleFonts.metrophobic(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: white,
                              )),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TermsAndConditions()),
                                  );
                                },
                              onEnter: (PointerExitEvent) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TermsAndConditions()));
                                print("Click Terms and Conditions");
                              },
                              text: "Terms and Conditions",
                              style: GoogleFonts.metrophobic(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              )),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
