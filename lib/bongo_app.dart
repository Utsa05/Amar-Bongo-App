// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/on_generate_route.dart';
import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/routes.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/cubits/user/user_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'di/di.dart' as di;
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/credential/credential_cubit.dart';

class BongoApp extends StatefulWidget {
  const BongoApp({super.key});

  @override
  State<BongoApp> createState() => _BongoAppState();
}

class _BongoAppState extends State<BongoApp> {
  @override
  void initState() {
    intitdi();
    super.initState();
  }

  intitdi() async {
    await di.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        )
      ],
      child: MaterialApp(
        onGenerateRoute: AppRoute.onGeneralRoute,
        initialRoute: RouteString.initial,
        theme: ThemeData(
            textTheme: TextTheme(
                headline1: GoogleFonts.openSans(
                    fontSize: 72.0,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
                headline6: GoogleFonts.openSans(
                    fontSize: 32.0,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w600),
                bodyText2: GoogleFonts.openSans(
                  fontSize: 14.0,
                  color: AppColor.goldenColor,
                )),
            primaryColor: AppColor.primaryColor,
            scaffoldBackgroundColor: AppColor.bgColor),
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
      ),
    );
  }
}
