import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DashboardBloc{

  BehaviorSubject<int> _page = BehaviorSubject.seeded(0);

  Observable<int> get page => _page.stream;

  Function(int) get changePage => _page.sink.add;
  void dispose(){
    _page.close();
  }
}