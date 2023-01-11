// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/pages/home/subpages/health.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSubPage extends StatelessWidget {
  const HomeSubPage({Key? key, required this.itemList}) : super(key: key);
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

    List<ItemEntity> goverments = getListbyCategory('goverment', itemList);
    List<ItemEntity> shoppings = getListbyCategory('shopping', itemList);
    List<ItemEntity> educations = getListbyCategory('education', itemList);
    List<ItemEntity> etickets = [];
    List<ItemEntity> railway = getListbyCategory('railway', itemList);
    List<ItemEntity> carRental = getListbyCategory('car rental', itemList);
    List<ItemEntity> bus = getListbyCategory('bus', itemList);
    List<ItemEntity> air = getListbyCategory('air', itemList);
    List<ItemEntity> hotelBooking =
        getListbyCategory('hotel booking', itemList);
    etickets.addAll(bus);
    etickets.addAll(air);
    etickets.addAll(railway);
    etickets.addAll(carRental);
    etickets.addAll(hotelBooking);
    List<ItemEntity> jobs = getListbyCategory('jobs', itemList);
    List<ItemEntity> healths = getListbyCategory('health', itemList);
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Itemrow(
            itemList: healths,
            title: AppString.health,
            tap: () {},
          ),
          Itemrow(
            itemList: etickets,
            title: AppString.eticket,
            tap: () {},
          ),
          Itemrow(
            itemList: educations,
            title: "Education",
            tap: () {},
          ),
          Itemrow(
            itemList: goverments,
            title: "Goverment",
            tap: () {},
          ),
          Itemrow(
            itemList: shoppings,
            title: "Shopping",
            tap: () {},
          ),
          Itemrow(
            itemList: jobs,
            title: "Jobs",
            tap: () {},
          ),
        ],
      ),
    ));
  }
}

class Itemrow extends StatelessWidget {
  const Itemrow({
    Key? key,
    required this.itemList,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final List<ItemEntity> itemList;
  final String title;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14.0,
                        color: AppColor.blackColor,
                      ),
                ),
                // TextButton(
                //   onPressed: tap,
                //   child: Text(
                //     "View All",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headline6!
                //         .copyWith(fontSize: 15.0, color: AppColor.blackColor),
                //   ),
                // )
              ],
            ),
          ),
          const SizedBox(
            height: 13.0,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(right: 16.0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                    itemList.length,
                    (index) => Stack(
                          children: [
                            title == AppString.health
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: HealthItem(
                                        searchList: itemList, index: index))
                                : Item(
                                    itemList: itemList,
                                    index: index,
                                  ),
                            // Positioned(
                            //   right: 0.0,
                            //   top: 0.0,
                            //   child: MaterialButton(
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(4)),
                            //     padding: const EdgeInsets.all(0.0),
                            //     minWidth: 27.0,
                            //     height: 27.0,
                            //     onPressed: () {},
                            //     color: Theme.of(context)
                            //         .primaryColor
                            //         .withOpacity(0.3),
                            //     child: const Icon(
                            //       Icons.favorite_outline,
                            //       size: 20.0,
                            //       color: AppColor.whiteColor,
                            //     ),
                            //   ),
                            // )
                          ],
                        ))),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.itemList,
    required this.index,
  }) : super(key: key);

  final List<ItemEntity> itemList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          height: 130.0,
          child: MaterialButton(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: AppColor.whiteColor,
            elevation: 0.0,
            onPressed: () {
              Navigator.pushNamed(context, RouteString.viewweb,
                  arguments: itemList[index]);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                itemList[index].image == null
                    ? Container(
                        width: 78.0,
                        height: 60.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.blackColor.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.photo_outlined,
                          color: AppColor.blackColor.withOpacity(0.4),
                          size: 35.0,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: itemList[index].image!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 78.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: AppColor.blackColor.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: imageProvider,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          width: 78.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.blackColor.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.error_outline,
                            color: AppColor.blackColor.withOpacity(0.4),
                            size: 35.0,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 85.0,
                  child: Text(
                    itemList[index].title!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AppColor.blackColor, fontSize: 13.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
