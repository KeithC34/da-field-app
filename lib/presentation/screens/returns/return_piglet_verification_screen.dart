import 'package:flutter/material.dart';
import '../../../core/sync/offline_record_type.dart';
import '../field_operations/field_operation_form_screen.dart';

class ReturnPigletVerificationScreen extends StatelessWidget {
  const ReturnPigletVerificationScreen({super.key});
  @override
  Widget build(BuildContext context) => const FieldOperationFormScreen(
    title: 'Return Piglet Verification', subtitle: 'Verify a return against its original distribution record.', recordType: OfflineRecordType.returnPigletVerification, requireDispersalLink: true,
    fields: [
      OperationField(key: 'farmer_id', label: 'Farmer / Recipient ID'), OperationField(key: 'dispersal_program', label: 'Dispersal Program'), OperationField(key: 'dispersal_id', label: 'Original Distribution Record ID'), OperationField(key: 'piglet_id', label: 'Distributed Pig / Piglet ID'), OperationField(key: 'distribution_date', label: 'Distribution Date', date: true), OperationField(key: 'expected_return_date', label: 'Expected Return Date', date: true), OperationField(key: 'expected_return_quantity', label: 'Expected Return Quantity', number: true), OperationField(key: 'actual_return_date', label: 'Actual Return Date', date: true), OperationField(key: 'actual_return_quantity', label: 'Actual Return Quantity', number: true), OperationField(key: 'returned_piglet_ids', label: 'Returned Piglet IDs'), OperationField(key: 'piglet_health_status', label: 'Piglet Health Status', options: ['Healthy', 'Needs Attention', 'Sick']), OperationField(key: 'weight', label: 'Weight (kg)', number: true), OperationField(key: 'verification_result', label: 'Verification Result', options: ['Pending', 'For Verification', 'Verified', 'Rejected', 'Completed']), OperationField(key: 'verification_notes', label: 'Verification Notes', multiline: true),
    ],
  );
}
