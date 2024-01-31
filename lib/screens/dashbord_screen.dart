import 'package:asktoai_app/constants/string_res.dart';
import 'package:asktoai_app/constants/common_colors.dart';
import 'package:asktoai_app/screens/chat_screen.dart';
import 'package:asktoai_app/screens/home_screen.dart';
import 'package:asktoai_app/screens/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardScreenLayout extends StatelessWidget {
  DashBoardScreenLayout({Key? key}) : super(key: key);

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return AdvancedDrawer(
        backdropColor: CommonColors.backgroundAppbar,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOutBack,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        drawer: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.0528,
                  right: screenWidth * 0.0628,
                  top: screenHeight * 0.0666,
                  bottom: screenHeight * 0.0333,
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: Image(image: AssetImage("assets/images/logo.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.01333,
                ),
                child: Text(
                  StringResource.drawerTitle,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                StringResource.drawerSubTitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01333,
              ),
              const Divider(
                indent: 15,
                color: Colors.white,
              ),
              ListTile(
                onTap: (() async {
                  var url = Uri.parse(StringResource.rateAppUrl);
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    throw "Could not launch $url";
                  }
                }),
                leading: SvgPicture.asset("assets/icons/rate_app_icon.svg"),
                title: const Text(
                  'Rate App',
                  style: TextStyle(color: CommonColors.colorWhite),
                ),
              ),
              ListTile(
                onTap: (() {
                  Share.share(StringResource.shareAppUrl);
                }),
                leading: SvgPicture.asset("assets/icons/share_fill_icon.svg"),
                title: const Text(
                  'Share With Friends',
                  style: TextStyle(color: CommonColors.colorWhite),
                ),
              ),
              ListTile(
                onTap: () async {
                  var url = Uri.parse(StringResource.termsAndConditionAppUrl);
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    throw "Could not launch $url";
                  }
                },
                leading:
                    SvgPicture.asset("assets/icons/trms_conditions_icon.svg"),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(color: CommonColors.colorWhite),
                ),
              ),
              ListTile(
                onTap: (() {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: StringResource.supportEmail,
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Frequantly Asked Question?',
                    }),
                  );
                  launchUrl(emailLaunchUri);

                  // controller.termsAndConditionsUrl();
                }),
                leading: SvgPicture.asset("assets/icons/fqa_icon.svg"),
                title: const Text(
                  'FAQs',
                  style: TextStyle(color: CommonColors.colorWhite),
                ),
              ),
              const Divider(
                indent: 15,
                color: Colors.white,
              ),
              ListTile(
                onTap: (() {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: StringResource.supportEmail,
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Help & Support',
                    }),
                  );
                  launchUrl(emailLaunchUri);

                  // controller.launchEmailSubmission();
                }),
                leading:
                    SvgPicture.asset("assets/icons/customer_support_icon.svg"),
                title: const Text(
                  'Customer Support',
                  style: TextStyle(color: CommonColors.colorWhite),
                ),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: const Text('Your Personal Chat Assistant!'),
                ),
              ),
            ],
          ),
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: CommonColors.background,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  ),
                ],
                bottom: TabBar(
                  automaticIndicatorColorAdjustment: true,
                  indicatorColor: CommonColors.backgroundAppbar,
                  unselectedLabelColor: Colors.white60,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                  labelColor: Colors.white,
                  tabs: const [
                    Tab(
                        child: Text(
                      "Home",
                      style: TextStyle(fontSize: 18),
                    )),
                    Tab(
                      child: Text(
                        "Chat",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Image",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                //centerTitle: true,
                title: const Text('ChatAI'),
                backgroundColor: CommonColors.backgroundAppbar),
            body: const TabBarView(
              children: [
                HomeScreenLayout(),
                ChatScreenLayout(),
                PhotoLayoutScreen(),
                // SettingScreen()
              ],
            ),
          ),
        ));
  }
}
