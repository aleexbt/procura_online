import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AppPath extends GetxController {
  Rx<Directory> _directory = Directory('').obs;
  Directory get directory => _directory.value;

  Future<void> getPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    _directory.value = dir;
  }
}
