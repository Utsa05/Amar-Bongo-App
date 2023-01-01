import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:flutter/material.dart';

class ItemGridPage extends StatelessWidget {
  const ItemGridPage({super.key, required this.title, this.isFavorite});
  final String title;
  final bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    var demolist = [
      'Result',
      'Shopping',
      "Ticket",
      "Univarsity",
      'Hospital',
      'Result',
      'Shopping',
      "Ticket",
      "Univarsity",
      'Hospital',
      'Result',
      'Shopping',
      "Ticket",
      "Univarsity",
      'Hospital',
      'Result',
      'Shopping',
      "Ticket",
      "Univarsity",
      'Hospital'
    ];
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 20.0, right: 14.0, left: 14.0),
        itemCount: demolist.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 130.0,
            crossAxisCount: 3,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0),
        itemBuilder: (context, index) {
          return GridItem(
            demolist: demolist,
            isFavorite: isFavorite,
            index: index,
          );
        });
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.demolist,
    required this.isFavorite,
    required this.index,
  }) : super(key: key);

  final List<String> demolist;
  final bool? isFavorite;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: AppColor.whiteColor,
            elevation: 0.0,
            onPressed: () {},
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
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
                isFavorite != true
                    ? Positioned(
                        right: -11.0,
                        top: -1.0,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(0.0),
                          minWidth: 27.0,
                          height: 27.0,
                          onPressed: () {},
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: const Icon(
                            Icons.favorite_outline,
                            size: 20.0,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      )
                    : Positioned(
                        right: -11.0,
                        top: -1.0,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(0.0),
                          minWidth: 27.0,
                          height: 27.0,
                          onPressed: () {},
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      )
              ],
            )));
  }
}
