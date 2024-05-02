import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuktiidea/Constants/ApiConstants.dart';
import 'package:yuktiidea/Constants/Colors.dart';
import 'package:yuktiidea/Services/Api_Services.dart';
import 'package:yuktiidea/Widgets/Custom/CustomText.dart';

import '../../Constants/Images.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool showLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getTermsAndConditions();
    super.initState();
  }

  var data;
  var noData;
  getTermsAndConditions() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + termsAndConditions;
    var header = {"Accept": "application/json"};
    var response = await ApiService().getData(apiUrl, header);
    if (response!['status'] == true) {
      setState(() {
        data = response;

        showLoading = false;
      });
    } else {
      setState(() {
        noData = "NOK";
        showLoading = false;
      });
    }
  }

  var date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox(),
        backgroundColor: transparent,
        actions: [
          NeumorphicButton(
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
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: showLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : noData == "NOK"
              ? SizedBox()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            tandc,
                            scale: 5,
                            filterQuality: FilterQuality.high,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  data['data']['title'].toString(),
                                  primaryColor,
                                  18,
                                  FontWeight.w500,
                                  TextOverflow.clip,
                                  TextAlign.start),
                              CustomText(
                                  "Updated ${DateTime.parse(data['data']['updated_at'].toString()).day}/${DateTime.parse(data['data']['updated_at'].toString()).month}/${DateTime.parse(data['data']['updated_at'].toString()).year}",
                                  secondaryTextColor,
                                  14,
                                  FontWeight.w400,
                                  TextOverflow.clip,
                                  TextAlign.start),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: HtmlWidget(data['data']['content']),
                      ),
                    ],
                  ),
                ),
    );
  }
}
