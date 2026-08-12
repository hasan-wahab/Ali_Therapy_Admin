import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_see_more_toggle.dart';

// ============================================================
// APP EXPANDABLE CARD
// ------------------------------------------------------------
// One bordered card: content + attached See all / See less bar.
// Use only for tall content (above collapsed height). Short cards stay plain.
// ============================================================

class AppExpandableCard extends StatefulWidget {
  const AppExpandableCard({
    super.key,
    required this.child,
    this.collapsedHeight,
    this.initiallyExpanded = false,
  });

  /// Card body only (no outer border — this widget draws the border).
  final Widget child;

  /// Visible height when collapsed.
  final double? collapsedHeight;

  /// When true, card starts fully open (use for the first card on a screen).
  final bool initiallyExpanded;

  @override
  State<AppExpandableCard> createState() => _AppExpandableCardState();
}

class _AppExpandableCardState extends State<AppExpandableCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final collapsed = widget.collapsedHeight ?? 200.h;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _expanded
                ? widget.child
                : ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: collapsed),
                    child: ClipRect(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: widget.child,
                      ),
                    ),
                  ),
          ),
          // Same card — no extra border (keeps one outer border only)
          AppSeeMoreToggle(
            expanded: _expanded,
            onTap: () => setState(() => _expanded = !_expanded),
          ),
        ],
      ),
    );
  }
}
