import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

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
                            controller: searchController,
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Search..."),
                          ),
                        ),
                        Container(
                          height: 42.0,
                          alignment: Alignment.center,
                          width: 42.0,
                          decoration: const BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5.0))),
                          child: const Icon(
                            Icons.search_outlined,
                            color: AppColor.whiteColor,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: ItemGridPage(
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
