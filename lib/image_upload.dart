import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload {
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    final XFile? image;
    String? imageUrl;
    //verifico i permessi per accedere alla galleria
    await Permission.photos.request();

    var premissionStatus = await Permission.photos.status;

    if (premissionStatus.isGranted || premissionStatus.isLimited) {
      image = await _imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        //caricamento in Firebase
        final imageName = image.path.split('/').last;
        final type = imageName.split('.').last;
        final metadata = SettableMetadata(
          contentType: 'image/$type',
          customMetadata: {'picked-file-path': file.path},
        );
        UploadTask uploadTask;
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$imageName');

        try {
          uploadTask = ref.putData(await file.readAsBytes(), metadata);
          imageUrl = await (await uploadTask).ref.getDownloadURL();
          return imageUrl;
        } catch (e) {
          print(e.toString());
        }
      } else {
        Fluttertoast.showToast(msg: "Permessi non ottenuti. Riprova!");
      }
    } else {
      Fluttertoast.showToast(msg: "Permessi non ottenuti. Riprova!");
    }
  }
}
