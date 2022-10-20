import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/sale/models/line_data.dart';

class NewLinesListContainer extends StatefulWidget {
  const NewLinesListContainer({Key? key, required this.lines})
      : super(key: key);

  final List<LineData> lines;

  @override
  State<NewLinesListContainer> createState() => _NewLinesListContainerState();
}

class _NewLinesListContainerState extends State<NewLinesListContainer> {
  Future<bool> promptUser(DismissDirection direction, LineData line) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(translate("line.deleteAlert")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  widget.lines.remove(line);
                  // Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text(translate("cancel")),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.lines.length,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(widget.lines[index]),
              confirmDismiss: (direction) =>
                  promptUser(direction, widget.lines[index]),
              child: lineWidget(context, widget.lines[index]),
            ));
  }

  Widget lineWidget(BuildContext context, LineData saleOrderLineData) {
    return Card(
        child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          "assets/images/product.png",
          height: 70,
          width: 70,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(saleOrderLineData.name,
          style: Theme.of(context).textTheme.headline1),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            saleOrderLineData.product.name,
          ),
        ],
      ),
    ));
  }
}
