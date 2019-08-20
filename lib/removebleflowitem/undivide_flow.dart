import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

// ignore: must_be_immutable
class UndivideFlow extends StatefulWidget {
  @override
  _UndivideFlowState createState() => _UndivideFlowState();

  final GestureTapCallback onItemTap;
  final Future Function(int index) onDelete;
  final double itemHeight;
  final List dataList;
  final String jsonTextKey;
  final EdgeInsets itemMargin;
  final EdgeInsets itemPadding;

  UndivideFlow({Key key,
    @required this.dataList,
    @required this.jsonTextKey,
    this.onItemTap,
    this.onDelete,
    this.itemHeight = 50,
    this.itemMargin = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
  });
}

class _UndivideFlowState extends State<UndivideFlow> with SingleTickerProviderStateMixin{

  int selectIndex;
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
        child: Flow(delegate: UndivideFlowDelegate(margin: widget.itemMargin,height: widget.itemHeight),
          children: widget.dataList.map((item) => _buildFlowItem(index ++)).toList(),)
    );
  }


  Widget _buildFlowItem(int index){

    String str = widget.jsonTextKey == null ? widget.dataList[index] : widget.dataList[index][widget.jsonTextKey];
    return GestureDetector(
      onTap: widget.onItemTap,
      onLongPressStart: (detail){
        setState(() {
          selectIndex = index;
        });
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 0,right: 5,top: 10),
            padding: widget.itemPadding,
            child: Text(str,style: TextStyle(color: Colors.grey),),
            decoration: BoxDecoration(color: Colors.black12 ,
                borderRadius: BorderRadius.all(Radius.circular((widget.itemHeight + widget.itemPadding.bottom + widget.itemPadding.top) * 0.5))),
          ),
          Container(
            margin: EdgeInsets.only(right: 0),
            height: 20,width: 20,
            child: Offstage(offstage: index == selectIndex ? false : true,
                child: FlatButton(onPressed: (){
                  if(widget.onDelete != null) {
                    widget.onDelete(index).whenComplete((){
                      setState(() {
                        selectIndex = null;
                      });
                    });
                  }
                },
                    child: Container(
                      height: 12,width: 12,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),color: Colors.grey),
                        child: Icon(Icons.close,size: 10,color: Colors.white,),),
                    padding: EdgeInsets.all(0))),
          )
        ],
      ),
    );
  }
}


class UndivideFlowDelegate extends FlowDelegate {
  final EdgeInsets margin;
  final height;

  UndivideFlowDelegate({
    this.margin,
    this.height});
  @override
  void paintChildren(FlowPaintingContext context) {

    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(
            i,
            transform:
            Matrix4.compose(Vector.Vector3(x,y,0.0),//transform
                Vector.Quaternion(0.0,0.0,0.0,0.0),//rotation
                Vector.Vector3(1.0,1.0,1.0))//scale
        );
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;

        //绘制子widget
        context.paintChild(i,
            transform: Matrix4.translationValues(x, y, 0.0) //位移
        );
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }  }

  @override
  Size getSize(BoxConstraints constraints) {
//指定Flow的大小
    return Size(double.infinity, double.infinity);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}


