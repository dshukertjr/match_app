import 'package:app/models/user_public.dart';
import 'package:app/widgets/prospect_card.dart';
import 'package:flutter/material.dart';

/// Card widget that the user can drag and swipe left or right
class SwipableCard extends StatefulWidget {
  const SwipableCard({
    Key key,
    @required void Function() onSwipeRight,
    @required void Function() onSwipeLeft,
    @required List<UserPublic> prospects,
  })  : _onSwipeRight = onSwipeRight,
        _onSwipeLeft = onSwipeLeft,
        _prospects = prospects,
        super(key: key);

  static double _initialBehindCardScale = 0.95;

  final void Function() _onSwipeRight;
  final void Function() _onSwipeLeft;
  final List<UserPublic> _prospects;

  @override
  _SwipableCardState createState() => _SwipableCardState();
}

class _SwipableCardState extends State<SwipableCard>
    with TickerProviderStateMixin {
  Offset _cardOffset = const Offset(0, 0);
  double _cardBehindScale = 0.95;
  AnimationController _animationController;
  static const Duration _animationDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _behindCard(),
        if (widget._prospects.isEmpty)
          _searching()
        else
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                _cardOffset += details.delta;
              });
            },
            onPanEnd: (DragEndDetails details) {
              final double horizontalSwipeDistance = _cardOffset.dx;
              final double screenWidth = MediaQuery.of(context).size.width;
              final bool didNotMoveMuch =
                  (horizontalSwipeDistance.abs() / screenWidth) < 0.3;
              if (didNotMoveMuch) {
                _animateBack();
              } else {
                if (horizontalSwipeDistance > 0) {
                  swipeRight(velocity: details.velocity.pixelsPerSecond);
                } else {
                  swipeLeft(velocity: details.velocity.pixelsPerSecond);
                }
              }
            },
            child: Transform.translate(
              offset: _cardOffset,
              child: ProspectCard(
                userPublic: widget._prospects.first,
              ),
            ),
          ),
      ],
    );
  }

  Widget _behindCard() {
    if (widget._prospects.isEmpty) {
      return Container();
    } else if (widget._prospects.length == 1) {
      return _searching();
    }
    return Transform.scale(
      scale: _cardBehindScale,
      child: ProspectCard(
        userPublic: widget._prospects[1],
      ),
    );
  }

  Widget _searching() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text('探しています'),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _animateBack() async {
    final Offset initialCardOffset = _cardOffset;
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )
      ..reverse(from: 1)
      ..drive(CurveTween(curve: Curves.easeInBack))
      ..addListener(() {
        setState(() {
          _cardOffset = initialCardOffset * _animationController.value;
        });
      });
  }

  Future<void> swipeRight({@required Offset velocity}) async {
    final Offset initialCardOffset = _cardOffset;
    final double horizontalOffset = MediaQuery.of(context).size.width * 1.5;
    double verticalOffset;
    if (velocity.dx == 0) {
      verticalOffset = 0;
    } else {
      verticalOffset = horizontalOffset / velocity.dx * velocity.dy;
    }
    final Offset finalOffset = Offset(
      horizontalOffset,
      verticalOffset,
    );
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )
      ..forward()
      ..addListener(() {
        setState(() {
          _cardBehindScale = SwipableCard._initialBehindCardScale +
              (1 - SwipableCard._initialBehindCardScale) *
                  _animationController.value;
          _cardOffset = initialCardOffset +
              (finalOffset - initialCardOffset) * _animationController.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget._onSwipeRight();
          setState(() {
            _cardBehindScale = SwipableCard._initialBehindCardScale;
            _cardOffset = const Offset(0, 0);
          });
        }
      });
  }

  Future<void> swipeLeft({@required Offset velocity}) async {
    final Offset initialCardOffset = _cardOffset;
    final double horizontalOffset = -MediaQuery.of(context).size.width * 1.5;
    double verticalOffset;
    if (velocity.dx == 0) {
      verticalOffset = 0;
    } else {
      verticalOffset = horizontalOffset / velocity.dx * velocity.dy;
    }
    final Offset finalOffset = Offset(
      horizontalOffset,
      verticalOffset,
    );
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )
      ..forward()
      ..addListener(() {
        setState(() {
          _cardBehindScale = SwipableCard._initialBehindCardScale +
              (1 - SwipableCard._initialBehindCardScale) *
                  _animationController.value;
          _cardOffset = initialCardOffset +
              (finalOffset - initialCardOffset) * _animationController.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget._onSwipeLeft();
          setState(() {
            _cardBehindScale = SwipableCard._initialBehindCardScale;
            _cardOffset = const Offset(0, 0);
          });
        }
      });
  }
}
