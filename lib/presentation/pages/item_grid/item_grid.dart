import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemGridPage extends StatelessWidget {
  const ItemGridPage(
      {super.key,
      required this.title,
      this.isFavorite,
      required this.itemList});
  final String title;
  final bool? isFavorite;
  final List<ItemEntity> itemList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 20.0, right: 14.0, left: 14.0),
        itemCount: itemList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 130.0,
            crossAxisCount: 3,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0),
        itemBuilder: (context, index) {
          return GridItem(
            itemList: itemList,
            isFavorite: isFavorite,
            index: index,
          );
        });
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.itemList,
    required this.isFavorite,
    required this.index,
  }) : super(key: key);

  final List<ItemEntity> itemList;
  final bool? isFavorite;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: AppColor.whiteColor,
            elevation: 0.0,
            onPressed: () {
              Navigator.pushNamed(context, RouteString.viewweb, arguments: {
                "url": itemList[index].url,
                "title": itemList[index].title
              });
            },
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                              .copyWith(
                                  color: AppColor.blackColor, fontSize: 13.0),
                        ),
                      )
                    ],
                  ),
                ),
                isFavorite != true
                    ? const SizedBox()
                    // Positioned(
                    //     right: -11.0,
                    //     top: -1.0,
                    //     child: MaterialButton(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4)),
                    //       padding: const EdgeInsets.all(0.0),
                    //       minWidth: 27.0,
                    //       height: 27.0,
                    //       onPressed: () {},
                    //       color:
                    //           Theme.of(context).primaryColor.withOpacity(0.5),
                    //       child: const Icon(
                    //         Icons.favorite_outline,
                    //         size: 20.0,
                    //         color: AppColor.whiteColor,
                    //       ),
                    //     ),
                    //   )
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
