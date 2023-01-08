import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.itemList});
  final List<ItemEntity> itemList;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<ItemEntity> searchList = [];
  bool isSearching = false;
  @override
  void initState() {
    searchList = widget.itemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                ),
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
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (item) {
                              if (item.isEmpty) {
                                searchList = widget.itemList;
                                isSearching = false;
                              } else {
                                searchList = searchList
                                    .where((element) => element.title!
                                        .toLowerCase()
                                        .startsWith(item.toLowerCase()))
                                    .toList();

                                isSearching = true;
                              }

                              setState(() {});
                            },
                            controller: searchController,
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Search..."),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              searchController.clear();
                              searchList = widget.itemList;
                              isSearching = false;
                            });
                          },
                          child: Container(
                            height: 42.0,
                            alignment: Alignment.center,
                            width: 42.0,
                            decoration: BoxDecoration(
                                color: isSearching
                                    ? AppColor.redColor
                                    : AppColor.primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5.0))),
                            child: isSearching == false
                                ? const Icon(
                                    Icons.search_outlined,
                                    color: AppColor.whiteColor,
                                    size: 30.0,
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: AppColor.whiteColor,
                                    size: 30.0,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ItemGridPage(
                itemList: searchList,
                title: "title",
                isFavorite: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
