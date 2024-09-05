import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detection_event.dart';
part 'detection_state.dart';

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  DetectionBloc() : super(DetectionState()) {
    on<DetectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
