// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amar_bongo_app/domain/entities/notification.dart';
import 'package:amar_bongo_app/domain/repositories/firebase_repositories.dart';

class GetNotificationUsecase {
  final FirebaseRepositories firebaseRepositories;
  GetNotificationUsecase({
    required this.firebaseRepositories,
  });

  Stream<List<NotificationEntity>> call() {
    return firebaseRepositories.getNotifications();
  }
}
