abstract class ArchiveEvent{}

 class ArchiveRequestEvent extends ArchiveEvent{
  int catId;

  ArchiveRequestEvent({required this.catId});
 }