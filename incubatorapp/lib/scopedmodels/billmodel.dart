import 'package:incubatorapp/api/api.dart';
import 'package:incubatorapp/main.dart';
import 'package:incubatorapp/models/bill.dart';
import 'package:incubatorapp/models/condition.dart';
import 'package:incubatorapp/models/consumable.dart';
import 'package:incubatorapp/models/extra.dart';
import 'package:incubatorapp/models/laboratory.dart';
import 'package:incubatorapp/models/medicine.dart';
import 'package:incubatorapp/models/patient.dart';
import 'package:incubatorapp/models/patientconsumablenurse.dart';
import 'package:incubatorapp/models/patientextra.dart';
import 'package:incubatorapp/models/patientlaboratory.dart';
import 'package:incubatorapp/models/patientmedicinedoctor.dart';
import 'package:incubatorapp/models/patientxray.dart';
import 'package:incubatorapp/models/xray.dart';
import 'package:scoped_model/scoped_model.dart';

class BillModel extends Model {
  Api _api = new Api('bill');

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<Bill> billList = [];

  Bill _currentBill;

  Bill get currentBill => _currentBill;

  void createBill() {
    _currentBill = new Bill(0, DateTime.now(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  }

  Bill newBill(DateTime currentDateTime) {
    Bill newBill = new Bill(0, currentDateTime, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    return newBill;
  }

  void editBill(Bill editBill) {
    _currentBill = editBill;
  }

  void setList(List<Bill> list) {
    billList = list;
    _isLoading = false;
    notifyListeners();
  }

  DateTime getCreatedDate() {
    return _currentBill.createdDate;
  }

  void setPaid(double paid) {
    _currentBill.paid = paid;
    notifyListeners();
  }

  double getPaid() {
    return _currentBill.paid;
  }

  void setDayCost(double dayCost) {
    _currentBill.dayCost = dayCost;
  }

  double getDayCost() {
    return _currentBill.dayCost;
  }

  void setConsumable(double consumable) {
    _currentBill.consumable = consumable;
  }

  double getConsumable() {
    return _currentBill.consumable;
  }

  void setLaboratory(double laboratory) {
    _currentBill.laboratory = laboratory;
  }

  double getLaboratory() {
    return _currentBill.laboratory;
  }

  void setXRay(double xRay) {
    _currentBill.xRay = xRay;
  }

  double getXRay() {
    return _currentBill.xRay;
  }

  void setLightRays(double lightRays) {
    _currentBill.lightRays = lightRays;
  }

  double getLightRays() {
    return _currentBill.lightRays;
  }

  void setMedicine(double medicine) {
    _currentBill.medicine = medicine;
  }

  double getMedicine() {
    return _currentBill.medicine;
  }

  void setExtra(double extra) {
    _currentBill.extra = extra;
  }

  double getExtra() {
    return _currentBill.extra;
  }

  void setDiscount(double discount) {
    _currentBill.discount = discount;
  }

  double getDiscount() {
    return _currentBill.discount;
  }

  void setPatientId(int patientId) {
    _currentBill.patientId = patientId;
  }

  int gePatientId() {
    return _currentBill.patientId;
  }

  String formatDate(DateTime dateTime) {
    String v = dateTime.day.toString();
    v = v + '/' + dateTime.month.toString();
    v = v + '/' + dateTime.year.toString();

    return v;
  }

  double calculateBillRow() {
    double total = _currentBill.dayCost +
        _currentBill.extra +
        _currentBill.consumable +
        _currentBill.laboratory +
        _currentBill.xRay +
        _currentBill.lightRays +
        _currentBill.medicine;

    return total;
  }

  double calculateBillRowWithDiscount() {
    double total = _currentBill.dayCost +
        _currentBill.extra +
        _currentBill.consumable +
        _currentBill.laboratory +
        _currentBill.xRay +
        _currentBill.lightRays +
        _currentBill.medicine -
        _currentBill.discount;

    return total;
  }

  double calculateTotalCost() {
    double total = 0;
    if (billList != null) {
      billList.forEach((b) {
        _currentBill = b;
        total += calculateBillRow();
      });
    }
    return total;
  }

  double calculateTotalPaid() {
    double total = 0;
    if (billList != null) {
      billList.forEach((b) {
        total += b.paid;
      });
    }
    return total;
  }

  double calculateTotalDiscount() {
    double total = 0;
    if (billList != null) {
      billList.forEach((b) {
        total += b.discount;
      });
    }
    return total;
  }

  double calculateTotalChange() {
    double total = 0;
    double cost = calculateTotalCost();
    double paid = calculateTotalPaid();
    double discount = calculateTotalDiscount();
    cost = cost - discount;
    total = paid - cost;
    return total;
  }

  double countBillDataRows() {
    List<String> dateString = [];

    double count = 0;

    print('Bills:'+billList.length.toString());

    List<PatientLaboratory> cpal =
        patientModel.currentPatient.patientLaboratoryList;
    count += cpal.length;
    cpal.forEach((pl) {
      print('Lab:'+formatDate(pl.createdDate));
      List<Bill> tempList = billList.where((b) => formatDate(b.createdDate) == formatDate(pl.createdDate)).toList();
      if(tempList.length == 0){
        _currentBill = newBill(pl.createdDate);
        billList.add(_currentBill);
      }
    });

    print('Bills:'+billList.length.toString());

    List<PatientXRay> cpxl = patientModel.currentPatient.patientXRaysList;
    count += cpxl.length;
    cpxl.forEach((px) {
      print('xr:'+formatDate(px.createdDate));
      List<Bill> tempList = billList.where((b) => formatDate(b.createdDate) == formatDate(px.createdDate)).toList();
      if(tempList.length == 0){
        _currentBill = newBill(px.createdDate);
        billList.add(_currentBill);
      }
    });

    print('Bills:'+billList.length.toString());

    List<PatientMedicineDoctor> cpmdl =
        patientModel.currentPatient.patientMedicineDoctorList;
    count += cpmdl.length;
    cpmdl.forEach((pm) {
      print('med:'+formatDate(pm.createdDate));
      List<Bill> tempList = billList.where((b) => formatDate(b.createdDate) == formatDate(pm.createdDate)).toList();
      if(tempList.length == 0){
        _currentBill = newBill(pm.createdDate);
        billList.add(_currentBill);
      }
    });

    print('Bills:'+billList.length.toString());

    List<PatientConsumableNurse> cpcnl =
        patientModel.currentPatient.patientConsumableNurseList;
    count += cpcnl.length;
    cpcnl.forEach((pc) {
      print('con:'+formatDate(pc.createdDate));
      List<Bill> tempList = billList.where((b) => formatDate(b.createdDate) == formatDate(pc.createdDate)).toList();
      if(tempList.length == 0){
        _currentBill = newBill(pc.createdDate);
        billList.add(_currentBill);
      }
    });

    print('Bills:'+billList.length.toString());

    List<PatientExtra> cpel = patientModel.currentPatient.patientExtraList;
    count += cpel.length;
    cpel.forEach((pe) {
      print('ex:'+formatDate(pe.createdDate));
      List<Bill> tempList = billList.where((b) => formatDate(b.createdDate) == formatDate(pe.createdDate)).toList();
      if(tempList.length == 0){
        _currentBill = newBill(pe.createdDate);
        billList.add(_currentBill);
      }
    });

    print('Bills:'+billList.length.toString());

    return count;
  }

  void _calculateLaboratory() {
    double total = 0;

    billList.forEach((bill) {
      List<PatientLaboratory> cpal = patientModel
          .currentPatient.patientLaboratoryList
          .where((element) =>
              formatDate(element.createdDate) == formatDate(bill.createdDate))
          .toList();

      cpal.forEach((cpa) {
        Laboratory laboratory;

        List<Laboratory> cal = laboratoryModel.laboratoryList
            .where((element) => element.id == cpa.laboratoryId)
            .toList();

        if (cal.length > 0) {
          laboratory = cal[0];
        }

        if (laboratory != null) {
          total += laboratory.price;
        }
      });
      bill.laboratory = total;
    });
  }

  void _calculateXRay() {
    double total = 0;
    billList.forEach((bill) {
      List<PatientXRay> cpxl = patientModel.currentPatient.patientXRaysList
          .where((element) =>
              formatDate(element.createdDate) == formatDate(bill.createdDate))
          .toList();

      cpxl.forEach((cpx) {
        XRay xRay;

        List<XRay> cxl = xRayModel.xRayList
            .where((element) => element.id == cpx.xRayId)
            .toList();

        if (cxl.length > 0) {
          xRay = cxl[0];
        }

        if (xRay != null) {
          total += xRay.price;
        }
      });
      bill.xRay = total;
    });
  }

  void _calculateMedicine() {
    double total = 0;
    billList.forEach((bill) {
      List<PatientMedicineDoctor> cpmdl = patientModel
          .currentPatient.patientMedicineDoctorList
          .where((element) =>
              formatDate(element.createdDate) == formatDate(bill.createdDate))
          .toList();

      cpmdl.forEach((cpmd) {
        Medicine medicine;

        List<Medicine> cml = medicineModel.medicineList
            .where((element) => element.id == cpmd.medicineId)
            .toList();

        if (cml.length > 0) {
          medicine = cml[0];
        }
        total += (medicine.price * cpmd.quantity);
      });
      bill.medicine = total;
    });
  }

  void _calculateConsumable() {
    double total = 0;
    billList.forEach((bill) {
      List<PatientConsumableNurse> cpcnl = patientModel
          .currentPatient.patientConsumableNurseList
          .where((element) =>
              formatDate(element.createdDate) == formatDate(bill.createdDate))
          .toList();

      cpcnl.forEach((cpcn) {
        Consumable consumable;

        List<Consumable> ccl = consumableModel.consumableList
            .where((element) => element.id == cpcn.consumableId)
            .toList();

        if (ccl.length > 0) {
          consumable = ccl[0];
        }

        total += (consumable.price * cpcn.quantity);
      });
      bill.consumable = total;
    });
  }

  void _calculateExtra() {
    double total = 0;
    billList.forEach((bill) {
      List<PatientExtra> cpel = patientModel.currentPatient.patientExtraList
          .where((element) =>
              formatDate(element.createdDate) == formatDate(bill.createdDate))
          .toList();

      cpel.forEach((cpe) {
        int index = billList.indexWhere(
            (cb) => formatDate(cb.createdDate) == formatDate(cpe.createdDate));

        Extra extra;

        List<Extra> cel = extraModel.extraList
            .where((element) => element.id == cpe.extraId)
            .toList();

        if (cel.length > 0) {
          extra = cel[0];
        }

        if (extra != null) {
          total += extra.price;
        }
      });
      bill.extra = total;
    });
  }

  void calculateBillsForAccountant() async {

    _isLoading = true;
    notifyListeners();

    double count = countBillDataRows();

    _calculateLaboratory();

    _calculateXRay();

    _calculateMedicine();

    _calculateConsumable();

    _calculateExtra();

    billList.forEach((bill) {
      _currentBill = bill;
      _currentBill.patientId = patientModel.currentPatient.userId;

      int index = conditionModel.conditionList
          .indexWhere((element) => element.id == patientModel.currentPatient.conditionId);

      Condition condition = conditionModel.conditionList[index];

      setDayCost(condition.price);

      if (patientModel.currentPatient.isOnLightRay) {
        setLightRays(condition.price);
      }

      if (_currentBill.id == 0) {
        create();
      } else {
        update();
      }
    });

    await Future.delayed(Duration(seconds: 3));

    //notifyListeners();

    readByPatientId(patientModel.currentPatient.userId);
  }

  void clearList() {
    _isLoading = true;
    if (billList != null) {
      if (billList.length > 0) {
        billList.clear();
        notifyListeners();
      }
    }
  }

  Future<List<Bill>> readByPatientId(int patientId) async {
    clearList();

    List<String> fields = <String>[];
    List<String> values = <String>[];

    fields.add('patientId');
    values.add(patientId.toString());

    List<dynamic> billListMap;

    billListMap = await _api.filter(fields, values);

    if (billListMap != null) {
      billList = billListMap.map((e) => Bill.fromJson(e)).toList();
    }

    _isLoading = false;

    notifyListeners();

    return billList;
  }

  Future<bool> create() async {
    int code = await _api.post(_currentBill.toJson());
    if (code == 201) {
      //billList.add(_currentBill);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> update() async {
    int code =
        await _api.put(_currentBill.toJson(), _currentBill.id.toString());

    if (code == 200) {
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<bool> delete() async {
    int code = await _api.delete(_currentBill.id.toString());

    if (code == 204) {
      billList.remove(_currentBill);
      notifyListeners();

      return true;
    }
    return false;
  }
}
