import 'dart:developer';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../Constants/ApiConstants.dart';
import '../../Constants/Colors.dart';
import '../../Services/Api_Services.dart';
import '../../Widgets/Custom/CustomText.dart';
import 'WelcomeScreen.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  bool showLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getCountries();
    super.initState();
  }

  var data;
  var noData;
  getCountries() async {
    setState(() {
      showLoading = true;
    });
    String apiUrl = baseUrl + selectCountryGet;
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

  Map d = {
    "status": true,
    "message": "List of Available Countries",
    "data": {
      "profile_status": "none",
      "role": "student",
      "selected_country": null,
      "countries": [
        {
          "id": 1,
          "name": "Canada",
          "flag": "https://flagcdn.com/ca.svg",
          "image":
              "https://studylancer-bucket.blr1.cdn.digitaloceanspaces.com/system/canada.png"
        },
        {
          "id": 2,
          "name": "Australia",
          "flag": "https://flagcdn.com/au.svg",
          "image":
              "https://studylancer-bucket.blr1.cdn.digitaloceanspaces.com/system/australia.png"
        }
      ]
    }
  };
  var selected;
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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomText(
                  "Select Country",
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
                    "Please select the country where you want to study",
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
              showLoading == false
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
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: d['data']['countries'].length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              var item = d['data']['countries'][index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected = item;
                                  });
                                },
                                child: Column(
                                  children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        selected == item
                                            ? transparent
                                            : grey.withOpacity(
                                                0.7), // Desired color and opacity
                                        BlendMode
                                            .srcATop, // Blend mode to apply the color
                                      ),
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              item['image'].toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 10),
                                      child: Center(
                                        child: CustomText(
                                          item['name'].toString(),
                                          grey,
                                          18,
                                          FontWeight.w400,
                                          TextOverflow.clip,
                                          TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
          Positioned(
            bottom: 00,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => WelcomeScreen()));
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
                          left: 30, right: 30, top: 4, bottom: 4),
                      child: CustomText(
                        "Proceed",
                        buttonText,
                        18,
                        FontWeight.w400,
                        TextOverflow.fade,
                        TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Center(
                      child: CustomText(
                        "Can’t see the country of your interest?",
                        white,
                        12,
                        FontWeight.w400,
                        TextOverflow.clip,
                        TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 14),
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: CustomText(
                          "Consult with us",
                          primaryColor,
                          18,
                          FontWeight.w500,
                          TextOverflow.clip,
                          TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
