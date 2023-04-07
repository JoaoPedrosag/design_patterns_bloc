import 'package:bloc_test/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll(
      [
        TarefaModel(name: 'Tarefa 1'),
        TarefaModel(name: 'Tarefa 2'),
      ],
    );
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _tarefas,
    );
  }

  Future postTarefa({required TarefaModel tarefa}) async {
    _tarefas.add(tarefa);
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _tarefas,
    );
  }

  Future removeTarefa({required TarefaModel tarefa}) async {
    _tarefas.remove(tarefa);
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => _tarefas,
    );
  }
}
