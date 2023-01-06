// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/health.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/home_sub.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:amar_bongo_app/presentation/pages/notification/notiification.dart';
import 'package:amar_bongo_app/presentation/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //appbar
              const CustomAppbar(),

              //tab
              ButtonsTabBar(
                  physics: const BouncingScrollPhysics(),
                  backgroundColor: AppColor.goldenColor,
                  unselectedBackgroundColor: AppColor.whiteColor,
                  unselectedLabelStyle:
                      GoogleFonts.openSans(color: Colors.black),
                  labelStyle: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: AppString.forYou,
                    ),
                    Tab(
                      text: AppString.educaion,
                    ),
                    Tab(
                      text: AppString.goverment,
                    ),
                    Tab(
                      text: AppString.health,
                    ),
                    Tab(
                      text: AppString.eticket,
                    ),
                    Tab(
                      text: AppString.shopping,
                    ),
                  ]),
              const Expanded(
                child: Tabview(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabview extends StatelessWidget {
  const Tabview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeSubPage(),
        ItemGridPage(title: AppString.educaion),
        ItemGridPage(title: AppString.goverment),
        HealthPage(),
        ItemGridPage(title: AppString.eticket),
        ItemGridPage(title: AppString.shopping),
      ],
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: "${AppString.appName.split(" ").first} ",
              style: const TextStyle(
                  fontSize: 20.0,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: AppString.appName.split(" ").last,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppColor.redColor),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0.0),
                  splashRadius: 25,
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const NotificationPage()));
                  },
                  icon: const Icon(Icons.notifications_outlined)),
              IconButton(
                  padding: const EdgeInsets.all(0.0),
                  splashRadius: 25,
                  iconSize: 28.0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search_outlined))
            ],
          )
        ],
      ),
    );
  }
}
