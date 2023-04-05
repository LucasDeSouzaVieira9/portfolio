import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/feature/projects/firebase/model/image_model.dart';

class StorageRepository {
  final storage = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;

  Future<ImageModel> uploadImage(String userId, XFile image) async {
    final ref = storage.ref().child('images/$userId/${image.name}');
    await ref.putData(await image.readAsBytes());

    var url = await ref.getDownloadURL();

    await firestore.collection('storage').doc(userId).update({
      "images": FieldValue.arrayUnion([
        {'url': url, 'path': 'images/$userId/${image.name}'}
      ])
    });
    return ImageModel(path: 'images/$userId/${image.name}', url: url);
  }

  Future<void> deleteImage(String userId, ImageModel image) async {
    final ref = storage.ref().child(image.path);

    await ref.delete();
    await firestore.collection('storage').doc(userId).update({
      "images": FieldValue.arrayRemove([image.toJson()])
    });
  }

  Future<List<ImageModel>> getImages(String userId) async {
    final response = await firestore.collection('storage').doc(userId).get();
    if (response.data()?['images'] != null) {
      List<ImageModel> images = (response.data()?['images'] as List<dynamic>).map((json) => ImageModel.fromJson(json)).toList();
      return images;
    }
    return [];
  }
}
