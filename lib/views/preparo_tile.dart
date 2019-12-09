import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/model/etapa_preparacao.dart';

class PreparoTile extends StatefulWidget {
  final EtapaPreparacao preparo;
  final Function onChanged;
  final Function onRemove;

  PreparoTile({
    Key key,
    this.preparo,
    this.onChanged,
    this.onRemove,
  }) : super(key: key);

  @override
  _PreparoTileState createState() => _PreparoTileState();
}

class _PreparoTileState extends State<PreparoTile> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.preparo.descricao,
    );

    _focusNode = FocusNode();

    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "",
              contentPadding: EdgeInsets.all(12),
              filled: true,
            ),
            onChanged: widget.onChanged,
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red[800],
          ),
          onPressed: () {
            widget.onRemove(widget.preparo.id);
          },
        ),
      ],
    );
  }
}
