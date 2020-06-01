import 'package:intl/intl.dart';

class Finance {
    int id;
    String rp;
    String deskripsi;
    String tanggal;
    int status;

    Finance(this.rp, this.deskripsi, this.tanggal, this.status);
    
    // Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = id;
		}
		map['rp'] = rp;
		map['deskripsi'] = deskripsi;
		map['tanggal'] = tanggal;
        map['status'] = status;

		return map;
	}

    // Extract a Note object from a Map object
	Finance.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.rp = map['rp'];
		this.deskripsi = map['deskripsi'];
		this.tanggal = map['tanggal'];
        this.status = map['status'];
	}

    final formatCurrency = new NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0);
    String getRpFormater() {
        int total = int.parse(this.rp);

        return this.formatCurrency.format(total);
    }
}