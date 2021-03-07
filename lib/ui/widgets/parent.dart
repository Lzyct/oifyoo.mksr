import 'package:flutter/material.dart';
import 'package:oifyoo_mksr/core/core.dart';

///*********************************************
/// Created by ukietux on 24/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Parent extends StatefulWidget {
  final Widget? child;
  final bool isPadding;
  final bool isScroll;
  final AppBar? appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;

  const Parent({
    Key? key,
    this.child,
    this.isPadding = true,
    this.isScroll = true,
    required this.appBar,
    this.avoidBottomInset = false,
    this.floatingButton,
  }) : super(key: key);

  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.avoidBottomInset,
      appBar: widget.appBar ??
          PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: Stack(
            children: [
              widget.isScroll
                  ? Container()
                  : widget.child.padding(
                      edgeInsets: EdgeInsets.all(
                        widget.isPadding ? context.dp16() : 0,
                      ),
                    ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: widget.isScroll
                    ? widget.child.padding(
                        edgeInsets: EdgeInsets.all(
                          widget.isPadding ? context.dp16() : 0,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.floatingButton,
    );
  }
}
