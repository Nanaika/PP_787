import 'package:PP_787/storages/models/check_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInBloc extends Cubit<CheckIn> {
  CheckInBloc()
      : super(
          CheckIn(
              date: DateUtils.dateOnly(DateTime.now()),
              isCustom: false,
              index: -1,
              name: '',
              feeling: FeelingType.NotSelected,
              feelingPower: 0,
              triggerBy: ''),
        );

  void updateIsCustom(bool newValue) {
    emit(state.copyWith(isCustom: newValue));
  }

  void updateIndex(int newIndex) {
    emit(state.copyWith(index: newIndex));
  }

  void updateName(String newText) {
    emit(state.copyWith(name: newText));
  }
  void updateFeelingType(FeelingType type) {
    emit(state.copyWith(feeling: type));
  }

  void updateFeelingPower(double value) {
    print('qqqq----------- ${value}');
    final newValue = (value * 4) + 1;
    emit(state.copyWith(feelingPower: newValue.toInt()));
  }

  void updateTriggerBy(String text) {
    emit(state.copyWith(triggerBy: text));
  }



  bool canSave() {
    if(state.isCustom) {
      return state.name != '' && state.index != -1  && state.feeling != FeelingType.NotSelected && state.triggerBy != '';
    } else {
      return  state.index != -1  && state.feeling != FeelingType.NotSelected && state.triggerBy != '';
    }

  }
}
