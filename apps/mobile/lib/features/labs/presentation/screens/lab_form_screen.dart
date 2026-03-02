import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/app_constants.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/widgets/app_async_view.dart';
import 'package:mobile/features/labs/domain/entities/lab.dart';
import 'package:mobile/features/labs/domain/entities/lab_draft.dart';
import 'package:mobile/features/labs/presentation/controllers/labs_action_controller.dart';
import 'package:mobile/features/labs/presentation/providers/labs_providers.dart';
import 'package:mobile/features/labs/presentation/widgets/lab_color_picker.dart';
import 'package:mobile/features/labs/presentation/widgets/lab_icon_picker.dart';

class LabFormScreen extends ConsumerStatefulWidget {
  const LabFormScreen({super.key, this.labId});

  final String? labId;

  bool get isEdit => labId != null;

  @override
  ConsumerState<LabFormScreen> createState() => _LabFormScreenState();
}

class _LabFormScreenState extends ConsumerState<LabFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  String _selectedIconId = kDefaultLabIconId;
  String _selectedColorHex = kDefaultLabColorHex;
  bool _initializedFromExisting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(labsActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (Object error, StackTrace stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    final isBusy = ref.watch(labsActionControllerProvider).isLoading;

    if (widget.isEdit) {
      final labAsync = ref.watch(labByIdProvider(widget.labId!));
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Lab')),
        body: AppAsyncView<Lab?>(
          value: labAsync,
          data: (Lab? lab) {
            if (lab == null) {
              return const Center(child: Text('Lab not found.'));
            }
            _hydrateFromLab(lab);
            return _LabFormBody(
              formKey: _formKey,
              nameController: _nameController,
              descriptionController: _descriptionController,
              selectedIconId: _selectedIconId,
              selectedColorHex: _selectedColorHex,
              onIconChanged: (value) => setState(() => _selectedIconId = value),
              onColorChanged: (value) =>
                  setState(() => _selectedColorHex = value),
              isBusy: isBusy,
              onSubmit: _submit,
              submitText: 'Save Changes',
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('New Lab')),
      body: _LabFormBody(
        formKey: _formKey,
        nameController: _nameController,
        descriptionController: _descriptionController,
        selectedIconId: _selectedIconId,
        selectedColorHex: _selectedColorHex,
        onIconChanged: (value) => setState(() => _selectedIconId = value),
        onColorChanged: (value) => setState(() => _selectedColorHex = value),
        isBusy: isBusy,
        onSubmit: _submit,
        submitText: 'Create Lab',
      ),
    );
  }

  void _hydrateFromLab(Lab lab) {
    if (_initializedFromExisting) {
      return;
    }
    _nameController.text = lab.name;
    _descriptionController.text = lab.description ?? '';
    _selectedIconId = lab.iconId;
    _selectedColorHex = lab.colorHex;
    _initializedFromExisting = true;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final draft = LabDraft(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      iconId: _selectedIconId,
      colorHex: _selectedColorHex,
    );

    final controller = ref.read(labsActionControllerProvider.notifier);

    if (widget.isEdit) {
      await controller.updateLab(labId: widget.labId!, draft: draft);
      if (mounted) {
        Navigator.of(context).pop();
      }
      return;
    }

    await controller.createLab(draft);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _LabFormBody extends StatelessWidget {
  const _LabFormBody({
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.selectedIconId,
    required this.selectedColorHex,
    required this.onIconChanged,
    required this.onColorChanged,
    required this.isBusy,
    required this.onSubmit,
    required this.submitText,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String selectedIconId;
  final String selectedColorHex;
  final ValueChanged<String> onIconChanged;
  final ValueChanged<String> onColorChanged;
  final bool isBusy;
  final Future<void> Function() onSubmit;
  final String submitText;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.spacingMd),
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Lab name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Lab name is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSizes.spacingSm),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
                minLines: 2,
                maxLines: 4,
              ),
              const SizedBox(height: AppSizes.spacingLg),
              LabIconPicker(
                selectedIconId: selectedIconId,
                onChanged: onIconChanged,
              ),
              const SizedBox(height: AppSizes.spacingLg),
              LabColorPicker(
                selectedColorHex: selectedColorHex,
                onChanged: onColorChanged,
              ),
              const SizedBox(height: AppSizes.spacingXl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isBusy ? null : onSubmit,
                  child: Text(submitText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
