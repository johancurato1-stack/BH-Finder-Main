import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! PUBLISHING OPERATION
//============================================================================

enum PublishingOperation { publish, update, delete }

//============================================================================
//! PUBLISHING LOADING SCREEN
//============================================================================

class PublishingLoadingScreen extends StatefulWidget {
  const PublishingLoadingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.onPublish,
    this.progress,
    this.operation = PublishingOperation.publish,
  });

  final String title;

  final String subtitle;

  final List<PublishingLoadingStep> steps;

  final Future<bool> Function() onPublish;

  final double? progress;

  final PublishingOperation operation;

  @override
  State<PublishingLoadingScreen> createState() =>
      _PublishingLoadingScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _PublishingLoadingScreenState extends State<PublishingLoadingScreen> {
  bool _isStarted = false;

  bool _isLoading = false;

  bool _hasFinished = false;

  //============================================================================
  //! GETTERS
  //============================================================================

  bool get _isDelete => widget.operation == PublishingOperation.delete;

  String get _confirmTitle {
    switch (widget.operation) {
      case PublishingOperation.publish:
        return 'Publish ${_getItemName()}?';

      case PublishingOperation.update:
        return 'Update ${_getItemName()}?';

      case PublishingOperation.delete:
        return 'Delete ${_getItemName()} Permanently?';
    }
  }

  String get _confirmSubtitle {
    switch (widget.operation) {
      case PublishingOperation.publish:
        return 'Your ${_getItemName().toLowerCase()} will be published and made available to students.';

      case PublishingOperation.update:
        return 'Your ${_getItemName().toLowerCase()} information and photos will be updated.';

      case PublishingOperation.delete:
        return 'This action cannot be undone. The ${_getItemName().toLowerCase()} and its associated data will be permanently deleted.';
    }
  }

  String get _confirmButtonText {
    switch (widget.operation) {
      case PublishingOperation.publish:
        return 'Publish';

      case PublishingOperation.update:
        return 'Update';

      case PublishingOperation.delete:
        return 'Delete Permanently';
    }
  }

  String _getItemName() {
    final title = widget.title.toLowerCase();

    if (title.contains('property')) {
      return 'Property';
    }

    if (title.contains('room')) {
      return 'Room';
    }

    return 'Item';
  }

  //============================================================================
  //! START OPERATION
  //============================================================================

  Future<void> _startOperation() async {
    if (_isLoading || _hasFinished) {
      return;
    }

    setState(() {
      _isStarted = true;
      _isLoading = true;
    });

    bool success = false;

    try {
      success = await widget.onPublish();
    } catch (_) {
      success = false;
    }

    if (!mounted || _hasFinished) {
      return;
    }

    _hasFinished = true;

    setState(() {
      _isLoading = false;
    });

    //==========================================================================
    //! WAIT FOR CURRENT FRAME / NAVIGATION TO FINISH
    //==========================================================================

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.of(context).pop<bool>(success);
    });
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (!_isStarted) {
      return _buildConfirmationScreen();
    }

    return _buildLoadingScreen();
  }

  //============================================================================
  //! CONFIRMATION SCREEN
  //============================================================================

  Widget _buildConfirmationScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _confirmTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    _confirmSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: AppColors.secondary.withValues(alpha: 0.65),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: _isDelete
                                ? Colors.red.withValues(alpha: 0.10)
                                : AppColors.primary.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isDelete
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline_rounded,
                            color: _isDelete ? Colors.red : AppColors.primary,
                            size: 30,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          _isDelete
                              ? 'Please confirm this action'
                              : 'Ready to continue?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          _isDelete
                              ? 'Once you continue, this action cannot be reversed.'
                              : 'Make sure everything is correct before continuing.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: AppColors.secondary.withValues(alpha: 0.55),
                          ),
                        ),

                        const SizedBox(height: 24),

                        OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  Navigator.of(context).pop<bool>(false);
                                },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 52),
                            side: BorderSide(
                              color: AppColors.secondary.withValues(
                                alpha: 0.15,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _startOperation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isDelete
                                  ? Colors.red
                                  : AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              _confirmButtonText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    _isDelete
                        ? 'This action is permanent.'
                        : 'You can continue once you are ready.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //============================================================================
  //! LOADING SCREEN
  //============================================================================

  Widget _buildLoadingScreen() {
    final completedSteps = widget.steps
        .where((step) => step.status == PublishingStepStatus.completed)
        .length;

    final totalSteps = widget.steps.length;

    final calculatedProgress = totalSteps == 0
        ? 0.0
        : completedSteps / totalSteps;

    final currentProgress = widget.progress ?? calculatedProgress;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: AppColors.secondary.withValues(alpha: 0.65),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _isDelete ? Colors.red : AppColors.primary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Text(
                                _isDelete
                                    ? 'Deleting'
                                    : widget.operation ==
                                          PublishingOperation.update
                                    ? 'Updating'
                                    : 'Publishing',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary.withValues(
                                    alpha: 0.85,
                                  ),
                                ),
                              ),
                            ),

                            Text(
                              '${(currentProgress * 100).round()}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _isDelete
                                    ? Colors.red
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            minHeight: 7,
                            value: currentProgress.clamp(0.0, 1.0),
                            backgroundColor: AppColors.secondary.withValues(
                              alpha: 0.08,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _isDelete ? Colors.red : AppColors.primary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        ...List.generate(widget.steps.length, (index) {
                          final step = widget.steps[index];

                          return _StepTile(
                            step: step,
                            isLast: index == widget.steps.length - 1,
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Please don\'t close the app while this is in progress.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//============================================================================
//! STEP TILE
//============================================================================

class _StepTile extends StatelessWidget {
  const _StepTile({required this.step, required this.isLast});

  final PublishingLoadingStep step;

  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isCompleted = step.status == PublishingStepStatus.completed;

    final isCurrent = step.status == PublishingStepStatus.current;

    final iconColor = isCompleted || isCurrent
        ? AppColors.primary
        : AppColors.secondary.withValues(alpha: 0.25);

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.primary
                    : isCurrent
                    ? AppColors.primary.withValues(alpha: 0.10)
                    : AppColors.secondary.withValues(alpha: 0.06),
                shape: BoxShape.circle,
                border: isCurrent
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      )
                    : null,
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                      color: Colors.white,
                    )
                  : isCurrent
                  ? const Padding(
                      padding: EdgeInsets.all(9),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : Icon(Icons.circle_outlined, size: 18, color: iconColor),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isCompleted || isCurrent
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isCompleted || isCurrent
                          ? AppColors.secondary
                          : AppColors.secondary.withValues(alpha: 0.45),
                    ),
                  ),

                  if (step.subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      step.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondary.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),

        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 10, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 1,
                height: 20,
                color: AppColors.secondary.withValues(alpha: 0.08),
              ),
            ),
          ),
      ],
    );
  }
}

//============================================================================
//! PUBLISHING STEP STATUS
//============================================================================

enum PublishingStepStatus { pending, current, completed }

//============================================================================
//! PUBLISHING LOADING STEP
//============================================================================

class PublishingLoadingStep {
  const PublishingLoadingStep({
    required this.title,
    this.subtitle,
    required this.status,
  });

  final String title;

  final String? subtitle;

  final PublishingStepStatus status;
}
