import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/picked_image.dart';
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc
    extends Bloc<ImagePickerEvent, ImagePickerState> {
   ImagePicker _picker = ImagePicker();
  final List<PickedImage> _images = [];

  setMockPicker(value){
    _picker = value;
  }

  ImagePickerBloc() : super(ImagePickerInitial([])) {
    on<PickImageFromCamera>(_pickFromCamera);
    on<PickImageFromGallery>(_pickFromGallery);
    on<RemovePickedImage>(_removeImage);
    on<UploadImages>(_onUploadImages);
  }

  Future<void> _pickFromCamera(
      PickImageFromCamera event, Emitter emit) async {
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      _images.add(
        PickedImage(path: file.path, pickedAt: DateTime.now()),
      );
      emit(ImagePickerLoaded(List.from(_images)));
    }
  }

  Future<void> _pickFromGallery(
      PickImageFromGallery event, Emitter emit) async {
    final files = await _picker.pickMultiImage();
    for (final file in files) {
      _images.add(
        PickedImage(path: file.path, pickedAt: DateTime.now()),
      );
    }
    emit(ImagePickerLoaded(List.from(_images)));
  }
  //
  // void _removeImage(RemovePickedImage event, Emitter emit) {
  //   _images.removeAt(event.index);
  //   emit(ImagePickerLoaded(List.from(_images)));
  // }

  void _removeImage(RemovePickedImage event, Emitter emit) {
    if (event.index >= 0 && event.index < _images.length) {
      _images.removeAt(event.index);
      emit(ImagePickerLoaded(List.from(_images)));
    } else {
      // Optionally emit error state or ignore
      emit(ImagePickerUploadFailed('Invalid index: ${event.index}'));
    }
  }
  Future<void> _onUploadImages(
      UploadImages event,
      Emitter<ImagePickerState> emit,
      ) async {
    emit(ImagePickerUploading(_images));

    await Future.delayed(const Duration(seconds: 3)); // simulate API
    emit(ImagePickerUploadSuccess());
    _images.clear();
    emit(ImagePickerInitial([]));
  }
}