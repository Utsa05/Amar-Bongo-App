part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<ItemEntity> itemList;

  ItemsLoaded({required this.itemList});
}

class ItemsFailuare extends ItemsState {}

class ItemsNoInternet extends ItemsState {}
