unit FCible;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  UFonctionnelle;

type
  TForm3 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
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
    genererEcran(Form3.Image1);
    afficherSolutions(Form3.Image1,1);
end;

procedure TForm3.Image1Click(Sender: TObject);
var
  pointeurSouris : tPoint;
  posLig,posCol: integer;

begin
      (*posCol:=0;posLig:=0;
      pointeurSouris := ScreenToClient(Mouse.CursorPos); // Obtention de la position de la souris dans la fenêtre Form1
      ObtenirCoordTableau(pointeurSouris.x,pointeurSouris.y,posCol,posLig);
      verifierCase(0,posCol,posLig); *)
end;

end.
