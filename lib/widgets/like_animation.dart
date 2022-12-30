
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child; 
  final bool isAnimating;
  final Duration duration;   
  final bool smallLike;
  final VoidCallback? onEnd;

  LikeAnimation({
      Key? key,
      this.onEnd,
      this.smallLike = false, 
      required this.child,
      this.duration=const Duration(milliseconds: 500),
      required this.isAnimating}

  ):super(key:key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {

  late Animation<double> scale;
  late AnimationController controller;
  @override
  void initState(){
    super.initState();
    controller=AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget){
    
    super.didUpdateWidget(oldWidget);
    
    if(oldWidget.isAnimating != widget.isAnimating){
      startAnimation();
    }
  }

  startAnimation()async{

    if(widget.isAnimating || widget.smallLike){
        print(widget.isAnimating);
   
      try{
        await controller.forward();
        await controller.reverse();
        await Future.delayed(const Duration(milliseconds: 200));
        
        if(widget.onEnd !=null){
          widget.onEnd!();
        }
      }catch(err){
        print(err.toString());
      }

    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}