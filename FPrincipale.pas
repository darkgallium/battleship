unit FPrincipale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  FSolution, UFonctionnelle, FCible ;

type
  TForm2 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer2: TTimer;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    TitreEtat: TLabel;
    DescrEtat: TLabel;
    Timer3: TTimer;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;



implementation

{$R *.dfm}


procedure TForm2.FormCreate(Sender: TObject);
begin
      chrono:=0;
      jeuEnPause:=true;
      tour:=0;
      etat:=0;
      initialiserSolutions(1);initialiserSolutions(2);
      initialiserCible(1);initialiserCible(2);
      Form2.Label1.Caption:='Score de '+idVersNomJoueur(1)+' :';
      Form2.Label3.Caption:='Score de '+idVersNomJoueur(2)+' :';
end;

procedure TForm2.Timer2Timer(Sender: TObject);
var valMin: string;
begin
      if (jeuEnPause=false) then
      begin
        Form2.Label6.Visible:=true;
        if (chrono=59) then
        begin
          chrono:=0;
          valMin:=Form2.Label6.Caption[1]+Form2.Label6.Caption[2];
          if (strtoint(valMin)+1<10) then Form2.Label6.Caption:='0'+inttostr(strtoint(valMin)+1)+':0'+inttostr(chrono)
          else Form2.Label6.Caption:=inttostr(strtoint(valMin)+1)+':0'+inttostr(chrono);
        end
        else
        begin
          chrono:=chrono+1;
          valMin:=Form2.Label6.Caption[1]+Form2.Label6.Caption[2];
          if (chrono<10) then Form2.Label6.Caption:=valMin+':0'+inttostr(chrono)
          else Form2.Label6.Caption:=valMin+':'+inttostr(chrono);
        end;
      end
      else
      begin
        if (Form2.Label6.Visible=true) then Form2.Label6.Visible:=false
        else Form2.Label6.Visible:=true;
      end;


      Form2.Label8.Caption:=IntToStr(tour);
      Form2.Label2.Caption:=IntToStr(scoreJ1);
      Form2.Label4.Caption:=IntToStr(scoreJ2);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if (jeuEnPause=true) then jeuEnPause:=false
  else jeuEnPause:=true;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
var x,y: integer;
begin
// TODO vérifier que le joueur à joué !
  if (etat=0) then // 0: début du jeu
  begin
    joueurQuiJoue:=0;
    etat:=1;
    inter:=1;
  end
  else if (inter=1) then
  begin
    Form1.Visible:=False;
    Form3.Visible:=False;
    compteurActions:=0;

    joueurQuiJoue:=1-(joueurQuiJoue+1 mod 2)+1;

    if (joueurQuiJoue=1) then
    begin
      afficherEtat('C''est au tour de '+idVersNomJoueur(joueurQuiJoue)+' de jouer','Le joueur '+idVersNomJoueur(1-(joueurQuiJoue+1 mod 2)+1)+' ne doit pas regarder ce qui va suivre !');
      tour:=tour+1;
      inter:=0;
    end
    else
    begin
      afficherEtat('C''est au tour de '+idVersNomJoueur(joueurQuiJoue)+' de jouer','Le joueur '+idVersNomJoueur(1-(joueurQuiJoue+1 mod 2)+1)+' ne doit pas regarder ce qui va suivre !');
      inter:=0;
    end;
  end
  else if (etat=1) then
  begin
      jeuEnPause:=false;

      Form3.Visible:=True;
      Form1.Visible:=True;

      afficherEtat(idVersNomJoueur(joueurQuiJoue)+', à vous de jouer!','Selectionnez une case que vous voulez toucher dans la grille adverse!');
  end;

end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  //Label9.Caption:='DEBUG : situationOrd:'+IntToStr(98)+' xTouche:'+IntToStr(xTouc1)+' yTouche:'+IntToStr(yTouc1)+' dirTouc:'+IntToStr(dirTouc)+' xTst: '+IntToStr(xTest)+' yTst:'+IntToStr(yTest);
end;

end.
