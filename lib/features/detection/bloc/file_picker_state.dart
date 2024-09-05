part of 'file_picker_bloc.dart';

class FilePickerState extends Equatable {
  final XFile? pickedImage;
  const FilePickerState({this.pickedImage});

  copyWith({
    XFile? Function()? pickedImage,
  }) {
    return FilePickerState(
      pickedImage: pickedImage != null ? pickedImage() : this.pickedImage,
    );
  }

  @override
  List<Object?> get props => [pickedImage];
}
