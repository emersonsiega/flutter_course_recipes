import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/model/ingrediente.dart';

class IngredienteTile extends StatefulWidget {
  final Ingrediente ingrediente;
  final Function onChanged;
  final Function onRemove;

  IngredienteTile({
    Key key,
    this.ingrediente,
    this.onChanged,
    this.onRemove,
  }) : super(key: key);

  @override
  _IngredienteTileState createState() => _IngredienteTileState();
}

class _IngredienteTileState extends State<IngredienteTile> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.ingrediente.nome,
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
            widget.onRemove(widget.ingrediente.id);
          },
        ),
      ],
    );
  }
}
