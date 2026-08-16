import 'package:flutter/material.dart';
import '../../../core/sync/offline_record_type.dart';
import '../field_operations/field_operation_form_screen.dart';

class PigletRegistrationScreen extends StatelessWidget {
  const PigletRegistrationScreen({super.key});
  @override
  Widget build(BuildContext context) => const FieldOperationFormScreen(
    title: 'Piglet Registration', subtitle: 'Register a piglet and retain its farmer, sow, and pen relationship offline.', recordType: OfflineRecordType.piglet,
    fields: [
      OperationField(key: 'piglet_id', label: 'Piglet ID / UUID'), OperationField(key: 'mother_sow_id', label: 'Mother / Sow ID'), OperationField(key: 'farmer_id', label: 'Farmer ID'), OperationField(key: 'pen_id', label: 'Pig Pen ID'), OperationField(key: 'birth_date', label: 'Birth Date', date: true), OperationField(key: 'breed', label: 'Breed'), OperationField(key: 'sex', label: 'Sex', options: ['Male', 'Female']), OperationField(key: 'birth_weight', label: 'Birth Weight (kg)', number: true), OperationField(key: 'current_weight', label: 'Current Weight (kg)', number: true), OperationField(key: 'health_status', label: 'Health Status', options: ['Healthy', 'Needs Attention', 'Sick']), OperationField(key: 'vaccination_status', label: 'Vaccination Status', options: ['Not started', 'Partial', 'Up to date']), OperationField(key: 'weaning_status', label: 'Weaning Status', options: ['Not weaned', 'Weaning', 'Weaned']), OperationField(key: 'remarks', label: 'Remarks', multiline: true),
    ],
  );
}
