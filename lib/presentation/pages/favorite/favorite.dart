import 'package:amar_bongo_app/data/models/item_model.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/db_helper.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isFething = true;
  List<ItemFavModel> favoriteList = [];
  late DBHelper dbHelper;

  fetch() async {
    favoriteList = await dbHelper.fetchList().whenComplete(() {
      setState(() {
        isFething = false;
        if (isFething == false) {}
      });
    });

    print("Congress Feched");
    print(favoriteList.length);
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite (13)",
          style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.bgColor,
        elevation: 0.0,
      ),
      body: isFething == false
          ? favoriteList.isNotEmpty
              ? GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20.0, right: 14.0, left: 14.0),
                  itemCount: favoriteList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 130.0,
                      crossAxisCount: 3,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0),
                  itemBuilder: (context, index) {
                    return GridItem(
                      tab: () {
                        dbHelper
                            .delete(favoriteList[index].id!)
                            .whenComplete(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Deleted'),
                            backgroundColor: AppColor.redColor,
                          ));

                          fetch();
                        });
                      },
                      itemList: favoriteList,
                      isFavorite: true,
                      index: index,
                    );
                  })
              : const Center(
                  child: Text("No Item"),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.itemList,
    required this.isFavorite,
    required this.index,
    required this.tab,
  }) : super(key: key);

  final List<ItemFavModel> itemList;
  final bool? isFavorite;
  final int index;
  final GestureTapCallback tab;

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
              ItemEntity itemEntity = ItemEntity(
                  id: itemList[index].id.toString(),
                  image: itemList[index].image,
                  url: itemList[index].url,
                  category: itemList[index].category,
                  title: itemList[index].title);
              Navigator.pushNamed(context, RouteString.viewweb,
                  arguments: itemEntity);
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
                          onPressed: tab,
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
