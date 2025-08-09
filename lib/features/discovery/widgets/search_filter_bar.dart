import 'package:flutter/material.dart';

class SearchFilterBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(String) onLocationChanged;
  final Function(double) onAmountChanged;
  final Function(int) onDurationChanged;

  const SearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onLocationChanged,
    required this.onAmountChanged,
    required this.onDurationChanged,
  });

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  final List<String> _locations = [
    'Tất cả',
    'Hà Nội',
    'TP.HCM',
    'Đà Nẵng',
    'Hải Phòng',
    'Cần Thơ',
  ];

  final List<double> _amounts = [
    0,
    500000,
    1000000,
    2000000,
    5000000,
    10000000,
  ];

  final List<int> _durations = [0, 3, 6, 8, 12, 18, 24];

  String _selectedLocation = 'Tất cả';
  double _selectedAmount = 0;
  int _selectedDuration = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: widget.onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm hụi...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(
                  _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _showFilters = !_showFilters;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHigh,
            ),
          ),

          // Filters
          if (_showFilters) ...[
            const SizedBox(height: 16),
            _buildFilters(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildFilters(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bộ lọc',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Location Filter
        Text(
          'Khu vực',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              _locations.map((location) {
                final isSelected = _selectedLocation == location;
                return FilterChip(
                  label: Text(location),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedLocation = location;
                    });
                    widget.onLocationChanged(
                      location == 'Tất cả' ? '' : location,
                    );
                  },
                );
              }).toList(),
        ),

        const SizedBox(height: 16),

        // Amount Filter
        Text(
          'Số tiền tối đa',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              _amounts.map((amount) {
                final isSelected = _selectedAmount == amount;
                final label =
                    amount == 0
                        ? 'Tất cả'
                        : '${(amount / 1000000).toStringAsFixed(0)}M';
                return FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedAmount = amount;
                    });
                    widget.onAmountChanged(amount);
                  },
                );
              }).toList(),
        ),

        const SizedBox(height: 16),

        // Duration Filter
        Text(
          'Thời gian tối đa (tháng)',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              _durations.map((duration) {
                final isSelected = _selectedDuration == duration;
                final label = duration == 0 ? 'Tất cả' : duration.toString();
                return FilterChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedDuration = duration;
                    });
                    widget.onDurationChanged(duration);
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
