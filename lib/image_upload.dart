import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload {
  pickFile(String filetype) async {
    final _imagePicker = ImagePicker();
    final XFile? image;

    //verifico i permessi per accedere alla galleria
    await Permission.photos.request();
    var premissionStatus = await Permission.photos.status;
    if (premissionStatus.isGranted || premissionStatus.isLimited) {
      if (filetype.toLowerCase() == 'image') {
        image = await _imagePicker.pickImage(
            source: ImageSource.gallery,
            requestFullMetadata: false,
            maxHeight: 150,
            maxWidth: 150);
      } else if (filetype.toLowerCase() == 'video') {
        image = await _imagePicker.pickVideo(source: ImageSource.gallery);
      } else {
        image = null;
      }

      if (image == null) {
        return null;
      }
      return image.path;
    } else {
      Fluttertoast.showToast(msg: "Permessi non ottenuti. Riprova!");
    }
    return null;
  }

  uploadImage(String image) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String? imageUrl;

    var file = File(image);
    //caricamento in Firebase
    final imageName = image.split('/').last;
    final type = imageName.split('.').last;
    final metadata = SettableMetadata(
      contentType: 'image/$type',
      customMetadata: {'picked-file-path': file.path},
    );
    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance.ref().child('images/$imageName');

    try {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
      imageUrl = await (await uploadTask).ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  uploadVideo(String video) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String? videoUrl;

    var file = File(video);
    //caricamento in Firebase
    final videoName = video.split('/').last;
    final type = videoName.split('.').last;
    final metadata = SettableMetadata(
      contentType: 'video/$type',
      customMetadata: {'picked-file-path': file.path},
    );
    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance.ref().child('videos/$videoName');

    try {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
      videoUrl = await (await uploadTask).ref.getDownloadURL();
      return videoUrl;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
