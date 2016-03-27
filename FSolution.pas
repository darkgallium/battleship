unit FSolution;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  UFonctionnelle;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image1Click(Sender: TObject);
var
  pointeurSouris : tPoint;
  posLig,posCol: integer;

begin
      posCol:=0;posLig:=0;
      pointeurSouris := ScreenToClient(Mouse.CursorPos); // Obtention de la position de la souris dans la fenêtre Form1
      ObtenirCoordTableau(pointeurSouris.x,pointeurSouris.y,posCol,posLig);

      if ( (posCol<>0) and (posLig<>0) and (resolutionJoueur[posCol,posLig]<>0) ) then Form1.Caption := lettres[posCol]+IntToStr(posLig)+': '+navires[resolutionJoueur[posCol,posLig]]
      else Form1.Caption := 'Votre grille de jeu';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
      genererEcran(Form1.Image1);
      initialiserSolutions(0);initialiserSolutions(1);
      afficherSolutions(Form1.Image1,0);
end;

procedure TForm1.Image1DblClick(Sender: TObject);
begin
     //genererEcran();


end;

end.


