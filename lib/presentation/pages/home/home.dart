// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/cubits/items/items_cubit.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/health.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/home_sub.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:amar_bongo_app/presentation/pages/notification/notiification.dart';
import 'package:amar_bongo_app/presentation/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 7,
          child: BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              if (state is ItemsLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //appbar
                    CustomAppbar(
                      itemList: state.itemList,
                    ),

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
                            text: AppString.eticket,
                          ),
                          Tab(
                            text: AppString.health,
                          ),
                          Tab(
                            text: AppString.shopping,
                          ),
                          Tab(
                            text: AppString.job,
                          ),
                        ]),
                    Expanded(
                        child: Tabview(
                      itemList: state.itemList,
                    )),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Tabview extends StatelessWidget {
  const Tabview({
    Key? key,
    required this.itemList,
  }) : super(key: key);
  final List<ItemEntity> itemList;

  @override
  Widget build(BuildContext context) {
    List<ItemEntity> getListbyCategory(
        String category, List<ItemEntity> itemList) {
      return itemList
          .where(((item) =>
              item.category!.toLowerCase() == category.toLowerCase()))
          .toList();
    }

    List<ItemEntity> goverments = getListbyCategory('government', itemList);
    List<ItemEntity> shoppings = getListbyCategory('shopping', itemList);
    List<ItemEntity> educations = getListbyCategory('education', itemList);
    List<ItemEntity> etickets = getListbyCategory('eticket', itemList);
    List<ItemEntity> jobs = getListbyCategory('jobs', itemList);

    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeSubPage(
          itemList: itemList,
        ),
        ItemGridPage(
          title: AppString.educaion,
          itemList: educations,
        ),
        ItemGridPage(title: AppString.goverment, itemList: goverments),
        ItemGridPage(title: AppString.eticket, itemList: etickets),
        const HealthPage(),
        ItemGridPage(title: AppString.shopping, itemList: shoppings),
        ItemGridPage(title: AppString.job, itemList: jobs),
      ],
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    required this.itemList,
  }) : super(key: key);
  final List<ItemEntity> itemList;

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
                    Navigator.pushNamed(context, RouteString.search,
                        arguments: itemList);
                  },
                  icon: const Icon(Icons.search_outlined))
            ],
          )
        ],
      ),
    );
  }
}
