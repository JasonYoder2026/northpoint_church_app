import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

Future<XFile?> pickAvatarImage() async {
  return await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
}
