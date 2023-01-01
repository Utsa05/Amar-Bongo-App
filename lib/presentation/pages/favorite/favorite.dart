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
              fontSize: 22.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
        elevation: 0.0,
        leading: IconButton(
            splashRadius: 25.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: AppColor.bgColor,
      ),
      body: const ItemGridPage(
        title: "title",
        isFavorite: true,
      ),
    );
  }
}
