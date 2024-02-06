import 'package:aio_mobile/widgets/body.dart';
import 'package:flutter/material.dart';

import '../models/function_model.dart';
import '../widgets/header.dart';
import '../widgets/input_number.dart';
import '../widgets/result.dart';
import '../widgets/v_space.dart';

class TipFunc extends StatefulWidget {
  const TipFunc({
    super.key,
    required this.item,
  });

  final FunctionModel item;

  @override
  State<TipFunc> createState() => _TipFuncState();
}

class _TipFuncState extends State<TipFunc> {
  String bill = '';
  String people = '';
  String tip = '15.0';
  double totalTip = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(item: widget.item),
              Body(
                children: [
                  InputNumber(
                    title: 'Bill:',
                    placeholder: 'Total bill',
                    onChanged: (value) {
                      setState(() {
                        bill = value;
                      });
                    },
                  ),
                  const VSpace(),
                  InputNumber(
                    title: 'People:',
                    placeholder: 'Number of people',
                    onChanged: (value) {
                      setState(() {
                        people = value;
                      });
                    },
                  ),
                  const VSpace(),
                  InputNumber(
                    title: 'Tip (%):',
                    placeholder: 'Tip percent',
                    defaultValue: tip,
                    onChanged: (value) {
                      setState(() {
                        tip = value;
                      });
                    },
                  ),
                  const VSpace(),
                  Result(title: 'Total bill', value: getTotalBill()),
                  const VSpace(),
                  Result(title: 'Cost per person', value: getCostPerPerson()),
                  const VSpace(),
                  Result(title: 'Total tip', value: getTotalTip()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTotalBill() {
    try {
      double billAmount = double.parse(bill);
      double totalBill = billAmount + getTotalTipAmount();
      return totalBill.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  String getCostPerPerson() {
    try {
      double billAmount = double.parse(bill);
      double numberOfPeople = double.parse(people);

      if (numberOfPeople == 0) {
        return '0.00';
      }

      double totalBill = billAmount + getTotalTipAmount();
      double costPerPerson = totalBill / numberOfPeople;
      return costPerPerson.toStringAsFixed(2);
    } catch (e) {
      return '';
    }
  }

  String getTotalTip() {
    double totalTipAmount = getTotalTipAmount();
    return totalTipAmount.toStringAsFixed(2);
  }

  double getTotalTipAmount() {
    try {
      double billAmount = double.parse(bill);
      double tipPercentage = double.parse(tip);
      return billAmount * (tipPercentage / 100.0);
    } catch (e) {
      return 0.0;
    }
  }
}
