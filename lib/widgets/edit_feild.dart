import 'package:flutter/material.dart';
import 'package:market_place/constant/decoration.dart';

class EditFeild extends StatefulWidget {
  final String hint;
  final int max;
  final String currentValue;
  final bool enable;
  EditFeild({
    Key key,
    this.hint,
    this.max,
    this.currentValue,
    @required this.enable,
  }) : super(key: key);

  @override
  _EditFeildState createState() => _EditFeildState(currentValue: currentValue);
}

class _EditFeildState extends State<EditFeild> {
  _EditFeildState({@required this.currentValue});
  String currentValue;
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
        onChanged: (value) => setState(() => currentValue = value),
        enabled: widget.enable,
        maxLines: widget.max,
        initialValue: currentValue,
        decoration: inputDecoration.copyWith(hintText: widget.hint),
      ),
    );
  }
}
