// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/bongo_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const BongoApp());
}
