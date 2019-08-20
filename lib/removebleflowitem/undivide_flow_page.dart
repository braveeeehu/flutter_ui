import 'package:flutter/material.dart';
import 'package:flutter_ui/removebleflowitem/undivide_flow.dart';

class UndivideFlowPage extends StatefulWidget {
  @override
  _UndivideFlowPageState createState() => _UndivideFlowPageState();
}

class _UndivideFlowPageState extends State<UndivideFlowPage> {

  List list = ['dd1','dffff','ccccccc','aaaaaaaaaaaa',
    'dd22','dffff','ccccccc','aaaaaaaaaaaa',
    'dd333','dffff', 'ccccccc','aaaaaaaaaaaa',
    'dd4444','dffff','ccccccc','aaaaaaaaaaaa',];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Flow')),
      body: Container(
        child: UndivideFlow(dataList: list,
          itemMargin: EdgeInsets.all(0),
          itemPadding: EdgeInsets.all(10),
          onDelete: (index) async {
              setState(() {
                list.removeAt(index);
              });
          },
        ),
      ),
    );
  }
}


