import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waggltest/features/image_picker/presentation/bloc/image_picker_bloc.dart';
import 'package:waggltest/features/image_picker/presentation/bloc/image_picker_event.dart';
import 'package:waggltest/features/image_picker/presentation/bloc/image_picker_state.dart';
import 'package:waggltest/features/image_picker/domain/entities/picked_image.dart';

// ----- MOCK CLASSES -----
class MockImagePicker extends Mock implements ImagePicker {}
class MockXFile extends Mock implements XFile {}

void main() {
  late ImagePickerBloc bloc;
  late MockImagePicker mockPicker;

  setUp(() {
    mockPicker = MockImagePicker();

    // override the bloc _picker with mock
    bloc = ImagePickerBloc();
    bloc.setMockPicker(mockPicker);
  });

  group('ImagePickerBloc Unit Tests', () {
    final tFile = MockXFile();
    final tPickedImage = PickedImage(path: '/path/image1.jpg', pickedAt: DateTime.now());

    setUp(() {
      when(() => tFile.path).thenReturn('/path/image1.jpg');
    });

    test('initial state is ImagePickerInitial with empty list', () {
      expect(bloc.state, isA<ImagePickerInitial>());
      expect((bloc.state as ImagePickerInitial).images, []);
    });

    test('picking image from camera emits ImagePickerLoaded', () async {
      when(() => mockPicker.pickImage(source: ImageSource.camera))
          .thenAnswer((_) async => tFile);

      bloc.add(PickImageFromCamera());

      await expectLater(
        bloc.stream,
        emits(predicate<ImagePickerState>((state) {
          return state is ImagePickerLoaded && state.images.length == 1;
        })),
      );
    });

    test('picking multiple images from gallery emits ImagePickerLoaded', () async {
      when(() => mockPicker.pickMultiImage())
          .thenAnswer((_) async => [tFile, tFile]);

      bloc.add(PickImageFromGallery());

      await expectLater(
        bloc.stream,
        emits(predicate<ImagePickerState>((state) {
          return state is ImagePickerLoaded && state.images.length == 2;
        })),
      );
    });



    test('removing image at invalid index emits ImagePickerError', () async {
      bloc.emit(ImagePickerLoaded([]));

      bloc.add(RemovePickedImage(0));

      await expectLater(
        bloc.stream,
        emits(predicate<ImagePickerState>((state) => state is ImagePickerUploadFailed)),
      );
    });

    test('uploading images emits Uploading -> Success -> Initial', () async {
      bloc.emit(ImagePickerLoaded([tPickedImage]));

      bloc.add(UploadImages());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ImagePickerUploading>(),
          isA<ImagePickerUploadSuccess>(),
          isA<ImagePickerInitial>(),
        ]),
      );
    });
  });
}