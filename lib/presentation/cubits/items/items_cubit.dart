// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';

import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:amar_bongo_app/domain/usecases/get_items_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final GetItemsUsecase getItemsUsecase;
  ItemsCubit({required this.getItemsUsecase}) : super(ItemsInitial());

  Future<void> getItems() async {
    print("call items");
    emit(ItemsLoading());

    try {
      final stramResponse = getItemsUsecase.call();
      stramResponse.listen((itemList) {
        emit(ItemsLoaded(itemList: itemList));
      });
    } on SocketException {
      emit(ItemsNoInternet());
    } catch (e) {
      emit(ItemsFailuare());
    }
  }
}
