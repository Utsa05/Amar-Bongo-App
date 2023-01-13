// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/data/models/push_noti_model.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/cubits/items/items_cubit.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/health.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/home_sub.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:amar_bongo_app/presentation/pages/nointernet.dart';
import 'package:amar_bongo_app/presentation/pages/notification/notiification.dart';
import 'package:amar_bongo_app/presentation/pages/push_notification/badge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ignore: avoid_print
      print('User granted permission');

      // // For handling the received notifications
      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   // Parse the message received
      //   PushNotification notification = PushNotification(
      //     title: message.notification?.title,
      //     body: message.notification?.body,
      //   );

      //   setState(() {
      //     _notificationInfo = notification;
      //     _totalNotifications++;
      //   });
      // });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // ...
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 5),
          );
        }
      });
    } else {
      // ignore: avoid_print
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    registerNotification();
    super.initState();
  }

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
                            text: AppString.health,
                          ),
                          Tab(
                            text: AppString.eticket,
                          ),
                          Tab(
                            text: AppString.educaion,
                          ),
                          Tab(
                            text: AppString.goverment,
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
              } else if (state is ItemsNoInternet) {
                return const NoInteret();
              } else if (state is ItemsFailuare) {
                return const Center(
                  child: Text("Something Wrong"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Tabview extends StatefulWidget {
  const Tabview({
    Key? key,
    required this.itemList,
  }) : super(key: key);
  final List<ItemEntity> itemList;

  @override
  State<Tabview> createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> {
  String dropdownValue = "All";
  List<ItemEntity> searchList = [];
  bool isCategoryTap = false;
  List<ItemEntity> getListbyCategory(
      String category, List<ItemEntity> itemList) {
    return itemList
        .where(
            ((item) => item.category!.toLowerCase() == category.toLowerCase()))
        .toList();
  }

  List<ItemEntity> goverments = [];
  List<ItemEntity> shoppings = [];
  List<ItemEntity> educations = [];
  List<ItemEntity> etickets = [];
  List<ItemEntity> railway = [];
  List<ItemEntity> carRental = [];
  List<ItemEntity> bus = [];
  List<ItemEntity> air = [];
  List<ItemEntity> hotelBooking = [];
  List<ItemEntity> healths = [];
  List<ItemEntity> jobs = [];

  getAllItem() {
    goverments = getListbyCategory('goverment', widget.itemList);
    shoppings = getListbyCategory('shopping', widget.itemList);
    educations = getListbyCategory('education', widget.itemList);

    railway = getListbyCategory('railway', widget.itemList);
    carRental = getListbyCategory('car rental', widget.itemList);
    bus = getListbyCategory('bus', widget.itemList);
    air = getListbyCategory('air', widget.itemList);
    hotelBooking = getListbyCategory('hotel booking', widget.itemList);
    etickets.addAll(bus);
    etickets.addAll(air);
    etickets.addAll(railway);
    etickets.addAll(carRental);
    etickets.addAll(hotelBooking);
    searchList = etickets;
    jobs = getListbyCategory('jobs', widget.itemList);
    healths = getListbyCategory('health', widget.itemList);
  }

  @override
  void initState() {
    getAllItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeSubPage(
          itemList: widget.itemList,
        ),
        HealthPage(itemList: healths),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 180.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppColor.whiteColor,
                  ),
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });

                    if (newValue!.toLowerCase() == "all") {
                      searchList = etickets;
                    } else {
                      if (isCategoryTap) {
                        searchList = etickets
                            .where((element) => element.category!
                                .toLowerCase()
                                .startsWith(newValue.toLowerCase()))
                            .toList();
                      } else {
                        searchList = searchList
                            .where((element) => element.category!
                                .toLowerCase()
                                .startsWith(newValue.toLowerCase()))
                            .toList();
                      }
                    }
                    isCategoryTap = true;
                    setState(() {});
                  },
                  items: <String>[
                    'All',
                    'Air',
                    "Bus",
                    'Railway',
                    'Car Rental',
                    'Hotel Booking'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
                child: ItemGridPage(
                    title: AppString.eticket, itemList: searchList)),
          ],
        ),
        ItemGridPage(
          title: AppString.educaion,
          itemList: educations,
        ),
        ItemGridPage(title: AppString.goverment, itemList: goverments),
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
