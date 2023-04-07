import 'package:bloc_test/blocs/tarefa_bloc.dart';
import 'package:bloc_test/blocs/tarefa_event.dart';
import 'package:bloc_test/blocs/tarefa_state.dart';
import 'package:bloc_test/models/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

late final TarefaBloc _tarefaBloc;

class _TarefasPageState extends State<TarefasPage> {
  @override
  void initState() {
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefas());
    super.initState();
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            _tarefaBloc
                .add(PostTarefas(tarefa: TarefaModel(name: 'Fazer caminhada')));
          }),
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: BlocBuilder<TarefaBloc, TarefaState>(
          bloc: _tarefaBloc,
          builder: (context, state) {
            if (state is TarefaLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TarefaLoadedState) {
              final list = state.tarefas;
              return ListView.separated(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(list[index].name[0].toString()),
                    ),
                    title: Text(list[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _tarefaBloc.add(DeleteTarefa(tarefa: list[index]));
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              );
            } else {
              return const Center(child: Text('Erro ao carregar tarefas'));
            }
          }),
    );
  }
}
