import 'package:flutter/material.dart';
import '../../../core/sync/offline_record_type.dart';
import '../field_operations/field_operation_form_screen.dart';

class WasteManagementInspectionScreen extends StatelessWidget {
  const WasteManagementInspectionScreen({super.key});
  @override
  Widget build(BuildContext context) => const FieldOperationFormScreen(
    title: 'Waste Management Inspection', subtitle: 'Capture disposal compliance and evidence. The record is safe offline.', recordType: OfflineRecordType.wasteInspection,
    fields: [
      OperationField(key: 'farmer_id', label: 'Farmer ID'), OperationField(key: 'pen_id', label: 'Pig Pen ID'), OperationField(key: 'inspection_date', label: 'Inspection Date', date: true), OperationField(key: 'waste_type', label: 'Waste Type'), OperationField(key: 'disposal_method', label: 'Disposal Method'), OperationField(key: 'disposal_frequency', label: 'Disposal Frequency'), OperationField(key: 'estimated_quantity', label: 'Estimated Quantity', number: true), OperationField(key: 'disposal_location', label: 'Disposal Location'), OperationField(key: 'compliance_status', label: 'Compliance Status', options: ['Compliant', 'Partially Compliant', 'Non-Compliant', 'Under Verification']), OperationField(key: 'findings', label: 'Findings', multiline: true), OperationField(key: 'recommendations', label: 'Recommendations', multiline: true), OperationField(key: 'remarks', label: 'Remarks', multiline: true),
    ],
  );
}
