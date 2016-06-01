unit UFonctionnelle;

interface
uses Graphics,ExtCtrls;

const
  lettres: array[0..10] of string =('0','A','B','C','D','E','F','G','H','I','J');
  couleursCasesSolution: array[0..4] of TColor = (clBlack,clRed,clGreen,clBlue,clYellow);
  couleursCasesCible: array[0..2] of TColor = (clBlack,clWhite,clSkyBlue);
  compteurTouchesJ1: array[1..4] of Integer = (0,0,0,0);
  compteurTouchesJ2: array[1..4] of Integer = (0,0,0,0);
  navires: array[1..4] of string = ('Porte-Avions','Croiseur','Sous-Marin','Torpilleur');

var
  plateauJ1,plateauJ2 : array [1..10,1..10] of integer;
  resolutionJ1,resolutionJ2 : array [1..10,1..10] of integer;
  joueurQuiJoue,chrono,tour,etat,scoreJ1,scoreJ2,jeuConsulte,inter,compteurActions: integer;
  //xTouc1,yTouc1,xTouc2,yTouc2: integer;
  //xTest,yTest: integer;
  //dirTouc: integer =0;
  //dirTest: integer =0;
  //nbTouchers: integer =0;
  //nbCasesTest: integer =0;
  jeuEnPause: boolean;


// Procedures et fonctions concernant l'affichage graphique

procedure afficherSolutions(Image: TImage;idJr: integer);
procedure afficherPlateau(Image: TImage;idJr: integer);
//procedure afficherTouche(idJr,posCol,posLig: integer);
//procedure afficherDansEau(idJr,posCol,posLig: integer);
procedure noircirEcran(Image: TImage);
procedure genererEcran(Image: TImage);
procedure ObtenirCoordTableau(var xSouris,ySouris,posCol,posLig: integer);
procedure afficherEtat(titre,description: string);

// Procedures et fonctions concernant l'algorithme de jeu

function idVersNomJoueur(idJr:integer): string;
procedure initialiserSolutions(idJr: integer);
procedure initialiserCible(idJr: integer);
procedure verifierEnVue(idJr,posCol,posLig: integer);
procedure verifierCoule(idJr,posCol,posLig: integer);
procedure verifierCase(idJr,posCol,posLig: integer);

// Functions Outils
function estDansTableau(i,j:integer): boolean; // Vérifie les dépassements de Tableaux




implementation

uses
  Windows, Messages, SysUtils, Classes,
  FPrincipale,FSolution,FCible;


function estDansTableau(i,j:integer): boolean;
begin
 if (i<1) or (i>10) then Result:=False
 else if (j<1) or (j>10) then Result:=False
 else Result:=True;

end;

function idVersNomJoueur(idJr:integer): string;
begin
  if (idJr=1) then Result:='Florian'
  else Result:='Maman';

end;

procedure afficherEtat(titre,description: string);
begin
  Form2.TitreEtat.Caption:=titre;
  Form2.DescrEtat.Caption:=description;

end;


procedure verifierCoule(idJr,posCol,posLig: integer);
var i,j,n: integer;
begin
n:=0;
  if (idJr=1) then
  begin
      n:=resolutionJ2[posCol,posLig];
      i:=compteurTouchesJ1[n];
      i:=i+1;
      if (compteurTouchesJ1[n]>=6-resolutionJ2[posCol,posLig]) then afficherEtat('Félicitations !','Vous avez coulé un navire adverse !')
      else afficherEtat('Touché !','Votre coup à touché un navire adverse !');
  end
  else
  begin
    n:=resolutionJ1[posCol,posLig];
    i:=compteurTouchesJ2[n];
    i:=i+1;
    compteurTouchesJ2[n]:=i;
      if (compteurTouchesJ2[n]>=6-resolutionJ1[posCol,posLig]) then afficherEtat('Félicitations !','Vous avez coulé un navire adverse !')
      else afficherEtat('Touché !','Votre coup à touché un navire adverse !');

  end;

end;




procedure verifierEnVue(idJr,posCol,posLig: integer);
var i,j,n: integer;
begin
n:=0;

  if (idJr=1) then
  begin

    for j:=posLig-1 to posLig+1 do
    for i:=posCol-1 to posCol+1 do
    begin
      if estDansTableau(i,j) then
      if resolutionJ2[i,j] <> 0 then n:=n+1;
    end;

    if n>0 then afficherEtat('En Vue !','Votre coup était proche d''un navire adverse')
    else afficherEtat('Dans l''eau !','Votre coup a raté la cible...');

  end
  else
  begin

    for j:=posLig-1 to posLig+1 do
    for i:=posCol-1 to posCol+1 do
    begin
      if estDansTableau(i,j) then
      if resolutionJ1[i,j] <> 0 then n:=n+1;
    end;

    if n>0 then afficherEtat('En Vue !','Votre coup était proche d''un navire adverse')
    else afficherEtat('Dans l''eau !','Votre coup a raté la cible...');

  end

end;


procedure verifierCase(idJr,posCol,posLig: integer);
var i,j: integer;
    n: integer;
begin

  if (idJr=1) then
  begin

  if (resolutionJ2[posCol,posLig] in [1..4]) then  // si touché
   begin
    plateauJ1[posCol,posLig]:=1;
    scoreJ1:=scoreJ1+250*resolutionJ2[posCol,posLig];
    verifierCoule(1,posCol,posLig);
   end
   else
   begin
    plateauJ1[posCol,posLig]:=2;
    verifierEnVue(1,posCol,posLig);
   end;

  end
  else
  begin

   if (resolutionJ1[posCol,posLig] in [1..4]) then  // si touché
   begin
    plateauJ2[posCol,posLig]:=1;
    scoreJ2:=scoreJ2+250*resolutionJ1[posCol,posLig];
    verifierCoule(2,posCol,posLig);
   end
   else
   begin
    plateauJ2[posCol,posLig]:=2;
    verifierEnVue(2,posCol,posLig);
   end;

  end;
  inter:=1;

end;

procedure afficherSolutions(Image: TImage;
                            idJr: integer);

var k,l: integer; // Compteurs de boucles locaux
    caseColoree: tRect;
begin
  if (idJr=1) then // Joueur 1
  begin
    for l:=1 to 10 do
    begin
      for k:=1 to 10 do
      begin
        caseColoree.Left:=21+(k-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+k*40;
        caseColoree.Top:=21+(l-1)*40;
        caseColoree.Bottom:=20+l*40;

        Image.Canvas.Brush.Color:= couleursCasesSolution[resolutionJ1[k,l]];
        Image.Canvas.Brush.Style:= bsSolid;
        //Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;

  end
  else
  begin
    for l:=1 to 10 do
    begin
      for k:=1 to 10 do
      begin
        caseColoree.Left:=21+(k-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+k*40;
        caseColoree.Top:=21+(l-1)*40;
        caseColoree.Bottom:=20+l*40;

        Image.Canvas.Brush.Color:= couleursCasesSolution[resolutionJ2[k,l]];
        Image.Canvas.Brush.Style:= bsSolid;
        //Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;
  end;

end;

procedure afficherPlateau(Image: TImage;idJr: integer);

var k,l: integer; // Compteurs de boucles locaux
    caseColoree: tRect;
begin
  if (idJr=1) then // Joueur 1
  begin
    for l:=1 to 10 do
    begin
      for k:=1 to 10 do
      begin
        caseColoree.Left:=21+(k-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+k*40;
        caseColoree.Top:=21+(l-1)*40;
        caseColoree.Bottom:=20+l*40;

        Image.Canvas.Brush.Color:= couleursCasesCible[plateauJ1[k,l]];
        Image.Canvas.Brush.Style:= bsSolid;
        //Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;

  end
  else
  begin
    for l:=1 to 10 do
    begin
      for k:=1 to 10 do
      begin
        caseColoree.Left:=21+(k-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
        caseColoree.Right:=20+k*40;
        caseColoree.Top:=21+(l-1)*40;
        caseColoree.Bottom:=20+l*40;

        Image.Canvas.Brush.Color:= couleursCasesCible[plateauJ2[k,l]];
        Image.Canvas.Brush.Style:= bsSolid;
        //Image.Canvas.Pen.Style:= psClear;
        Image.Canvas.FillRect(caseColoree);
      end;

    end;
  end;

end;


procedure noircirEcran(Image: TImage);
begin
  Image.Canvas.Pen.Color:=clBlack;
  Image.Canvas.Brush.Color:=clBlack;
  Image.Canvas.rectangle(0,0,Image.Width,Image.Height); //Arrière-plan de la fenêtre noir
end;

procedure genererEcran(Image: TImage);
(* Procedure genererEcran
   trace la grille et affiche les étiquettes de cases
   (de A à J horizontalement et de 1 à 10 verticalement) *)

var i,j: integer; // Compteurs de boucles locaux
begin
      noircirEcran(Image);
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
*)
var sens,x1,y1,tailleNavire,casesVides,i,j,k: integer;

begin
  if (idJr = 1) then
     begin // begin du selcteur de joueur
     randomize;
     for k:=0 to 3 do
     begin  // begin du for pour chaque navire
       sens := random(2);
       tailleNavire:=5-k;

       if (sens=0) then
       begin
         while (casesVides<>(tailleNavire+1)*3+3) do
         begin
           casesVides:=0;
           y1:=random(10)+1;
           x1:=random(tailleNavire+1)+1;

           for j:=y1-1 to y1+1 do
           for i:=x1-1 to x1+tailleNavire do
           begin
             if (estDansTableau(i,j)=true) then
             begin
               if resolutionJ1[i,j]=0 then casesVides:=casesVides+1
               else casesVides:=casesVides-1;
             end
             else casesVides:=casesVides+1;
           end;

         end;

         for i:=0 to tailleNavire-1 do resolutionJ1[x1+i,y1]:=k+1;

       end
       else
         begin
           while (casesVides<>(tailleNavire+1)*3+3) do
           begin
             casesVides:=0;
             y1:=random(tailleNavire+1)+1;
             x1:=random(10)+1;

             for j:=y1-1 to y1+tailleNavire do
             for i:=x1-1 to x1+1 do
             begin
               if (estDansTableau(i,j)=true) then
               begin
                 if resolutionJ1[i,j]=0 then casesVides:=casesVides+1
                 else casesVides:=casesVides-1;
               end
               else casesVides:=casesVides+1;
             end;

           end;

           for i:=0 to tailleNavire-1 do resolutionJ1[x1,y1+i]:=k+1;

         end;

       end;

     end
     else
     begin // begin du selcteur de joueur
     randomize;
     for k:=0 to 3 do
     begin  // begin du for pour chaque navire
       sens := random(2);
       tailleNavire:=5-k;

       if (sens=0) then
       begin
         while (casesVides<>(tailleNavire+1)*3+3) do
         begin
           casesVides:=0;
           y1:=random(10)+1;
           x1:=random(tailleNavire+1)+1;

           for j:=y1-1 to y1+1 do
           for i:=x1-1 to x1+tailleNavire do
           begin
             if (estDansTableau(i,j)=true) then
             begin
               if resolutionJ2[i,j]=0 then casesVides:=casesVides+1
               else casesVides:=casesVides-1;
             end
             else casesVides:=casesVides+1;
           end;

         end;

         for i:=0 to tailleNavire-1 do resolutionJ2[x1+i,y1]:=k+1;

       end
       else
         begin
           while (casesVides<>(tailleNavire+1)*3+3) do
           begin
             casesVides:=0;
             y1:=random(tailleNavire+1)+1;
             x1:=random(10)+1;

             for j:=y1-1 to y1+tailleNavire do
             for i:=x1-1 to x1+1 do
             begin
               if (estDansTableau(i,j)=true) then
               begin
                 if resolutionJ2[i,j]=0 then casesVides:=casesVides+1
                 else casesVides:=casesVides-1;
               end
               else casesVides:=casesVides+1;
             end;

           end;

           for i:=0 to tailleNavire-1 do resolutionJ2[x1,y1+i]:=k+1;

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
                plateauJ1[i,j] := 0;
              end;
          end;
     end
     else //if (idJr = 0) then
     begin
        for j:=1 to 10 do
          begin
            for i:=1 to 10 do
              begin
                plateauJ2[i,j] := 0;
              end;
          end;
     end
end;

end.
