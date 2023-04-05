import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/feature/projects/firebase/data/storage/storage_repository.dart';
import 'package:portfolio/feature/projects/firebase/feature/storage/storage_screen_state.dart';
import 'package:portfolio/feature/projects/firebase/model/image_model.dart';

class StorageScreenCubit extends Cubit<StorageScreenState> {
  StorageScreenCubit() : super(const StorageScreenInitialState());
  final StorageRepository _repository = StorageRepository();

  Future<void> uploadImage(String userId, XFile image) async {
    try {
      emit(const StorageScreenUploadLoadingState());
      final imageModel = await _repository.uploadImage(userId, image);
      emit(StorageScreenUploadSuccessState(image: imageModel));
      await Future.delayed(const Duration(seconds: 1));
      emit(const StorageScreenSuccessState(urlImages: []));
    } catch (e) {
      emit(const StorageScreenErrorState());
    }
  }

  Future<void> getImages(String userId) async {
    try {
      emit(const StorageScreenLoadingState());
      final urlImages = await _repository.getImages(userId);
      emit(StorageScreenSuccessState(urlImages: urlImages));
    } catch (e) {
      emit(const StorageScreenErrorState());
    }
  }

  Future<void> deleteImage(ImageModel image, String userId) async {
    try {
      emit(const StorageScreenLoadingState());
      await _repository.deleteImage(userId, image);
      emit(StorageScreenDeleteSuccessState(image: image));
    } catch (e) {
      emit(const StorageScreenErrorState());
    }
  }
}
