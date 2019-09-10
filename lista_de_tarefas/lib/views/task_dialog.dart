import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  int _priority = null;
  var _keyForm = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Task _currentTask = Task();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _currentTask = Task.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
    _priority = _currentTask.priority;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: AlertDialog(
        title: Text(widget.task == null ? 'Nova tarefa' : 'Editar tarefas'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
                validator: (text) {
                  return text.isEmpty ? "Favor informar um Titulo" : null;
                },
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                autofocus: true),
            TextFormField(
                validator: (text) {
                  return text.isEmpty ? "Favor informar uma Descrição" : null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição')),
            DropdownButtonFormField<int>(
              hint: Text("Selectione a prioridade"),
              value: _priority,
              onChanged: (int newValue) {
                setState(() {
                  _priority = newValue;
                });
              },
              validator: (int value) {
                if (value == null) {
                  return "Selecione uma prioridade";
                } else if (value < 1 || value > 5) {
                  return "A prioridade deve estar entre 0 e 5";
                } return null;
              },
              items: _currentTask
                  .getPriorities()
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Salvar'),
            onPressed: () {
              if (_keyForm.currentState.validate()) {
                _currentTask.title = _titleController.value.text;
                _currentTask.description = _descriptionController.text;
                _currentTask.priority = _priority;
                Navigator.of(context).pop(_currentTask);
              }
            },
          ),
        ],
      ),
    );
  }
}
