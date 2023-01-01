import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:flutter/material.dart';

class HomeSubPage extends StatelessWidget {
  const HomeSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var demolist = ['Result', 'Shopping', "Ticket", "Univarsity", 'Hospital'];
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Itemrow(
              demolist: demolist,
              title: "Education",
              tap: () {},
            ),
            Itemrow(
              demolist: demolist,
              title: "Goverment",
              tap: () {},
            ),
            Itemrow(
              demolist: demolist,
              title: "Health",
              tap: () {},
            ),
            Itemrow(
              demolist: demolist,
              title: "Shopping",
              tap: () {},
            ),
            Itemrow(
              demolist: demolist,
              title: "Jobs",
              tap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Itemrow extends StatelessWidget {
  const Itemrow({
    Key? key,
    required this.demolist,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final List<String> demolist;
  final String title;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
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
                children: List.generate(
                    demolist.length,
                    (index) => Stack(
                          children: [
                            Item(
                              demolist: demolist,
                              index: index,
                            ),
                            Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.all(0.0),
                                minWidth: 27.0,
                                height: 27.0,
                                onPressed: () {},
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                child: const Icon(
                                  Icons.favorite_outline,
                                  size: 20.0,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            )
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
    required this.demolist,
    required this.index,
  }) : super(key: key);

  final List<String> demolist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: AppColor.whiteColor,
          elevation: 0.0,
          onPressed: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 70,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                demolist[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColor.blackColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
