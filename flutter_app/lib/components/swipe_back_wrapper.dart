import 'package:flutter/cupertino.dart';

class SwipeBackWrapper extends StatelessWidget {
  final Widget child;
  const SwipeBackWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Khi người dùng vuốt sang phải với tốc độ đủ nhanh, quay lại màn hình trước đó.
      onHorizontalDragEnd: (details){
        if(details.primaryVelocity != null && details.primaryVelocity! >250){
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}
