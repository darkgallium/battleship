unit FCible;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  UFonctionnelle;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}


procedure TForm3.FormCreate(Sender: TObject);
begin
    //genererEcran(Form3.Image1);
    //afficherSolutions(Form3.Image1,1);
end;

procedure TForm3.Image1Click(Sender: TObject);
var
  pointeurSouris : tPoint;
  posLig,posCol: integer;

begin

      posCol:=0;posLig:=0;
      pointeurSouris := ScreenToClient(Mouse.CursorPos); // Obtention de la position de la souris dans la fenêtre Form1
      ObtenirCoordTableau(pointeurSouris.x,pointeurSouris.y,posCol,posLig);

      compteurActions:=compteurActions+1;

      if (compteurActions=1) then
      begin
        if (joueurQuiJoue=1) then
        begin
          if (plateauJ1[posCol,posLig]=0) then verifierCase(joueurQuiJoue,posCol,posLig)
          else
          begin
            afficherEtat('Vous avez déjà selectionné cette case antérieurement...','Veuillez sélectionner une autre case');
            compteurActions:=0;
          end;
        end
        else
        begin
          if (plateauJ2[posCol,posLig]=0) then verifierCase(joueurQuiJoue,posCol,posLig)
          else
          begin
            afficherEtat('Vous avez déjà selectionné cette case antérieurement...','Veuillez sélectionner une autre case');
            compteurActions:=0;
          end;
        end;
      end
      else afficherEtat('Vous avez déjà joué, J1','Veuillez à présent appuyer sur une touche')

end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
    genererEcran(Form3.Image1);
    afficherPlateau(Form3.Image1,joueurQuiJoue);
end;

end.
