import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/feature/projects/firebase/model/image_model.dart';

part 'storage_screen_state.freezed.dart';

@freezed
class StorageScreenState with _$StorageScreenState {
  const factory StorageScreenState.initial() = StorageScreenInitialState;
  const factory StorageScreenState.loading() = StorageScreenLoadingState;
  const factory StorageScreenState.loadingUpload() = StorageScreenUploadLoadingState;
  const factory StorageScreenState.success({required List<ImageModel> urlImages}) = StorageScreenSuccessState;
  const factory StorageScreenState.uploadSuccess({required ImageModel image}) = StorageScreenUploadSuccessState;
  const factory StorageScreenState.deleteSuccess({required ImageModel image}) = StorageScreenDeleteSuccessState;
  const factory StorageScreenState.error() = StorageScreenErrorState;
}
