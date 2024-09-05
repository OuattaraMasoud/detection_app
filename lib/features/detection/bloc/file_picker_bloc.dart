import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  FilePickerBloc(FilePickerState filePickerState)
      : super(const FilePickerState()) {
    on<AddPictureEvent>(_onTakePicture);
  }
  Future<void> _onTakePicture(
      AddPictureEvent event, Emitter<FilePickerState> emit) async {
    emit(state.copyWith(pickedImage: () => event.pickedImage));
  }
}
