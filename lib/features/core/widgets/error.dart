import 'package:flutter/material.dart';
import 'package:quizapps/features/core/widgets/spacer.dart';
import 'package:quizapps/features/core/widgets/text.dart';

import '../utils/constant.dart';

class ErrorContainer extends StatelessWidget {
  final Function()? onRetry;

  const ErrorContainer({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[300],
            size: 60,
          ),
          const VerticalSpacer(),
          const TitleText(
            AppConstant.errorOccurred,
          ),
          const VerticalSpacer(),
          InkWell(
            onTap: onRetry,
            child: const LabelText(AppConstant.tryAgain),
          ),
        ],
      ),
    );
  }
}
