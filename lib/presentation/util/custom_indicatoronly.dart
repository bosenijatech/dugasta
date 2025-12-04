import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/cupertino.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CupertinoActivityIndicator(
          color: AppColor.black,
          radius: 20,
          animating: true,
        ),
      ),
    );
  }
}
