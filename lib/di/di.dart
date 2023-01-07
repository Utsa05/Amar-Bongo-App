// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:amar_bongo_app/data/data_sources/remote_data_source.dart';
import 'package:amar_bongo_app/data/repositories/firebase_repositories_impl.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';
import 'package:amar_bongo_app/domain/usecases/create_user_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/get_current_user_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/getcurrent_user_id_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/google_authentication.dart';
import 'package:amar_bongo_app/domain/usecases/issignin_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/signout_usecase.dart';
import 'package:amar_bongo_app/domain/usecases/updateuser_usecase.dart';
import 'package:amar_bongo_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:amar_bongo_app/presentation/cubits/credential/credential_cubit.dart';
import 'package:amar_bongo_app/presentation/cubits/user/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print("di");
  //bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSigninUsecase: sl.call(),
        getCurrentUserIDUsecase: sl.call(),
        signoutUsecase: sl.call(),
      ));
  sl.registerFactory<CredentialCubit>(
      () => CredentialCubit(googleAuthenticationUsecase: sl.call()));
  sl.registerFactory<UserCubit>(
      () => UserCubit(getCurrentUserUsecase: sl.call()));

  //usecase
  sl.registerLazySingleton<IsSigninUsecase>(
      () => IsSigninUsecase(firebaseRepositories: sl.call()));
  sl.registerLazySingleton<GoogleAuthenticationUsecase>(
      () => GoogleAuthenticationUsecase(firebaseRepositories: sl.call()));
  sl.registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(firebaseRepositories: sl.call()));
  sl.registerLazySingleton<GetCurrentUserIDUsecase>(
      () => GetCurrentUserIDUsecase(firebaseRepositories: sl.call()));
  sl.registerFactory<UpdateUsecase>(
      () => UpdateUsecase(firebaseRepositories: sl.call()));
  sl.registerLazySingleton<CreateUserUsecase>(
      () => CreateUserUsecase(firebaseRepositories: sl.call()));
  sl.registerLazySingleton<SignoutUsecase>(
      () => SignoutUsecase(firebaseRepositories: sl.call()));

  //repositories
  sl.registerLazySingleton<FirebaseRemoteDatasource>(() =>
      FirebaseRemoteDatasourceImpl(
          firebaseAuth: sl.call(),
          firebaseFiresore: sl.call(),
          googleSignin: sl.call()));
  sl.registerLazySingleton<FirebaseRepositories>(
      () => FirebaseRepositoryImpl(remoteDatasource: sl.call()));
  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignIn);
}
