enum ParentAssignedTaskKind { unit, video, story }

class ParentAssignedTask {
  ParentAssignedTask({
    required this.id,
    required this.kind,
    required this.title,
    this.unitId,
    this.videoId,
    this.storyId,
    this.completed = false,
  });

  final String id;
  final ParentAssignedTaskKind kind;
  final String title;
  final String? unitId;
  final String? videoId;
  final String? storyId;
  bool completed;

  String get iconEmoji {
    switch (kind) {
      case ParentAssignedTaskKind.unit:
        return '🚀';
      case ParentAssignedTaskKind.video:
        return '🎬';
      case ParentAssignedTaskKind.story:
        return '📖';
    }
  }
}
