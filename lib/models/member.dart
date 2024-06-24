import 'package:hive/hive.dart';

part 'member.g.dart';

@HiveType(typeId: 0)
class Member extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  double money;

//   @HiveField(2)
//  Map<String, double> owes;

  Member({
    required this.name,
    required this.money,
  });

  Member.copy(Member member) : this(name: member.name, money: member.money);
}
