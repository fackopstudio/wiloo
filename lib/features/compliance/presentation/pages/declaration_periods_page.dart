import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/declaration_period.dart';
import '../../domain/enums/period_type.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationPeriodsPage extends ConsumerWidget {
  const DeclarationPeriodsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(complianceAccessProvider);
    final periodsAsync = ref.watch(
      declarationPeriodsProvider(const ListDeclarationPeriodsQuery()),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Périodes déclaratives')),
      floatingActionButton: access.canCreatePeriod
          ? FloatingActionButton.extended(
              onPressed: () => _showCreatePeriodDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Nouvelle période'),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          Expanded(
            child: periodsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ComplianceErrorState(
                message: complianceErrorMessage(error),
                onRetry: () => ref.invalidate(
                  declarationPeriodsProvider(
                    const ListDeclarationPeriodsQuery(),
                  ),
                ),
              ),
              data: (periods) => periods.isEmpty
                  ? ComplianceEmptyState(
                      message: 'Aucune période déclarative.',
                      actionLabel: access.canCreatePeriod
                          ? 'Créer une période'
                          : null,
                      onAction: access.canCreatePeriod
                          ? () => _showCreatePeriodDialog(context)
                          : null,
                    )
                  : _PeriodList(periods: periods),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreatePeriodDialog(BuildContext context) async {
    final period = await showDialog<DeclarationPeriod>(
      context: context,
      builder: (_) => const _CreatePeriodDialog(),
    );

    if (context.mounted && period != null) {
      showComplianceSnackBar(context, 'Période ${periodLabel(period)} créée.');
    }
  }
}

class _PeriodList extends StatelessWidget {
  const _PeriodList({required this.periods});

  final List<DeclarationPeriod> periods;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: periods.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _PeriodCard(period: periods[index]),
    );
  }
}

class _PeriodCard extends StatelessWidget {
  const _PeriodCard({required this.period});

  final DeclarationPeriod period;

  String _periodSubtitle() {
    return switch (period.periodType) {
      PeriodType.monthly =>
        period.month != null ? 'Mois ${period.month}' : '${period.year}',
      PeriodType.quarterly =>
        period.quarter != null
            ? 'T${period.quarter} ${period.year}'
            : '${period.year}',
      PeriodType.yearly => '${period.year}',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.calendar_month_outlined),
        title: Text('${periodTypeLabel(period.periodType)} ${period.year}'),
        subtitle: Text(_periodSubtitle()),
        trailing: ComplianceStatusChip(period.status),
        onTap: () => context.goNamed(AppRoute.complianceDeclarations.name),
      ),
    );
  }
}

class _CreatePeriodDialog extends ConsumerStatefulWidget {
  const _CreatePeriodDialog();

  @override
  ConsumerState<_CreatePeriodDialog> createState() =>
      _CreatePeriodDialogState();
}

class _CreatePeriodDialogState extends ConsumerState<_CreatePeriodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController(
    text: DateTime.now().year.toString(),
  );
  final _payrollMonthController = TextEditingController();
  final _payrollYearController = TextEditingController();

  PeriodType _periodType = PeriodType.monthly;
  int? _month = DateTime.now().month;
  int? _quarter;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  void dispose() {
    _yearController.dispose();
    _payrollMonthController.dispose();
    _payrollYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commandState = ref.watch(createPeriodControllerProvider);
    final isLoading = commandState.isLoading;

    return AlertDialog(
      title: const Text('Créer une période'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<PeriodType>(
                  initialValue: _periodType,
                  decoration: const InputDecoration(
                    labelText: 'Type de période',
                  ),
                  items: PeriodType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(periodTypeLabel(type)),
                        ),
                      )
                      .toList(),
                  onChanged: isLoading
                      ? null
                      : (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _periodType = value;
                            _month = value == PeriodType.monthly
                                ? DateTime.now().month
                                : null;
                            _quarter = value == PeriodType.quarterly ? 1 : null;
                          });
                        },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _yearController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(labelText: 'Année'),
                  keyboardType: TextInputType.number,
                  validator: _requiredPositiveInt,
                ),
                const SizedBox(height: 12),
                if (_periodType == PeriodType.monthly)
                  DropdownButtonFormField<int>(
                    key: const ValueKey('declaration-period-month'),
                    initialValue: _month,
                    decoration: const InputDecoration(labelText: 'Mois'),
                    items: List.generate(12, (index) => index + 1)
                        .map(
                          (month) => DropdownMenuItem(
                            value: month,
                            child: Text(month.toString().padLeft(2, '0')),
                          ),
                        )
                        .toList(),
                    onChanged: isLoading
                        ? null
                        : (value) => setState(() => _month = value),
                    validator: (value) =>
                        value == null ? 'Sélectionnez un mois.' : null,
                  ),
                if (_periodType == PeriodType.quarterly)
                  DropdownButtonFormField<int>(
                    key: const ValueKey('declaration-period-quarter'),
                    initialValue: _quarter,
                    decoration: const InputDecoration(labelText: 'Trimestre'),
                    items: List.generate(4, (index) => index + 1)
                        .map(
                          (quarter) => DropdownMenuItem(
                            value: quarter,
                            child: Text('T$quarter'),
                          ),
                        )
                        .toList(),
                    onChanged: isLoading
                        ? null
                        : (value) => setState(() => _quarter = value),
                    validator: (value) =>
                        value == null ? 'Sélectionnez un trimestre.' : null,
                  ),
                const SizedBox(height: 12),
                _DateField(
                  label: 'Date de début',
                  value: _startDate,
                  enabled: !isLoading,
                  onChanged: (date) => setState(() => _startDate = date),
                ),
                const SizedBox(height: 12),
                _DateField(
                  label: 'Date de fin',
                  value: _endDate,
                  enabled: !isLoading,
                  onChanged: (date) => setState(() => _endDate = date),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _payrollMonthController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Mois de paie associé',
                    hintText: 'Optionnel',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _optionalMonth,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _payrollYearController,
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Année de paie associée',
                    hintText: 'Optionnel',
                  ),
                  keyboardType: TextInputType.number,
                  validator: _optionalPositiveInt,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton.icon(
          onPressed: isLoading ? null : _submit,
          icon: isLoading
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add),
          label: const Text('Créer'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_endDate.isBefore(_startDate)) {
      showComplianceSnackBar(
        context,
        'La date de fin doit être postérieure à la date de début.',
        isError: true,
      );
      return;
    }

    final request = CreateDeclarationPeriodRequest(
      periodType: _periodType,
      year: int.parse(_yearController.text),
      month: _periodType == PeriodType.monthly ? _month : null,
      quarter: _periodType == PeriodType.quarterly ? _quarter : null,
      startDate: _startDate,
      endDate: _endDate,
      payrollMonth: _parseOptionalInt(_payrollMonthController.text),
      payrollYear: _parseOptionalInt(_payrollYearController.text),
    );

    await ref.read(createPeriodControllerProvider.notifier).create(request);
    if (!mounted) {
      return;
    }

    ref
        .read(createPeriodControllerProvider)
        .when(
          data: (period) {
            if (period == null) {
              return;
            }
            Navigator.of(context).pop(period);
          },
          error: (error, _) => showComplianceSnackBar(
            context,
            complianceErrorMessage(error),
            isError: true,
          ),
          loading: () {},
        );
  }

  String? _requiredPositiveInt(String? value) {
    final parsed = int.tryParse(value ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Saisissez une valeur valide.';
    }
    return null;
  }

  String? _optionalPositiveInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return _requiredPositiveInt(value);
  }

  String? _optionalMonth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1 || parsed > 12) {
      return 'Mois attendu entre 1 et 12.';
    }
    return null;
  }

  int? _parseOptionalInt(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return int.parse(trimmed);
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final bool enabled;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: enabled
          ? () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                onChanged(picked);
              }
            }
          : null,
      icon: const Icon(Icons.calendar_month_outlined),
      label: Text('$label : ${formatComplianceDate(value)}'),
    );
  }
}
