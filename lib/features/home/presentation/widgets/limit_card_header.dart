import 'package:flutter/material.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/widgets/limit_status_chip.dart';

/// "Bu gün xərcləyə bilərsən" and today's state.
class LimitCardHeader extends StatelessWidget {
  const LimitCardHeader(this.s, {super.key});

  final HomeSnapshot s;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            'Bu gün xərcləyə bilərsən',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ),
        LimitStatusChip(s),
      ],
    );
  }
}
