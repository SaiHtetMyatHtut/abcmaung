import 'package:flutter/material.dart';


class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _first = true;
  // late OverlayEntry _overlayEntry;
  // OverlayEntry _overlayEntryBuilder() {
  //   return OverlayEntry(builder: (context) {
  //     return Positioned(
  //       top: 150,
  //       left: 300,
  //       width: 150,
  //       child: Container(
  //         width: 100.0,
  //         height: 150.0,
  //         color: Colors.green,
  //       ),
  //     );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello!'),),
      body: Column(children: [
        SizedBox(height: 50.0,),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: InkWell(
            onTap: (){
              _first=false;
              // _overlayEntry.remove();
              // Overlay.of(context).remove();
              setState(() {
                
              });
            },
            child: Container(
              width: 100.0,
              height: 250.0,
              color: Colors.red,
            ),
          ),  // When you don't want to show menu.. 
          secondChild: InkWell(
            onTap: (){
              // _overlayEntryBuilder();
              // _overlayEntry = _overlayEntryBuilder();
              // Overlay.of(context)!.insert(_overlayEntry);
              _first=true;
              setState(() {
                
              });
            },
            child: OverlayContainer(
              show: !_first,
              child: Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.red,
                ),
            )
          ),
          crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        Text('This is testing'),
      ],),
      
    );
  }
}

class OverlayContainer extends StatefulWidget {
  /// The child to render inside the container.
  final Widget child;

  /// By default, the child will be rendered right below (if the parent is `Column`)
  /// the widget which is defined alongside the OverlayContainer.
  /// It would appear as though the Overlay is inside its parent
  /// but in reality it would be outside and above
  /// the original widget hierarchy.
  /// It's position can be altered and the overlay can
  /// be moved to any part of the screen by supplying a `position`
  /// argument.
  final OverlayContainerPosition position;

  /// Controlling whether the overlay is current showing or not.
  final bool show;

  /// Whether the overlay is wide as its enclosing parent.
  final bool asWideAsParent;

  /// `color` attribute for the `Material` component that wraps `child`.
  final Color materialColor;

  OverlayContainer({
    required this.show,
    required this.child,
    this.asWideAsParent = false,
    this.position = const OverlayContainerPosition(0.0, 0.0),
    this.materialColor = Colors.transparent,
  });

  @override
  _OverlayContainerState createState() => _OverlayContainerState();
}

class _OverlayContainerState extends State<OverlayContainer>
    with WidgetsBindingObserver {
  late OverlayEntry _overlayEntry;
  bool _opened = false;

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      _show();
    }
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    // We would want to re render the overlay if any metrics
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // We would want to re render the overlay if any of the dependencies
    // ever change.
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void didUpdateWidget(OverlayContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _show();
    } else {
      _hide();
    }
  }

  @override
  void dispose() {
    if (widget.show) {
      _hide();
    }
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void _show() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 280));
      if (_opened) {
        _overlayEntry.remove();
      }
      _overlayEntry = _buildOverlayEntry(context);
      Overlay.of(context)!.insert(_overlayEntry);
      _opened = true;
    });
  }

  void _hide() {
    if (_opened) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _overlayEntry.remove();
        _opened = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in media query such as when a device orientation changes
    // or when the keyboard is toggled.
    MediaQuery.of(context);
    return Container();
  }

  OverlayEntry _buildOverlayEntry(context) {
    RenderBox renderBox = context.findRenderObject();
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx + widget.position.left,
          top: offset.dy - widget.position.bottom,
          width: widget.asWideAsParent ? size.width : null,
          child: Material(
            child: widget.child,
            color: widget.materialColor,
          ),
        );
      },
    );
  }
}

/// Class to help position the overlay on the screen.
/// By default it will be rendered right below (if the parent is `Column`)
/// the widget which is alongside the OverlayContainer.
/// The Overlay can however be moved around by giving a left value
/// and a bottom value just like in the case of a `Positioned` widget.
/// The default values for `left` and `bottom` are 0 and 0 respectively.
class OverlayContainerPosition {
  final double left;
  final double bottom;

  const OverlayContainerPosition(this.left, this.bottom);
}