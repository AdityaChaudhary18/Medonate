import 'package:dose_care/Screens/main_pages/blood_home.dart';
import 'package:dose_care/Screens/main_pages/equipment_home.dart';
import 'package:dose_care/Screens/main_pages/organ_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'landing.dart';
import '../pageNotFound.dart';

class NavBarPage extends StatefulWidget {
  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final PageController pageController = PageController();
  late TabController tabController;
  final List<Widget> pages = [
    LandingPage(),
    BloodHome(),
    OrganHome(),
    EquipmentHome()
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: pages.length);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> provider = Provider.of<ValueNotifier<bool>>(context);

    Widget gNav = AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: provider.value
          ? Container()
          : Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(left: 32.0),
              child: Material(
                color: Theme.of(context).bottomAppBarColor,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 8.0),
                    child: GNav(
                      gap: 4,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      duration: Duration(milliseconds: 500),
                      activeColor: Theme.of(context).primaryColor,
                      tabBackgroundColor: Theme.of(context).buttonColor,
                      color: Colors.black,
                      backgroundColor: Theme.of(context).bottomAppBarColor,
                      tabs: [
                        GButton(
                          icon: Icons.home_filled,
                          text: "Home",
                        ),
                        GButton(
                          icon: FontAwesomeIcons.tint,
                          text: "Blood",
                          textStyle: TextStyle(color: Colors.red),
                          iconActiveColor: Colors.red,
                          hoverColor: Colors.deepOrange,
                        ),
                        GButton(
                          icon: FontAwesomeIcons.lungs,
                          text: " Organ",
                          textStyle: TextStyle(color: Colors.teal),
                          iconActiveColor: Colors.teal,
                          hoverColor: Colors.greenAccent,
                        ),
                        GButton(
                          icon: FontAwesomeIcons.hospitalUser,
                          text: "Equipment",
                          textStyle: TextStyle(color: Colors.indigo),
                          iconActiveColor: Colors.indigo,
                          hoverColor: Colors.indigo,
                        ),
                      ],
                      selectedIndex: currentIndex,
                      onTabChange: (int index) {
                        setState(() {
                          currentIndex = index;
                          tabController.index = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
    );

    return Material(
      child: Scaffold(
        floatingActionButton: gNav,
        body: TabBarView(
          controller: tabController,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
