import 'package:image_picker/image_picker.dart';

import '../../domain/entities/picked_image.dart';

abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {
  final List<PickedImage> images;
  ImagePickerInitial(this.images);
}

class ImagePickerLoaded extends ImagePickerState {
  final List<PickedImage> images;
  ImagePickerLoaded(this.images);
}

class ImagePickerUploading extends ImagePickerState {
  final List<PickedImage> images;
  ImagePickerUploading(this.images);
}

class ImagePickerUploadSuccess extends ImagePickerState {
  ImagePickerUploadSuccess();
}

class ImagePickerUploadFailed extends ImagePickerState {
  final String error;
  ImagePickerUploadFailed(this.error);
}
