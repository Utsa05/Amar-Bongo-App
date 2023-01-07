// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/domain/entities/user.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:amar_bongo_app/presentation/cubits/credential/credential_cubit.dart';
import 'package:amar_bongo_app/presentation/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          children: const [
            ProfileTileView(),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: ItemWIdget(
                title: "Something",
                icon: Icons.downhill_skiing,
              ),
            ),
            ItemWIdget(
              title: "Contact Us",
              icon: Icons.email_outlined,
            ),
            ItemWIdget(
              title: "Policy & Privacy",
              icon: Icons.privacy_tip_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTileView extends StatelessWidget {
  const ProfileTileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Authenticated) {
          BlocProvider.of<UserCubit>(context).getCurrentUser(state.uid);
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserIsLoaded) {
                return Stack(
                  children: [
                    ProfileTile(
                      user: state.user,
                    ),
                    Positioned(
                      right: 1.0,
                      bottom: 1.0,
                      child: IconButton(
                          highlightColor: AppColor.primaryColor,
                          color: AppColor.goldenColor,
                          splashRadius: 20.0,
                          onPressed: () {
                            Alert(
                              style: AlertStyle(
                                  titleStyle:
                                      Theme.of(context).textTheme.headline6!,
                                  descStyle:
                                      Theme.of(context).textTheme.bodyText2!),
                              context: context,
                              type: AlertType.warning,
                              title: "ALERT",
                              desc: "Do you want to logout your account?",
                              buttons: [
                                DialogButton(
                                  onPressed: () => Navigator.pop(context),
                                  color: AppColor.redColor,
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                DialogButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .loggedOut()
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                  gradient: const LinearGradient(colors: [
                                    AppColor.primaryColor,
                                    AppColor.goldenColor
                                  ]),
                                  child: const Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ).show();
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: AppColor.redColor,
                          )),
                    )
                  ],
                );
              }

              return const Center(
                child: Text("User Loaded Failure"),
              );
            },
          );
        }
        return const ProfileTile(
          user: UserEntity(),
        );
      },
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      contentPadding: const EdgeInsets.only(right: 14.0, top: 5.0, bottom: 5.0),
      tileColor: AppColor.whiteColor,
      title: Text(
        user.name ?? "Username",
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: AppColor.blackColor, fontSize: 15.0),
      ),
      subtitle: Text(
        user.email ?? "Useremail",
        style: Theme.of(context).textTheme.headline6!.copyWith(
            color: AppColor.blackColor,
            fontWeight: FontWeight.normal,
            fontSize: 13.0),
      ),
      trailing: user.name == null
          ? MaterialButton(
              color: AppColor.goldenColor,
              elevation: 0.0,
              minWidth: 60.0,
              height: 33.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              onPressed: () {
                BlocProvider.of<CredentialCubit>(context)
                    .googleAuthentication()
                    .whenComplete(() {
                  BlocProvider.of<AuthCubit>(context).appStarted();
                });
              },
              child: Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColor.whiteColor, fontSize: 14.0),
              ),
            )
          : null,
      leading: user.profileImage != null
          ? CachedNetworkImage(
              imageUrl: user.profileImage!,
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : const CircleAvatar(
              radius: 35.0,
              backgroundColor: AppColor.bgColor,
              child: Icon(
                Icons.account_box_outlined,
                color: AppColor.goldenColor,
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
