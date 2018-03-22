class UnitDataList {
  List<UnitData> data;

  UnitDataList.fromJson(Map<String, dynamic> json):
      data = (json["data"] as List)
          ?.map((data) => data == null ? null : new UnitData.fromJson(data))
          ?.toList();
}

class UnitData {
  final String masteraccount;
  final String fundname;
  final String scheme;
  final double amountpaid;
  final double totalunit;
  final String umstid;
  final String account;
  final String currency;
  final double nav;
  final String navDate;

  UnitData.fromJson(Map<String, dynamic> json) :
        masteraccount = json["masteraccount"],
        fundname = json["fundname"],
        scheme = json["scheme"],
        amountpaid = json["amountpaid"],
        totalunit = json["totalunit"],
        umstid = json["umstid"],
        account = json["account"],
        currency = json["currency"],
        nav = json["nav"],
        navDate = json["navDate"]
  ;
}
