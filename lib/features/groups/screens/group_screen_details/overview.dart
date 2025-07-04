import 'package:flutter/material.dart';
import 'package:hui_application/core/utils/date_time_extension.dart';
import 'package:hui_application/core/utils/num_extension.dart';
import 'package:hui_application/features/groups/models/group.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';
import 'package:hui_application/widgets/custom_chip.dart';

class GroupScreenOverview extends StatelessWidget {
  final Group group;

  const GroupScreenOverview({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    List<ListTile> items = [
      ListTile(
        title: Text(
          '${S.of(context)?.open_date ?? 'Open date'}: ${group.startDate != null ? group.startDate?.format('dd/MM/yyyy') : 'Chưa xác định'}',
        ),
      ),
      ListTile(
        title: Text(
          '${S.of(context)?.amount_per_cycle ?? 'Amount per cycle'}:',
        ),
        trailing: CustomChip(
          label: group.amountPerCycle.toVNDWithSymbol,
          labelColor: Color(0xFFBC4602),
          backgroundColor: Color(0xFFFEE8DB),
        ),
      ),
      ListTile(title: Text('Item 3')),
      ListTile(
        title: Text('${S.of(context)?.total_cycles ?? 'Total cycles'}:'),
        trailing: CustomChip(
          label: '${group.cycleDuration}/${group.totalCycles}',
        ),
      ),
      ListTile(
        title: Text('${S.of(context)?.time_opened ?? 'Time opened'}:'),
        trailing:
            group.status == GroupStatus.inactive
                ? CustomChip(
                  label: 'Chưa bắt đầu',
                  labelColor: Color(0xFFBC4602),
                  backgroundColor: Color(0xFFFEE8DB),
                )
                : CustomChip(
                  label:
                      group.startDate?.format('dd/MM/yyyy') ?? 'Chưa xác định',
                ),
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return items[index];
                },
                separatorBuilder:
                    (_, __) => Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                itemCount: 5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Add more widgets here to display the overview details
        // For example, you can add charts, statistics, etc.
      ],
    );
  }
}
