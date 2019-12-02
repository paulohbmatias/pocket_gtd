import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends BlocBase {
  BehaviorSubject<int> _page = BehaviorSubject();

  Observable<int> get page => _page.stream;

  Function(int) get changePage => _page.sink.add;

  @override
  void dispose() {
    _page.close();
    super.dispose();
  }
}
