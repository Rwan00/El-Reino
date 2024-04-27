
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 65,
                  width: 65,
                ),
              );
  }
}