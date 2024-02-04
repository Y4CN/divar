abstract class SingleEvent{

}


class SingleRequestEvent extends SingleEvent{
  int itemId;

  SingleRequestEvent(this.itemId);
}