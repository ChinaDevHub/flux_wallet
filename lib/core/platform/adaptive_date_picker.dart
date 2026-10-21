import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Wheel picker sheet on iOS, calendar dialog on Android.
Future<DateTime?> pickDate(
  BuildContext context, {
  required DateTime initial,
  required DateTime first,
  required DateTime last,
}) {
  if (!context.isCupertino) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );
  }
  return showAppSheet<DateTime>(context, (ctx) {
    var picked = initial;
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initial,
              minimumDate: first,
              maximumDate: last,
              onDateTimeChanged: (d) => picked = d,
            ),
          ),
          CupertinoButton(
            onPressed: () => Navigator.pop(ctx, picked),
            child: Text('Hazır', style: TextStyle(color: ctx.colors.primary)),
          ),
        ],
      ),
    );
  });
}
