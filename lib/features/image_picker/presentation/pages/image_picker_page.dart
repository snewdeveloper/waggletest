import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waggltest/core/utils/utilities.dart';

import '../bloc/image_picker_bloc.dart';
import '../bloc/image_picker_event.dart';
import '../bloc/image_picker_state.dart';
import 'image_preview_page.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text('Attach Images')),
        body:
        // BlocBuilder<ImagePickerBloc, ImagePickerState>(
        //   builder: (context, state) {
        //     final images = state is ImagePickerLoaded
        //         ? state.images
        //         : state is ImagePickerInitial
        //         ? state.images
        //         : [];

        BlocConsumer<ImagePickerBloc, ImagePickerState>(
            listener: (context, state) {
              if (state is ImagePickerUploadSuccess) {
              Utils.showToast('Images uploaded successfully');
                Navigator.pop(context);
              }

            },
            builder: (context, state) {
                  final images = state is ImagePickerLoaded
                      ? state.images
                       : state is ImagePickerInitial
                      ? state.images
                      : (state is ImagePickerUploading)
                      ? state.images
                      : [];
              if(state is ImagePickerUploading){
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                          onPressed: () => context
                              .read<ImagePickerBloc>()
                              .add(PickImageFromCamera()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.photo),
                          label: const Text('Gallery'),
                          onPressed: () => context
                              .read<ImagePickerBloc>()
                              .add(PickImageFromGallery()),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImagePreviewPage(
                                image: images[index],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.file(
                                File(images[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: InkWell(
                                onTap: () => context
                                    .read<ImagePickerBloc>()
                                    .add(RemovePickedImage(index)),
                                child: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.close,
                                      size: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),


                ),

                /// Attach Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:(){
                        context.read<ImagePickerBloc>().add(UploadImages());
                      },
                          child:const Text('Attach'),
                    ),
                  ),
                ),
              ],
            );
          }

      ),
    );
  }
}