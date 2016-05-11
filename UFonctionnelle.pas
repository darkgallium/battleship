unit UFonctionnelle;

interface
uses Graphics,ExtCtrls;

const
  lettres: array[0..10] of string =('0','A','B','C','D','E','F','G','H','I','J');
  couleursCases: array[0..4] of TColor = (clBlack,clRed,clGreen,clBlue,clYellow);
  navires: array[1..4] of string = ('Porte-Avions','Croiseur','Sous-Marin','Torpilleur');

var
  plateauOrdi,plateauJoueur : array [1..10,1..10] of integer;
  resolutionOrdi,resolutionJoueur : array [1..10,1..10] of integer;


// Procedures et fonctions concernant l'affichage graphique

procedure afficherSolutions(Image: TImage;idJr: integer);
procedure afficherTouche(idJr,posCol,posLig: integer);
procedure genererEcran(Image: TImage);
procedure ObtenirCoordTableau(var xSouris,ySouris,posCol,posLig: integer);

// Procedures et fonctions concernant l'algorithme de jeu

procedure initialiserSolutions(idJr: integer);
procedure verifierCase(idJr,posCol,posLig: integer);

implementation

uses
  Windows, Messages, SysUtils, Classes,
  FPrincipale,FSolution,FCible;


procedure afficherTouche(idJr,posCol,posLig: integer);
var Image: TImage;
    caseTouchee:tRect;
begin
  if (idJr=0) then
  begin
    Image:=Form3.Image1;

    caseTouchee.Left:=21+(posCol-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
    caseTouchee.Right:=20+posCol*40;
    caseTouchee.Top:=21+(posLig-1)*40;
    caseTouchee.Bottom:=20+posLig*40;

    Image.Canvas.Brush.Color:= couleursCases[resolutionOrdi[posCol,posLig]];
    Image.Canvas.Brush.Style:= bsSolid;
    Image.Canvas.Pen.Style:= psClear;
    Image.Canvas.FillRect(caseTouchee);


  end;
end;

procedure verifierCase(idJr,posCol,posLig: integer);

begin

  if (idJr=0) then
  begin
    case resolutionOrdi[posCol,posLig] of
//TODO: Vérifier si en vue, sinon dans l'eau
      1: begin
        afficherTouche(0,posCol,posLig);
      end;
     (* 2:
      3:
      4:*)
      end;
  end;
  //else ;

end;

procedure afficherSolutions(Image: TImage;
                            idJr: integer);
(* Procedure initialiserJeu
   Cette procedure affiche le jeu complet (résolu) généré préalablement d'un joueur donné *)

var i,j: integer; // Compteurs de boucles locaux
    caseColoree: tRect;
    //haut,bas,gauche,droite: integer; // Coordonnées en px de la case à mettre en surbrillance
begin
  if (idJr=0) then // Joueur 0: Joueur Réel
  begin
    for j:=1 to 10 do
    begin
      for i:=1 to 10 do
      begin
        caseColoree.Left:=21+(i-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+i*40;
        caseColoree.Top:=21+(j-1)*40;
        caseColoree.Bottom:=20+j*40;

        Image.Canvas.Brush.Color:= couleursCases[resolutionJoueur[i,j]];
        Image.Canvas.Brush.Style:= bsSolid;
        Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;

  end
  else if (idJr=1) then // Joueur 1: Ordi
  begin
    for j:=1 to 10 do
    begin
      for i:=1 to 10 do
      begin
        caseColoree.Left:=21+(i-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+i*40;
        caseColoree.Top:=21+(j-1)*40;
        caseColoree.Bottom:=20+j*40;

        Image.Canvas.Brush.Color:= couleursCases[resolutionOrdi[i,j]];
        Image.Canvas.Brush.Style:= bsSolid;
        Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;
  end;

end;



procedure genererEcran(Image: TImage);
(* Procedure genererEcran
   Cette procedure génere un fond de fenêtre bleu foncé,
   trace la grille et affiche les étiquettes de cases
   (de A à J horizontalement et de 1 à 10 verticalement) *)

var i,j: integer; // Compteurs de boucles locaux
begin
      Image.Canvas.Pen.Color:=clBlack;
      Image.Canvas.Brush.Color:=clBlack;
      Image.Canvas.rectangle(0,0,Image.Width,Image.Height); //Arrière-plan de la fenêtre noir


      Image.Canvas.Pen.Color:=clSilver;
      for i:=1 to 11 do
      begin
          // On trace un trait horizontal et vertical tous les 40px, on retranche la marge de 20px dans les deux cas
          j:=(i*40)-20;
          Image.Canvas.MoveTo(20,j) ; Image.Canvas.LineTo(Form1.ClientWidth-20,j) ;
          Image.Canvas.MoveTo(j,20) ; Image.Canvas.LineTo(j,Form1.ClientWidth-20) ;
      end;

      Image.Canvas.Font.Name := 'Arial';
      Image.Canvas.Font.Color := clSilver;
      Image.Canvas.Font.Height := 12;
      for i:=0 to 9 do
      begin
          // A partir de 37 px depuis la gauche de la fenêtre et ensuite tous les 40px, on écrit une lettre de l'alphabet
          Image.Canvas.TextOut(37+i*40,5,lettres[i+1]);

          // A partir de 35 px depuis le haut de la fenêtre et ensuite tous les 40px, on écrit un chiffre
          if (i+1)<>10 then Image.Canvas.TextOut(4,35+i*40,' '+IntToStr(i+1))
          else Image.Canvas.TextOut(4,35+i*40,IntToStr(i+1));
      end;

end;

procedure ObtenirCoordTableau(var xSouris,ySouris,posCol,posLig: integer);
begin

     if ( (xSouris>20) and (xSouris<420) and (ySouris>20) and (ySouris<420) ) then
     begin
          posCol:=((xSouris-20) div 40)+1;
          posLig:=((ySouris-20) div 40)+1;
     end
     else
     begin
          posCol:=0;
          posLig:=0;
     end;

end;

procedure initialiserSolutions(idJr: integer);
(* Procedure initialiserJeu
   Cette procedure définit aléatoirement la position des navires d'un joueur
    TODO: Réaliser l'algo aléatoire.
*)
var sens,x1,y1,tailleNavire,casesVides,i,j,k: integer;
begin
  if (idJr = 1) then //Joueur 1: Ordinateur
     begin
          (*// Définition du Porte-Avions (5 Cases)
          // Code: 1
          resolutionOrdi[2,2] := 1;
          resolutionOrdi[2,3] := 1;
          resolutionOrdi[2,4] := 1;
          resolutionOrdi[2,5] := 1;
          resolutionOrdi[2,6] := 1;

          // Définition du Croiseur (4 Cases)
          // Code: 2
          resolutionOrdi[4,1] := 2;
          resolutionOrdi[5,1] := 2;
          resolutionOrdi[6,1] := 2;
          resolutionOrdi[7,1] := 2;

          // Définition du Sous-Marin (3 Cases)
          // Code: 3
          resolutionOrdi[7,8] := 3;
          resolutionOrdi[8,8] := 3;
          resolutionOrdi[9,8] := 3;

          // Définition du Torpilleur (2 Cases)
          // Code: 4
          resolutionOrdi[8,3] := 4;
          resolutionOrdi[8,4] := 4; *)


          for k:=0 to 3 do
          begin
            randomize;
            sens := random(2);
            tailleNavire:=5-k;

            if (sens=0) then
            begin

            while (casesVides<>(tailleNavire+1)*3+3) do
            begin
              casesVides:=0;
              randomize;
              y1:=(random(5)+1)*2;
              randomize;
              x1:=random(tailleNavire+1)+1;

              for j:=y1-1 to y1+1 do
              for i:=x1-1 to x1+tailleNavire do
              if resolutionOrdi[i,j]=0 then casesVides:=casesVides+1;

             // if (resolutionOrdi[x1-1,y1]=0) and (resolutionOrdi[x1+tailleNavire,y1]=0) then casesVides:=casesVides+2;
            end;

            for i:=0 to tailleNavire-1 do resolutionOrdi[x1+i,y1]:=k+1;

            end
            else
            begin

            while (casesVides<>(tailleNavire+1)*3+3) do
            begin
              casesVides:=0;
              randomize;
              y1:=random(tailleNavire+1)+1;
              randomize;
              x1:=(random(5)+1)*2;

              for j:=y1-1 to y1+tailleNavire do
              for i:=x1-1 to x1+1 do
              if resolutionOrdi[i,j]=0 then casesVides:=casesVides+1;

              //if (resolutionOrdi[x1,y1-1]=0) and (resolutionOrdi[x1,y1+tailleNavire]=0) then casesVides:=casesVides+2;
            end;

            for i:=0 to tailleNavire-1 do resolutionOrdi[x1,y1+i]:=k+1;

            end;
        end;
     end
     else if (idJr = 0) then  // Joueur 0: Joueur Réel
     begin
         (* // Définition du Porte-Avions (5 Cases)
          // Code: 1
          resolutionJoueur[1,1] := 1;
          resolutionJoueur[2,1] := 1;
          resolutionJoueur[3,1] := 1;
          resolutionJoueur[4,1] := 1;
          resolutionJoueur[5,1] := 1;

          // Définition du Croiseur (4 Cases)
          // Code: 2
          resolutionJoueur[6,6] := 2;
          resolutionJoueur[6,5] := 2;
          resolutionJoueur[6,4] := 2;
          resolutionJoueur[6,3] := 2;

          // Définition du Sous-Marin (3 Cases)
          // Code: 3
          resolutionJoueur[7,8] := 3;
          resolutionJoueur[8,8] := 3;
          resolutionJoueur[9,8] := 3;

          // Définition du Torpilleur (2 Cases)
          // Code: 4
          resolutionJoueur[8,3] := 4;
          resolutionJoueur[8,4] := 4;*)

          for k:=0 to 3 do
          begin
            randomize;
            sens := random(2);
            tailleNavire:=5-k;

            if (sens=0) then
            begin

            while (casesVides<>(tailleNavire+1)*3+3) do
            begin
              casesVides:=0;
              randomize;
              y1:=(random(5)+1)*2;
              randomize;
              x1:=random(tailleNavire+1)+1;

              for j:=y1-1 to y1+1 do
              for i:=x1-1 to x1+tailleNavire do
              if resolutionJoueur[i,j]=0 then casesVides:=casesVides+1;

              //if (resolutionJoueur[x1-1,y1]=0) and (resolutionJoueur[x1+tailleNavire,y1]=0) then casesVides:=casesVides+2;
            end;

            for i:=0 to tailleNavire-1 do resolutionJoueur[x1+i,y1]:=k+1;

            end
            else
            begin

            while (casesVides<>(tailleNavire+1)*3+3) do
            begin
              casesVides:=0;
              randomize;
              y1:=random(tailleNavire+1)+1;
              randomize;
              x1:=(random(5)+1)*2;

              for j:=y1-1 to y1+tailleNavire do
              for i:=x1-1 to x1+1 do
              if resolutionJoueur[i,j]=0 then casesVides:=casesVides+1;

              //if (resolutionJoueur[x1,y1-1]=0) and (resolutionJoueur[x1,y1+tailleNavire]=0) then casesVides:=casesVides+2;
            end;

            for i:=0 to tailleNavire-1 do resolutionJoueur[x1,y1+i]:=k+1;

            end;
          end;

     end;

end;

procedure initialiserCible(idJr: integer);
var i,j: integer;
begin
     if (idJr = 1) then
     begin
        for j:=1 to 10 do
          begin
            for i:=1 to 10 do
              begin
                plateauOrdi[i,j] := 0;
              end;
          end;
     end
     else if (idJr = 0) then
     begin
        for j:=1 to 10 do
          begin
            for i:=1 to 10 do
              begin
                plateauJoueur[i,j] := 0;
              end;
          end;
     end
end;

end.
