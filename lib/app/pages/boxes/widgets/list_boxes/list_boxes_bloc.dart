import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:pocket_gtd/app/app_module.dart';
import 'package:pocket_gtd/app/shared/models/box_model.dart';
import 'package:pocket_gtd/app/shared/repositories/box_repository.dart';
import 'package:rxdart/rxdart.dart';

class ListBoxesBloc extends BlocBase {

  final BoxRepository boxRepository = AppModule.to.getDependency<BoxRepository>();

  ListBoxesBloc(){
    listenBoxes();
  }

  List<BoxModel> listBoxes = List();

  BehaviorSubject<List<BoxModel>> _boxes = BehaviorSubject();

  Observable<List<BoxModel>> get boxes => _boxes.stream;

  Function(List<BoxModel>) get changeBoxList => _boxes.sink.add;

  void listenBoxes() async{
    listBoxes = await boxRepository.getAll();
    changeBoxList(listBoxes);
    (await boxRepository.listenBoxes()).listen((list){
      changeBoxList(list);
    });
  }

  @override
  void dispose() {
    _boxes.close();
    super.dispose();
  }
}
