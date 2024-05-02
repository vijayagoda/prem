import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuktiidea/Services/Api_Services.dart';
import 'package:yuktiidea/Utils/Utils.dart';
import 'package:yuktiidea/Views/AuthenticationScreen/OtpScreen.dart';

import '../../Constants/ApiConstants.dart';
import '../../Constants/Colors.dart';
import '../../Utils/SVG/Svg_View.dart';
import '../../Widgets/Custom/CustomText.dart';

class PhoneViewScreen extends StatefulWidget {
  final selectedCountry;
  const PhoneViewScreen({required this.selectedCountry});

  @override
  State<PhoneViewScreen> createState() => _PhoneViewScreenState();
}

class _PhoneViewScreenState extends State<PhoneViewScreen> {
  bool showLoading = false;

  late TextEditingController controller;
  var error;
  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
  }

  sendOtp() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + studentLogin;
    Map<String, String> header = {"Accept": "application/json"};

    var body = {
      "tel_code": widget.selectedCountry['tel_code'].toString(),
      "phone": controller.text.toString(),
    };
    var response = await ApiService().postData(apiUrl, header, body);
    if (response!['status'] == true) {
      setState(() {
        showLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => OtpScren(
                    phoneNumber: controller.text.toString(),
                    selectedCountry: widget.selectedCountry,
                  )));
      Utils().showSnackBar(context, response['message']);
    } else {
      setState(() {
        error = response['message'];
        showLoading = false;
      });
      Utils().showSnackBar(context, response['message']);
    }
  }

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
                "Enter phone number",
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
                  "Please enter your 10 digit mobile number to receive OTP",
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
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.metrophobic(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                  // maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "9999999999",
                    hintStyle: GoogleFonts.metrophobic(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: grey.withOpacity(0.4),
                    ),
                    prefixIcon: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MySvgWidget(image: widget.selectedCountry['flag']),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            child: Center(
                              child: CustomText(
                                widget.selectedCountry['tel_code'],
                                white,
                                18,
                                FontWeight.w500,
                                TextOverflow.fade,
                                TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 1),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(0.4)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(0.4)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(0.4)),
                    ),
                  ),
                  inputFormatters: [
                    // LengthLimitingTextInputFormatter(10),
                  ]),
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
              height: 100,
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
                      if (controller.text.isEmpty) {
                        Utils().showSnackBar(context, "Field is Empty");
                      } else {
                        sendOtp();
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
                        "Get OTP",
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
