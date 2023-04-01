import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

class ImageProvider extends StateNotifier<File?> {

  ImageProvider() : super(null);

  Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if(pickedFile == null) {
      state = null;
    }
    else {
      state = File(pickedFile.path);
    }
  }

  File? get value => state;
}

final imageProvider = StateNotifierProvider<ImageProvider, File?>(
      (ref) => ImageProvider(),
);