unit FPrincipale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  FSolution, UFonctionnelle, FCible ;

type
  TForm2 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form2: TForm2;



implementation

{$R *.dfm}


procedure TForm2.FormCreate(Sender: TObject);
begin
      Form2.Image1.Canvas.Pen.Color:=clBlack;
      Form2.Image1.Canvas.Brush.Color:=clBlack;
      Form2.Image1.Canvas.rectangle(0,0,Form2.Image1.Width,Form2.Image1.Height); //Arri�re-plan de la fen�tre noir
end;

end.
