import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HealthPage extends StatefulWidget {
  final List<ItemEntity> itemList;
  const HealthPage({super.key, required this.itemList});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  List<ItemEntity> searchList = [];
  List<ItemEntity> prevsearchList = [];
  List<ItemEntity> prevTextsearchList = [];
  bool isSearching = false;
  bool isClickedType = false;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchList = widget.itemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Type';

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, top: 10.0, right: 15.0, bottom: 15.0),
                  width: double.infinity,
                  height: 42.0,
                  decoration: const BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5.0))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 0.0),
                        child: Icon(
                          Icons.search_outlined,
                          color: AppColor.blackColor,
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (item) {
                            if (item.isEmpty) {
                              if (isClickedType) {
                                searchList = prevsearchList;
                              } else {
                                searchList = widget.itemList;
                              }

                              isSearching = false;
                            } else {
                              searchList = searchList
                                  .where((element) => element.title!
                                      .toLowerCase()
                                      .startsWith(item.toLowerCase()))
                                  .toList();

                              isSearching = true;
                            }

                            prevTextsearchList = searchList;

                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Search..."),
                        ),
                      ),

                      // Container(
                      //   height: 42.0,
                      //   alignment: Alignment.center,
                      //   width: 42.0,
                      //   decoration: const BoxDecoration(
                      //       color: AppColor.primaryColor,
                      //       borderRadius: BorderRadius.only(
                      //           topRight: Radius.circular(5),
                      //           bottomRight: Radius.circular(5.0))),
                      // child: const Icon(
                      //   Icons.search_outlined,
                      //   color: AppColor.whiteColor,
                      //   size: 30.0,
                      // ),
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 140.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
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
                      if (newValue!.toLowerCase() != "type") {
                        if (newValue.toLowerCase() == "all" &&
                            isSearching == false) {
                          searchList = widget.itemList;
                        } else if (newValue.toLowerCase() == "all" &&
                            isSearching == true) {
                          searchList = prevTextsearchList;
                        } else {
                          if (isClickedType && isSearching == false) {
                            searchList = widget.itemList
                                .where((element) => element.type!
                                    .split("|")
                                    .first
                                    .toLowerCase()
                                    .startsWith(newValue.toLowerCase()))
                                .toList();
                          } else if (isSearching == true) {
                            searchList = prevTextsearchList
                                .where((element) => element.type!
                                    .split("|")
                                    .first
                                    .toLowerCase()
                                    .startsWith(newValue.toLowerCase()))
                                .toList();
                          } else {
                            searchList = searchList
                                .where((element) => element.type!
                                    .split("|")
                                    .first
                                    .toLowerCase()
                                    .startsWith(newValue.toLowerCase()))
                                .toList();
                          }
                        }
                      }
                      prevsearchList = searchList;
                      isClickedType = true;
                      setState(() {});
                    },
                    items: <String>[
                      "Type",
                      'All',
                      "demo",
                      'Online',
                      'Hospital',
                      'Blood Bank',
                      'Ambulance'
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: const [
                // Expanded(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(5.0),
                //     child: DropdownButtonFormField(
                //       isDense: true,
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         filled: true,
                //         fillColor: AppColor.whiteColor,
                //       ),
                //       dropdownColor: AppColor.whiteColor,
                //       value: dropdownValue,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           dropdownValue = newValue!;
                //         });
                //       },
                //       items: <String>['Type', 'Online', 'Cat', 'Tiger', 'Lion']
                //           .map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(
                //             value,
                //             style: const TextStyle(fontSize: 16),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 15.0,
                // ),
                // Expanded(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(5.0),
                //     child: DropdownButtonFormField(
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         filled: true,
                //         fillColor: AppColor.whiteColor,
                //       ),
                //       value: dropdownValue,
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           dropdownValue = newValue!;
                //         });
                //         if (newValue!.toLowerCase() != "type") {
                //           if (newValue.toLowerCase() == "all" &&
                //               isSearching == false) {
                //             searchList = widget.itemList;
                //           } else if (newValue.toLowerCase() == "all" &&
                //               isSearching == true) {
                //             searchList = prevTextsearchList;
                //           } else {
                //             if (isClickedType && isSearching == false) {
                //               searchList = widget.itemList
                //                   .where((element) => element.type!
                //                       .split("|")
                //                       .first
                //                       .toLowerCase()
                //                       .startsWith(newValue.toLowerCase()))
                //                   .toList();
                //             } else if (isSearching == true) {
                //               searchList = prevTextsearchList
                //                   .where((element) => element.type!
                //                       .split("|")
                //                       .first
                //                       .toLowerCase()
                //                       .startsWith(newValue.toLowerCase()))
                //                   .toList();
                //             } else {
                //               searchList = searchList
                //                   .where((element) => element.type!
                //                       .split("|")
                //                       .first
                //                       .toLowerCase()
                //                       .startsWith(newValue.toLowerCase()))
                //                   .toList();
                //             }
                //           }
                //         }
                //         prevsearchList = searchList;
                //         isClickedType = true;
                //         setState(() {});
                //       },
                //       items: <String>[
                //         "Type",
                //         'All',
                //         "demo",
                //         'Online',
                //         'Hospital',
                //         'Blood Bank',
                //         'Ambulance'
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(
                //             value,
                //             style: const TextStyle(fontSize: 16),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return HealthItem(
                      searchList: searchList,
                      index: index,
                    );
                  }))
        ],
      ),
    );
  }
}

class HealthItem extends StatelessWidget {
  const HealthItem({
    Key? key,
    required this.searchList,
    required this.index,
  }) : super(key: key);

  final List<ItemEntity> searchList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
      height: 112.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColor.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchList[index].image == null
              ? Container(
                  width: 80.0,
                  height: 80.0,
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
                  imageUrl: searchList[index].image!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
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
                    width: 80.0,
                    height: 80.0,
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
          // Stack(
          //   children: [
          //     Container(
          //       height: 80,
          //       width: 80.0,
          //       color: AppColor.bgColor,
          //     ),
          //     Positioned(
          //       left: 0.0,
          //       top: 0.0,
          //       child: MaterialButton(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(4)),
          //         padding: const EdgeInsets.all(0.0),
          //         minWidth: 27.0,
          //         height: 27.0,
          //         onPressed: () {},
          //         color: Theme.of(context)
          //             .primaryColor
          //             .withOpacity(0.5),
          //         child: const Icon(
          //           Icons.favorite_outline,
          //           size: 20.0,
          //           color: AppColor.whiteColor,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 12.0, bottom: 5.0, top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    searchList[index].title!,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: AppColor.blackColor.withOpacity(0.9)),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Expanded(
                        child: Text(
                          searchList[index].type!.split('|').last,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.blackColor.withOpacity(0.7)),
                        ),
                      ),
                      const Icon(
                        Icons.copy_outlined,
                        size: 20.0,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Expanded(
                        child: Text(
                          searchList[index].address ?? "",
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.blackColor.withOpacity(0.7)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: MaterialButton(
              minWidth: 45.0,
              height: 25.0,
              elevation: 0.0,
              color: AppColor.goldenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () {
                Navigator.pushNamed(context, RouteString.viewweb,
                    arguments: searchList[index]);
              },
              child: Text(
                "View",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColor.whiteColor, fontSize: 12.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
