import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/pages/item_grid/item_grid.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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
      body: const ItemGridPage(
        itemList: [],
        title: "title",
        isFavorite: true,
      ),
    );
  }
}
