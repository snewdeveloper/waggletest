abstract class ImagePickerEvent {}

class PickImageFromCamera extends ImagePickerEvent {}
class PickImageFromGallery extends ImagePickerEvent {}
class RemovePickedImage extends ImagePickerEvent {
  final int index;
  RemovePickedImage(this.index);
}
class UploadImages extends ImagePickerEvent {}