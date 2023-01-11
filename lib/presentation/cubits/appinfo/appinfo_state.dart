part of 'appinfo_cubit.dart';

@immutable
abstract class AppinfoState {}

class AppinfoInitial extends AppinfoState {}

class AppinfoLoading extends AppinfoState {}

class Appinfofailure extends AppinfoState {}

class AppinfoLoaded extends AppinfoState {
  final AppInfoModel appInfoModel;

  AppinfoLoaded({required this.appInfoModel});
}
