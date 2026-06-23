import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  final VoidCallback onRefresh;

  const PostDetailScreen({
    super.key,
    required this.post,
    required this.onRefresh,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final ApiService _apiService = ApiService();
  late Post _post;
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _loadComments();
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final comments = await _apiService.fetchCommentsForPost(_post.id!);
      setState(() {
        _comments = comments;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _patchPost() async {
    if (_isUpdating) return;
    setState(() => _isUpdating = true);
    final patched = Post(
      userId: _post.userId,
      id: _post.id,
      title: '${_post.title} (patched)',
      body: _post.body,
    );

    try {
      final updatedPost = await _apiService.patchPost(patched);
      setState(() {
        _post = updatedPost;
      });
      widget.onRefresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post patched successfully.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Patch failed: $error')));
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _showUpdatePostDialog() async {
    final titleController = TextEditingController(text: _post.title);
    final bodyController = TextEditingController(text: _post.body);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                minLines: 2,
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  return;
                }
                Navigator.of(context).pop(true);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    final updatedPost = Post(
      userId: _post.userId,
      id: _post.id,
      title: titleController.text.trim(),
      body: bodyController.text.trim(),
    );

    await _updatePost(updatedPost);
  }

  Future<void> _updatePost(Post updatedPost) async {
    if (_isUpdating) return;
    setState(() {
      _isUpdating = true;
      _errorMessage = null;
    });

    try {
      final returnedPost = await _apiService.updatePost(updatedPost);
      setState(() {
        _post = returnedPost;
      });
      widget.onRefresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post updated successfully.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update failed: $error')));
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _deletePost() async {
    if (_post.id == null || _isUpdating) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    setState(() => _isUpdating = true);
    try {
      await _apiService.deletePost(_post.id!);
      widget.onRefresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post deleted successfully.')),
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Delete failed: $error')));
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _refreshComments() async {
    await _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post details'),
        actions: [
          IconButton(
            onPressed: _refreshComments,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh comments',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(_post.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text('Body', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(_post.body, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Patch Title'),
                  onPressed: _isUpdating ? null : _patchPost,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Update Post'),
                  onPressed: _isUpdating ? null : _showUpdatePostDialog,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete Post'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: _isUpdating ? null : _deletePost,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reload comments'),
                  onPressed: _isLoading ? null : _refreshComments,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Comments', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(child: _buildCommentsView()),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsView() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadComments,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_comments.isEmpty) {
      return const Center(child: Text('No comments found for this post.'));
    }

    return ListView.separated(
      itemCount: _comments.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final comment = _comments[index];
        return ListTile(
          title: Text(comment.name),
          subtitle: Text(comment.body),
          trailing: Text(comment.email),
        );
      },
    );
  }
}
