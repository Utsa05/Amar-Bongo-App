import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Dog';

    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: DropdownButtonFormField(
                      isDense: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: AppColor.whiteColor,
                      ),
                      dropdownColor: AppColor.whiteColor,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                          .map<DropdownMenuItem<String>>((String value) {
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
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
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
                      },
                      items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                          .map<DropdownMenuItem<String>>((String value) {
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
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 12.0),
                      height: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.whiteColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                width: 80.0,
                                color: AppColor.bgColor,
                              ),
                              Positioned(
                                left: 0.0,
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 12.0,
                                  bottom: 5.0,
                                  top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Prantik Hospital",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.blackColor
                                                .withOpacity(0.9)),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.phone_outlined,
                                        size: 15.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "01866478941",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.normal,
                                                color: AppColor.blackColor
                                                    .withOpacity(0.7)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 14.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Dhaka,Bangladesh",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.normal,
                                                color: AppColor.blackColor
                                                    .withOpacity(0.7)),
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
                              minWidth: 60.0,
                              height: 27.0,
                              elevation: 0.0,
                              color: AppColor.goldenColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              onPressed: () {},
                              child: Text(
                                "View",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
