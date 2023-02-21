import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_app/domain/entities/loan_data_entity.dart';
import 'package:responsive_app/domain/entities/loan_details_entity.dart';
import 'package:responsive_app/presentation/common/utils/app_constants.dart';
import 'package:responsive_app/presentation/common/widgets/loan_data_item.dart';
import 'package:responsive_app/presentation/common/widgets/loan_status_detail_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  bool _isMobile = false;
  List<LoanDataEntity> loadData = [
    LoanDataEntity(
        logo: AppConstants.OUTSTANDING_IMG,
        amount: 40000,
        financialStatus: "Outstanding",
        financialValue: 02),
    LoanDataEntity(
        logo: AppConstants.OVERDUE_IMG,
        amount: 40000,
        financialStatus: "Overdue",
        financialValue: 02),
    LoanDataEntity(
        logo: AppConstants.OUTSTANDING_IMG,
        amount: 42600,
        financialStatus: "Repaid",
        financialValue: 05),
    LoanDataEntity(
        logo: AppConstants.OUTSTANDING_IMG,
        amount: 41600,
        financialStatus: "Disbursed",
        financialValue: 01),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      _isMobile = true;
    } else {
      _isMobile = false;
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _isMobile ? _buildMobileLayout() : getContent(),
    );
  }

  Widget _buildMobileLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('This is a mobile layout.'),
          SizedBox(height: 20),
          Text('You can add more widgets here.'),
        ],
      ),
    );
  }

  Widget getContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("GSTIN:"),
                    SizedBox(
                      width: 8,
                    ),
                    Text("29ABCDE1234F3Z6",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text("State:"),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Gujarat",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              loanDetail(),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // loanStatus(),
              Expanded(child: _buildDesktopLayout())
            ],
          ),
        ),
      ),
    );
  }

  Widget loanDetail() {
    return Container(
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: loadData.length,
          itemBuilder: (BuildContext context, int index) {
            return LoanDataItem(loanDataEntity: loadData[index]);
          }),
    );
  }

  Widget _buildDesktopLayout() {
    return FutureBuilder<LoanDetailsEntity>(
        future: loadLocalRecipe(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LoanStatusDetailItem(
                        loanDataEntity: snapshot.data!.data![index]);
                  }),
            );
          }
          return CircularProgressIndicator();
        });
  }

  Future<LoanDetailsEntity> loadLocalRecipe() async {
    try {
      String response =
          await rootBundle.loadString('assets/json/loan_details.json');

      var result = json.decode(response);
      print("response : $result");
      return LoanDetailsEntity.fromJson(result);
    } catch (e) {
      print("error : $e");

      throw const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Text('Convert Error'),
        ),
      );
    }
  }
}
