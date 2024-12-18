import 'package:PP_787/storages/models/trigger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriggerBloc extends Cubit<Trigger> {
  TriggerBloc({this.trigger})
      : super(
          trigger ?? Trigger(name: '', emotions: []),
        );
  final Trigger? trigger;

  void updateName(String text) {
    emit(state.copyWith(name: text));
  }
  void updateEmotion(int index) {
    print('TEEEEEEE---------------------- ${state.emotions.length}');
    final copy = state.emotions.toList();
    final isExist = copy.any((elem) => elem.type.index == index);
    if(isExist) {
      final elem = copy.firstWhere((elem) => elem.type.index == index);
      elem.count++;
    } else {
      final elem = Emotion(type: Emotions.values[index], count: 1);
      copy.add(elem);
    }
    emit(state.copyWith(emotions: copy));
    for(int i = 0; i < state.emotions.length; i++) {

    print('TEST -----------  ${state.emotions[i].type.name}');
    print('TEST -----------  ${state.emotions[i].count}');
    }

  }
  bool canSave() {
    return state.name != '' && state.name.isNotEmpty;
  }
}
