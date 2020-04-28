import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class EditFeild extends StatefulWidget {
  final hint;
  final max;
  final controller;
  EditFeild({Key key, this.hint, this.max,@required this.controller}) : super(key: key);

  @override
  _EditFeildState createState() => _EditFeildState(controller);
}

class _EditFeildState extends State<EditFeild> {
  _EditFeildState(this.controller);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [shadow],
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextFormField(
        validator: (value) => value.isEmpty ? 'Enter Somthing' : null,
        controller: widget.controller,
        maxLines: widget.max,
        decoration: inputDecoration.copyWith(
          hintText: widget.hint,
        ),
      ),
    );
  }
}
