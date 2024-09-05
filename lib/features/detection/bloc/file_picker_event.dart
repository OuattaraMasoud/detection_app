part of 'file_picker_bloc.dart';

abstract class FilePickerEvent extends Equatable {
  const FilePickerEvent();

  @override
  List<Object> get props => [];
}

class AddPictureEvent extends FilePickerEvent {
  final XFile pickedImage;

  const AddPictureEvent({required this.pickedImage});
  @override
  List<Object> get props => [pickedImage];
}
