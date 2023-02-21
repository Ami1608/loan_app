import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_app/domain/entities/loan_data_entity.dart';

class LoanDataItem extends StatelessWidget {
  final LoanDataEntity loanDataEntity;

  const LoanDataItem({super.key, required this.loanDataEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      color: Colors.lightBlue[100],
      margin: EdgeInsets.symmetric(horizontal: 14),
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(loanDataEntity.logo!),
          SizedBox(
            height: 4,
          ),
          Text(loanDataEntity.amount.toString()),
          Divider(
            height: 1,
            color: Colors.lightBlue[400],
          ),
          Row(
            children: [
              Text(loanDataEntity.financialStatus!),
              SizedBox(
                width: 4,
              ),
              Text(loanDataEntity.financialValue!.toString()),
            ],
          )
        ],
      ),
    );
  }
}
