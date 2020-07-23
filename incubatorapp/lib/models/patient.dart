import 'package:incubatorapp/models/bills.dart';
import 'package:incubatorapp/models/patientanalysis.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patientxrays.dart';
import 'package:incubatorapp/models/status.dart';

class Patient{
  List<PatientAnalysis> patientAnalysisList = [];
  List<Bills> billsList = [];
  List<PatientXRays> patientXRays = [];
  List<PatientMedicineDoctor> patientMedicineDoctorList = [];
  List<PatientConsumableNurse> patientConsumableNurseList = [];
  List<Status> statusList = [];
}