import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oifyoo_mksr/ui/resources/resources.dart';
import 'package:oifyoo_mksr/core/core.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  final String? hint;
  final Function(String)? onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();
  var _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged!(_controller.text);
      setState(() {
        _isEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: _controller,
      textInputAction: TextInputAction.done,
      style: TextStyles.text,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      cursorColor: Palette.colorText,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: EdgeInsets.symmetric(horizontal: context.dp16()),
        suffixIcon: _isEmpty
            ? Icon(Icons.search, color: Palette.colorPrimary)
            : IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Palette.red,
                ),
                onPressed: () {
                  _controller.clear();
                },
              ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.colorHint),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.colorHint),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
