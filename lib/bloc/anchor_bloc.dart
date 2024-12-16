import 'package:flutter_bloc/flutter_bloc.dart';

import '../storages/models/anchor.dart';

class AnchorBloc extends Cubit<Anchor> {
  AnchorBloc()
      : super(
          Anchor(name: ''),
        );

  void updateName(String text) {
    emit(state.copyWith(name: text));
  }
  bool canSave() {
    return state.name != '' && state.name.isNotEmpty;
  }
}
