import 'package:bloc/Bloc.dart';
import 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 1;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        if (currentState > 1) {
          yield currentState - 1;
        }
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}
