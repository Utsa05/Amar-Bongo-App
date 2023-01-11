// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:amar_bongo_app/domain/entities/notification.dart';
import 'package:amar_bongo_app/domain/usecases/get_notification_usecase.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationUsecase getNotificationUsecase;
  NotificationCubit({required this.getNotificationUsecase})
      : super(NotificationInitial());

  Future<void> getNotification() async {
    print('call notification');
    emit(NotificationLoading());
    try {
      final notificationResponse = getNotificationUsecase.call();

      notificationResponse.listen((notificationList) {
        print(notificationList[0].title);
        emit(NotificationLoaded(notificationList: notificationList));
      });
    } on SocketException {
      emit(NotificationFailure());
    } catch (e) {
      emit(NotificationFailure());
      print(e);
    }
  }
}
