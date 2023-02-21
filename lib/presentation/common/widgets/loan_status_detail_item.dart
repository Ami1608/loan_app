import 'package:flutter/material.dart';
import 'package:responsive_app/domain/entities/loan_details_entity.dart';

class LoanStatusDetailItem extends StatefulWidget {
  final Data loanDataEntity;

  const LoanStatusDetailItem({Key? key, required this.loanDataEntity})
      : super(key: key);

  @override
  State<LoanStatusDetailItem> createState() => _LoanStatusDetailItemState();
}

class _LoanStatusDetailItemState extends State<LoanStatusDetailItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          loanStatus(),
          Visibility(
            visible: isExpanded,
            child: getLoanStatusData(),
          ),
        ],
      ),
    );
  }

  Widget getLoanStatusData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          widget.loanDataEntity.tradeNam!,
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Invoice Number:  ${widget.loanDataEntity.invoiceNumber}",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stage",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Loan Amount",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              width: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.loanDataEntity.currentApplicationStage!,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  widget.loanDataEntity.invoiceAmount!,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget loanStatus() {
    return Container(
      color: Colors.lightBlue[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Pending Disbursement (1)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "(Loan application completed, disbursement in process)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
                print("Expanded status: $isExpanded");
              },
              child: Icon(
                isExpanded ? Icons.minimize : Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
