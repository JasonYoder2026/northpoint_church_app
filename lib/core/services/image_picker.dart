import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ImagePicker _picker = ImagePicker();

Future<File?> pickAvatarImage() async {
  final picked = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 85,
  );

  if (picked == null) return null;

  return File(picked.path);
}
