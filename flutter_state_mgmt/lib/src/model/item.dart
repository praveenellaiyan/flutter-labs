import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String item;
  @HiveField(1)
  final bool isCompleted;

  const Item(this.item, this.isCompleted);

  factory Item.fromOld(Item oldItem, {item, isCompleted}) {
    String lclItem = item ?? oldItem.item;
    bool lclIsCompleted = isCompleted ?? oldItem.isCompleted;
    return Item(lclItem, lclIsCompleted);
  }
}
