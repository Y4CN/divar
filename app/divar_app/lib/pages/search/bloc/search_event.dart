abstract class SearchEvent{}


class SearchRequestEvent extends SearchEvent{
  String txt;

  SearchRequestEvent(this.txt);
}