class PickedImage {
  final String path;
  final int? sizeInBytes;
  final String? mimeType;
  final DateTime pickedAt;

  const PickedImage({
    required this.path,
    this.sizeInBytes,
    this.mimeType,
    required this.pickedAt,
  });
}