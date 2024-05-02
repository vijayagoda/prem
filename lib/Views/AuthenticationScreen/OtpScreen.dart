import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../Constants/ApiConstants.dart';
import '../../Constants/Colors.dart';
import '../../Services/Api_Services.dart';
import '../../Utils/Utils.dart';
import '../../Widgets/Custom/CustomText.dart';
import '../WelcomeScreen/selectCountry.dart';

class OtpScren extends StatefulWidget {
  final phoneNumber;
  final selectedCountry;
  OtpScren({required this.phoneNumber, required this.selectedCountry});

  @override
  State<OtpScren> createState() => _OtpScrenState();
}

class _OtpScrenState extends State<OtpScren> {
  bool showLoading = false;
  OtpFieldController otpFieldController = OtpFieldController();
  bool isOtpSent = false;
  var vId;

  CountdownController countdownController =
      CountdownController(autoStart: true);
  bool timeout = false;
  var error;
  verifySentOtp() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + verifyOtp;
    Map<String, String> header = {"Accept": "application/json"};

    var body = {
      "code": otpFieldController.toString(),
      "phone":
          "${widget.selectedCountry['tel_code'].toString()}${widget.phoneNumber.toString()}",
    };
    var response = await ApiService().postData(apiUrl, header, body);
    if (response!['status'] == true) {
      setState(() {
        showLoading = false;
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScren()));
      Utils().showSnackBar(context, response['message']);
    } else {
      setState(() {
        error = response['data'];
        showLoading = false;
      });

      Utils().showSnackBar(context, response['message']);
    }
  }

  resendPhoneOtp() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + resendOtp;
    Map<String, String> header = {"Accept": "application/json"};

    var body = {
      "phone":
          "${widget.selectedCountry['tel_code'].toString()}${widget.phoneNumber.toString()}",
    };
    var response = await ApiService().postData(apiUrl, header, body);
    if (response!['status'] == true) {
      setState(() {
        showLoading = false;
      });
      Utils().showSnackBar(context, response['message']);
    } else {
      setState(() {
        showLoading = false;
      });
      Utils().showSnackBar(context, response['message']);
    }
  }

  bool showTimer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Transform.scale(
          scale: 0.6,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.pop(context);
              print("onClick");
            },
            style: NeumorphicStyle(
                lightSource: LightSource.bottomRight,
                shape: NeumorphicShape.flat,
                surfaceIntensity: 0,
                color: scaffoldColor,
                shadowLightColor: transparent,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                shadowDarkColor: grey),
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.clear,
              color: white,
            ),
          ),
        ),
        backgroundColor: transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                "Verify Number",
                white,
                24,
                FontWeight.w400,
                TextOverflow.clip,
                TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Center(
                child: CustomText(
                  "Please enter the OTP received to verify your number",
                  primaryColor,
                  14,
                  FontWeight.w400,
                  TextOverflow.clip,
                  TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              color: grey.withOpacity(0.1),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OTPTextField(
                length: 4,
                controller: otpFieldController,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                otpFieldStyle: OtpFieldStyle(
                  borderColor: grey,
                  focusBorderColor: grey,
                  enabledBorderColor: grey,
                  errorBorderColor: red,
                ),
                onCompleted: (pin) {},
              ),
            ),
            SizedBox(
              height: 50,
            ),
            error == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
                    child: Center(
                      child: CustomText(
                        error.toString(),
                        red,
                        14,
                        FontWeight.w400,
                        TextOverflow.clip,
                        TextAlign.center,
                      ),
                    ),
                  ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
              child: Center(
                child: CustomText(
                  "Didn’t receive OTP?",
                  grey,
                  14,
                  FontWeight.w400,
                  TextOverflow.clip,
                  TextAlign.center,
                ),
              ),
            ),
            timeout == false
                ? Countdown(
                    controller: countdownController,
                    interval: const Duration(milliseconds: 1000),
                    seconds: 30,
                    build: (_, remainingTime) => CustomText(
                      "00:${(remainingTime.toString().length == 4) ? remainingTime.toString().substring(0, 2) : "0${remainingTime.toString().substring(0, 1)}"}",
                      grey,
                      18,
                      FontWeight.w500,
                      TextOverflow.clip,
                      TextAlign.center,
                    ),
                    onFinished: () {
                      setState(() {
                        timeout = true;
                      });
                    },
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Center(
                      child: InkWell(
                        onTap: timeout == false
                            ? () {}
                            : () {
                                resendPhoneOtp();
                              },
                        child: CustomText(
                          "Resend OTP",
                          timeout == false ? grey : primaryColor,
                          18,
                          FontWeight.w600,
                          TextOverflow.clip,
                          TextAlign.center,
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 50,
            ),
            showLoading == true
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
                      if (otpFieldController.toString().isEmpty) {
                        Utils().showSnackBar(context, "Field is Empty");
                      } else {
                        // verifySentOtp();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SelectCountryScreen()));
                      }
                    },
                    style: NeumorphicStyle(
                      lightSource: LightSource.bottomRight,
                      shape: NeumorphicShape.flat,
                      surfaceIntensity: 0,
                      color: scaffoldColor,
                      shadowLightColor: Colors.white10,
                      shadowLightColorEmboss: Colors.white10,
                      shadowDarkColorEmboss: Colors.white10,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(30)),
                      shadowDarkColor: secondaryTextColor,
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 4, bottom: 4),
                      child: CustomText(
                        "Verify",
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
      ),
    );
  }
}
