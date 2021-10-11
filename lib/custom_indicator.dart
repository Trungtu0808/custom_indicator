library custom_indicator;

import 'package:flutter/material.dart';

class CustomIndicator extends StatefulWidget {
  final List<Widget> listPage;
  final Color? dotFillColor;
  final Color? dotOutlineColor;
  final double? dotFillHeight;
  final double? dotFillWidth;
  final double? dotOutlineHeight;
  final double? dotOutlineWidth;
  CustomIndicator(
      {required this.listPage,
        this.dotOutlineColor,
        this.dotFillColor,
        this.dotFillHeight,
        this.dotFillWidth,
        this.dotOutlineHeight, this.dotOutlineWidth});
  @override
  _CustomIndicatorState createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  late PageController pageController;
  int currentPageValue = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: currentPageValue, keepPage: true);
    super.initState();
  }

  getChangePageView(int index) {
    currentPageValue = index;
    setState(() {});
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? widget.dotFillHeight?? 12 : widget.dotFillHeight?? 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive
              ? widget.dotFillColor ?? Colors.green
              : widget.dotOutlineColor ?? Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView.builder(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.listPage.length,
            controller: pageController,
            onPageChanged: (index) {
              getChangePageView(index);
            },
            itemBuilder: (context, index) => widget.listPage[index]),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < widget.listPage.length; i++)
                    if (i == currentPageValue) ...[circleBar(true)] else
                      circleBar(false),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
