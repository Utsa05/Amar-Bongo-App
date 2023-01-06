import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColor.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            ListTile(
                horizontalTitleGap: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                contentPadding:
                    const EdgeInsets.only(right: 14.0, top: 5.0, bottom: 5.0),
                tileColor: AppColor.whiteColor,
                trailing: MaterialButton(
                  color: AppColor.goldenColor,
                  elevation: 0.0,
                  minWidth: 60.0,
                  height: 33.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: AppColor.whiteColor, fontSize: 14.0),
                  ),
                ),
                title: Text(
                  "John Smith",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: AppColor.blackColor, fontSize: 19.0),
                ),
                subtitle: Text(
                  "john@gmail.com",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0),
                ),
                leading: Container(
                  width: 70.0,
                  decoration: const BoxDecoration(
                      color: AppColor.bgColor, shape: BoxShape.circle),
                )),
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: ItemWIdget(
                title: "Something",
                icon: Icons.downhill_skiing,
              ),
            ),
            const ItemWIdget(
              title: "Contact Us",
              icon: Icons.email_outlined,
            ),
            const ItemWIdget(
              title: "Policy & Privacy",
              icon: Icons.privacy_tip_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWIdget extends StatelessWidget {
  const ItemWIdget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
      onTap: () {},
      contentPadding: const EdgeInsets.all(0.0),
      leading: Container(
        height: 35.0,
        width: 25.0,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Icon(
          icon,
          size: 16.0,
          color: AppColor.whiteColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: AppColor.blackColor, fontSize: 16.0),
      ),
    );
  }
}
