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
  joueurQuiJoue,chrono,tour,etat,scoreOrdi,scoreJoueur,situationOrdi,xToucheOrdi,yToucheOrdi: integer;
  sensTeste: integer =0;
  compteurTouche: integer =0;
  jeuEnPause,touchePress: boolean;


// Procedures et fonctions concernant l'affichage graphique

procedure afficherSolutions(Image: TImage;idJr: integer);
procedure afficherTouche(idJr,posCol,posLig: integer);
procedure afficherDansEau(idJr,posCol,posLig: integer);
procedure noircirEcran(Image: TImage);
procedure genererEcran(Image: TImage);
procedure ObtenirCoordTableau(var xSouris,ySouris,posCol,posLig: integer);
procedure afficherEtat(titre,description: string);

// Procedures et fonctions concernant l'algorithme de jeu

procedure initialiserSolutions(idJr: integer);
procedure initialiserCible(idJr: integer);
procedure trouverCase(var x,y: integer);
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

procedure afficherEtat(titre,description: string);
begin
  Form2.TitreEtat.Caption:=titre;
  Form2.DescrEtat.Caption:=description;

end;


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

  end
  else
  begin
    Image:=Form1.Image1;

    caseTouchee.Left:=21+(posCol-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
    caseTouchee.Right:=20+posCol*40;
    caseTouchee.Top:=21+(posLig-1)*40;
    caseTouchee.Bottom:=20+posLig*40;

    Image.Canvas.Brush.Color:= clGray;
    Image.Canvas.Brush.Style:= bsSolid;
    Image.Canvas.Pen.Style:= psClear;
    Image.Canvas.FillRect(caseTouchee);

  end;
end;

procedure afficherDansEau(idJr,posCol,posLig: integer);
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

    Image.Canvas.Brush.Color:= clTeal;
    Image.Canvas.Brush.Style:= bsSolid;
    Image.Canvas.Pen.Style:= psClear;
    Image.Canvas.FillRect(caseTouchee);

  end
  else
  begin
    Image:=Form1.Image1;

    caseTouchee.Left:=21+(posCol-1)*40; // Marge de 20px + 1px pour laisser la bordure visible
    caseTouchee.Right:=20+posCol*40;
    caseTouchee.Top:=21+(posLig-1)*40;
    caseTouchee.Bottom:=20+posLig*40;

    Image.Canvas.Brush.Color:= clGray;
    Image.Canvas.Brush.Style:= bsSolid;
    Image.Canvas.Pen.Style:= psClear;
    Image.Canvas.FillRect(caseTouchee);

  end;
end;


procedure verifierCoule(idJr,posCol,posLig: integer);
var i,j,n: integer;
begin
n:=0;
  if (idJr=0) then
  begin

    for j:=1 to 10 do
    for i:=1 to 10 do
    begin
      if estDansTableau(i,j) then
      if plateauJoueur[i,j] = resolutionOrdi[posCol,posLig] then n:=n+1;
    end;

    if (n>=6-resolutionOrdi[posCol,posLig]) then afficherEtat('Félicitations !','Vous avez coulé un navire adverse !')
    else afficherEtat('Touché !','Votre coup à touché un navire adverse !');

  end
  else
  begin

    for j:=1 to 10 do
    for i:=1 to 10 do
    begin
      if estDansTableau(i,j) then
      if plateauOrdi[i,j] = resolutionJoueur[posCol,posLig] then n:=n+1;
    end;

    if (n>=6-resolutionOrdi[posCol,posLig]) then
    begin
      afficherEtat('Dommage !','Votre adversaire a réussi a détruire entièrement un de vos navires !');
      situationOrdi:=0;
    end
    else
    begin
      afficherEtat('Attention !','Votre adversaire a porté un coup à votre navire !');
      compteurTouche:=compteurTouche+1;
      situationOrdi:=1;

    end;

  end;

end;




procedure verifierEnVue(idJr,posCol,posLig: integer);
var i,j,n: integer;
begin


  if (idJr=0) then
  begin

    for j:=posLig-1 to posLig+1 do
    for i:=posCol-1 to posCol+1 do
    begin
      if estDansTableau(i,j) then
      if resolutionOrdi[i,j] <> 0 then n:=n+1;
    end;

    if n>1 then afficherEtat('En Vue !','Votre coup était proche d''un navire adverse')
    else afficherEtat('Dans l''eau !','Votre coup a raté la cible...');

  end
  else
  begin

    for j:=posLig-1 to posLig+1 do
    for i:=posCol-1 to posCol+1 do
    begin
      if estDansTableau(i,j) then
      if resolutionJoueur[i,j] <> 0 then n:=n+1;
    end;

    if n>1 then
    begin
      afficherEtat('Prudence !','Le coup de votre adversaire était proche d''un de vos navires');
      situationOrdi:=3;
      yToucheOrdi:=posLig;
      xToucheOrdi:=posCol;
    end
    else
    begin
      afficherEtat('Ouf !','Votre adversaire a raté la cible...');
      situationOrdi:=0;
    end;

  end;

end;

procedure trouverCase(var x,y: integer);
begin
//randomize;

  if (tour=1) or (situationOrdi=0) then // si premier tour ou coulé ou dans l'eau
  begin
    x:=random(10)+1;
    y:=random(10)+1;
  end

  else if (situationOrdi=1) then // si navire touché ou proche, trouver sens
  begin
    if (compteurTouche=1) then
    begin
      while (estDansTableau(x,y)=false) do
      begin
        sensTeste:=sensTeste+1;

        case sensTeste of
          1: begin
		          y:=yToucheOrdi-1;
		          x:=xToucheOrdi;
		      end;
		      2: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi+1;
		      end;
		      3: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi-1;
		      end;
		      4: begin
		          y:=yToucheOrdi+1;
		          x:=xToucheOrdi;
		      end;
		      else situationOrdi:=0;
		    end;

      end;
    end
    else
    begin
    while (estDansTableau(x,y)=false) do
      begin
      case sensTeste of
          1: begin
		          y:=yToucheOrdi-1;
		          x:=xToucheOrdi;
		      end;
		      2: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi+1;
		      end;
		      3: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi-1;
		      end;
		      4: begin
		          y:=yToucheOrdi+1;
		          x:=xToucheOrdi;
		      end;
		      else situationOrdi:=0;
		    end;
    end;
    end;
  end

  else if (situationOrdi=3) then
  begin
  sensTeste:=0;
  while (estDansTableau(x,y)=false) do
      begin
        sensTeste:=sensTeste+1;

        case sensTeste of
          1: begin
		          y:=yToucheOrdi-1;
		          x:=xToucheOrdi;
		      end;
		      2: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi+1;
		      end;
		      3: begin
		          y:=yToucheOrdi;
		          x:=xToucheOrdi-1;
		      end;
		      4: begin
		          y:=yToucheOrdi+1;
		          x:=xToucheOrdi;
		      end;
		      else situationOrdi:=0;
		    end;

      end;

  end;

  verifierCase(1,x,y);

end;

procedure verifierCase(idJr,posCol,posLig: integer);
var i,j: integer;
    n: integer;
begin

  if (idJr=0) then
  begin

  if (resolutionOrdi[posCol,posLig] in [1..4]) then  // si touché
   begin
    afficherTouche(0,posCol,posLig);
    scoreJoueur:=scoreOrdi-250*(1-resolutionOrdi[posCol,posLig])+1000;
    plateauJoueur[posCol,posLig]:=resolutionOrdi[posCol,posLig];
    verifierCoule(0,posCol,posLig);
   end
   else
   begin
    verifierEnVue(0,posCol,posLig);
    afficherDansEau(0,posCol,posLig);
   end;

    etat:=1;

  end
  else
  begin
  n:=0;


   if (resolutionJoueur[posCol,posLig] in [1..4]) then  // si touché
   begin
    afficherTouche(1,posCol,posLig);
    scoreOrdi:=scoreOrdi-250*(1-resolutionJoueur[posCol,posLig])+1000;
    plateauOrdi[posCol,posLig]:=resolutionJoueur[posCol,posLig];
    verifierCoule(1,posCol,posLig);
    yToucheOrdi:=posLig;
   xToucheOrdi:=posCol;
   end
   else
   begin
    afficherDansEau(1,posCol,posLig);
    verifierEnVue(1,posCol,posLig);
   end;

   etat:=2;

  end;

end;

procedure afficherSolutions(Image: TImage;
                            idJr: integer);

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
               if resolutionOrdi[i,j]=0 then casesVides:=casesVides+1
               else casesVides:=casesVides-1;
             end
             else casesVides:=casesVides+1;
           end;

         end;

         for i:=0 to tailleNavire-1 do resolutionOrdi[x1+i,y1]:=k+1;

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
                 if resolutionOrdi[i,j]=0 then casesVides:=casesVides+1
                 else casesVides:=casesVides-1;
               end
               else casesVides:=casesVides+1;
             end;

           end;

           for i:=0 to tailleNavire-1 do resolutionOrdi[x1,y1+i]:=k+1;

         end;

       end;

     end
     else if (idJr = 0) then  // Joueur 0: Joueur Réel
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
               if resolutionJoueur[i,j]=0 then casesVides:=casesVides+1
               else casesVides:=casesVides-1;
             end
             else casesVides:=casesVides+1;
           end;

         end;

         for i:=0 to tailleNavire-1 do resolutionJoueur[x1+i,y1]:=k+1;

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
                 if resolutionJoueur[i,j]=0 then casesVides:=casesVides+1
                 else casesVides:=casesVides-1;
               end
               else casesVides:=casesVides+1;
             end;

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
