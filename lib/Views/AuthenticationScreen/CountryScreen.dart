import 'dart:developer';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:yuktiidea/Utils/SVG/Svg_View.dart';
import 'package:yuktiidea/Views/AuthenticationScreen/PhoneViewScreen.dart';
import 'package:yuktiidea/Widgets/Custom/CustomText.dart';
import 'package:yuktiidea/Widgets/text_field/text_field_widget.dart';

import '../../Constants/ApiConstants.dart';
import '../../Constants/Colors.dart';
import '../../Services/Api_Services.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  bool showLoading = false;
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    getCountries();
    controller = TextEditingController();
    super.initState();
  }

  var data;
  var noData;
  getCountries() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + countryList;
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
    log(response.toString());
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: CustomText(
              "Select your country",
              white,
              24,
              FontWeight.w400,
              TextOverflow.clip,
              TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                hintText: "Search",
              ),
            ),
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
              : noData == "NOK"
                  ? SizedBox()
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data['data'].length,
                        itemBuilder: (context, index) {
                          var country = data['data'][index];
                          var name = country['name'].toString();

                          if (controller.text.isEmpty) {
                            return CountryWid(country);
                          } else if (name
                              .toLowerCase()
                              .contains(controller.text)) {
                            return CountryWid(country);
                          } else {
                            print("No match for: $name"); // Debug print
                            return SizedBox(); // Return an empty SizedBox if no match
                          }
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  Widget CountryWid(country) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PhoneViewScreen(
                      selectedCountry: country,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: grey, width: 0.1))),
          child: ListTile(
            style: ListTileStyle.list,
            leading: SizedBox(
              width: 40,
              child: MySvgWidget(image: country['flag']),
            ),
            title: CustomText(country['name'], white, 18, FontWeight.w500,
                TextOverflow.ellipsis, TextAlign.left),
            trailing: CustomText(country['tel_code'].toString(), white, 14,
                FontWeight.w500, TextOverflow.ellipsis, TextAlign.left),
          ),
        ),
      ),
    );
  }
}
