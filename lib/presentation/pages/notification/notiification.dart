import 'package:flutter/material.dart';

import '../../constants/color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
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
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                tileColor: AppColor.whiteColor,
                onTap: () {},
                subtitle: Column(
                  children: [
                    Text(
                      "Hey, there this is a notification from Amar Bongo that new version available please downlaod that and enjoy new features",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 15.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.normal),
                    ),
                    // const Divider()
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Update Version",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 19.0,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.history_outlined,
                          color: AppColor.redColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          "2 hours ago",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 12.0,
                                  color: AppColor.redColor,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
                leading: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(7.0)),
                  height: 50.0,
                  width: 50.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        size: 25.0,
                        color: AppColor.whiteColor,
                      ),
                      Text(
                        "10 jun",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10.0,
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
