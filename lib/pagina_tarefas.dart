import 'package:flutter/material.dart';
import 'tarefa.dart';
import 'tarefa_widget.dart';

class PaginaTarefas extends StatefulWidget {
  const PaginaTarefas({super.key});

  @override
  State<PaginaTarefas> createState() => _PaginaTarefasState();
}

class _PaginaTarefasState extends State<PaginaTarefas> {
  List<Tarefa> tarefas = [];

  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  void _adicionarTarefa() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 20,
              right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: "Título da Tarefa"),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: "Descrição"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_tituloController.text.isNotEmpty) {
                    setState(() {
                      tarefas.add(Tarefa(
                        titulo: _tituloController.text,
                        descricao: _descricaoController.text,
                      ));
                    });
                    _tituloController.clear();
                    _descricaoController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text("Adicionar"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.deepPurple,
      ),
      body: tarefas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/4076/4076505.png",
                    height: 120,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text("Nenhuma tarefa adicionada.",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (ctx, i) {
                return TarefaWidget(
                  titulo: tarefas[i].titulo,
                  descricao: tarefas[i].descricao,
                  onDelete: () => _removerTarefa(i),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarTarefa,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
