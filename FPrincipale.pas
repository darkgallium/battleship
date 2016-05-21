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
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

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
      Form2.Label2.Caption:=IntToStr(scoreJoueur);
      Form2.Label4.Caption:=IntToStr(scoreOrdi);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if (jeuEnPause=true) then jeuEnPause:=false
  else jeuEnPause:=true;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
var x,y: integer;
begin
  if (tour=0) then // 0: début du jeu
  begin
    tour:=1;
    joueurQuiJoue:=0;
    jeuEnPause:=false;
    situationOrdi:=0;
    afficherEtat('A vous de commencer, Florian','Choisissez une case');
  end
  else if (etat=1) then // le joueur 0 a joué
  begin
    joueurQuiJoue:=1;
    afficherEtat('C''est a l''Ordinateur de jouer','Patientez...');
    trouverCase(x,y);
  end
  else if (etat=2) then //le joueur 1 à joué
  begin
    joueurQuiJoue:=0;
    tour:=tour+1;
    afficherEtat('A vous de jouer, Florian','Choisissez une case');
  end;
end;

end.
