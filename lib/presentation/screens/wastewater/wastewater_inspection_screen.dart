import 'package:flutter/material.dart';
import '../../../core/sync/offline_record_type.dart';
import '../field_operations/field_operation_form_screen.dart';

class WastewaterInspectionScreen extends StatelessWidget {
  const WastewaterInspectionScreen({super.key});
  @override
  Widget build(BuildContext context) => const FieldOperationFormScreen(
    title: 'Wastewater Inspection', subtitle: 'Document discharge conditions with current GPS and photo evidence.', recordType: OfflineRecordType.wastewaterInspection,
    fields: [
      OperationField(key: 'farmer_id', label: 'Farmer ID'), OperationField(key: 'pen_id', label: 'Pig Pen ID'), OperationField(key: 'inspection_date', label: 'Inspection Date', date: true), OperationField(key: 'wastewater_source', label: 'Wastewater Source'), OperationField(key: 'discharge_method', label: 'Discharge Method'), OperationField(key: 'discharge_location', label: 'Discharge Location'), OperationField(key: 'treatment_method', label: 'Treatment Method'), OperationField(key: 'compliance_status', label: 'Compliance Status', options: ['Compliant', 'Partially Compliant', 'Non-Compliant', 'Under Verification']), OperationField(key: 'inspection_result', label: 'Inspection Result'), OperationField(key: 'findings', label: 'Findings', multiline: true), OperationField(key: 'recommendations', label: 'Recommendations', multiline: true), OperationField(key: 'remarks', label: 'Remarks', multiline: true),
    ],
  );
}
