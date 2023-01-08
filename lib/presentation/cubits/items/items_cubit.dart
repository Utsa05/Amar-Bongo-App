// ignore_for_file: depend_on_referenced_packages

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

    final stramResponse = getItemsUsecase.call();
    stramResponse.listen((itemList) {
      print(itemList[1].category);
      emit(ItemsLoaded(itemList: itemList));
    });

    try {} on SocketException {
      emit(ItemsFailuare());
    } catch (e) {
      emit(ItemsFailuare());
    }
  }
}
