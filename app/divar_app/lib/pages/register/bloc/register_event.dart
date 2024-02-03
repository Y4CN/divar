abstract class RegisterEvent{

}


class RegisterRequestEvent extends RegisterEvent{
  String userName,name,emal,pass;

  RegisterRequestEvent(this.userName,this.name,this.emal,this.pass);
}