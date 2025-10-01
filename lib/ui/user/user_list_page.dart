import 'dart:async';

import 'package:flutter/material.dart';
import '../../data/model/user.dart';
import 'user_list_viewmodel.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserListViewModel _viewModel = UserListViewModel();
  late StreamSubscription<List<User>> _subscription;
  List<User> _users = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _subscription = _viewModel.usersStream.listen((event) {
      setState(() {
        _users = event;
        _isLoading = false;
        _error = null;
      });
    }, onError: (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    });
    _load();
  }

  void _load() {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      _viewModel.loadUsers();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Người Dùng'),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      backgroundColor: const Color(0xFF0A0A0A),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _buildError();
    }
    if (_users.isEmpty) {
      return _buildEmpty();
    }
    return ListView.separated(
      itemCount: _users.length,
      separatorBuilder: (_, __) => const Divider(color: Color(0xFF2A2A2A), height: 1),
      itemBuilder: (context, index) => _buildUserRow(_users[index]),
    );
  }

  Widget _buildError() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
              const SizedBox(height: 12),
              Text('Lỗi tải dữ liệu:\n${_error ?? ''}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _load, child: const Text('Thử lại')),
            ],
          ),
        ),
      );

  Widget _buildEmpty() => const Center(
        child: Text('Không có người dùng', style: TextStyle(color: Colors.white70)),
      );

  Widget _buildUserRow(User user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF6366F1),
        child: Text(
          (user.username.isNotEmpty ? user.username[0] : '?').toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text('Username: ${user.username}', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fullname: ${user.fullName}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
            Text('Email: ${user.email}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {},
    );
  }
}

