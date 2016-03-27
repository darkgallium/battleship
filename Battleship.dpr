program Battleship;

uses
  Forms,
  FSolution in 'FSolution.pas' {Form1},
  FPrincipale in 'FPrincipale.pas' {Form2},
  UFonctionnelle in 'UFonctionnelle.pas',
  FCible in 'FCible.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
