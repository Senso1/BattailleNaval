program BattailleNaval;

uses crt;

type LaMap = array [1..10, 1..10] of Char;

var i, a, Remplisage :integer;

function RecuperationNomJoueur(NumJoueur:integer):string;

var NomJoueur :string;
begin
    if NumJoueur=1 then
    begin
        writeln('Nom du joueur ',NumJoueur,',');
        readln(NomJoueur);
        writeln('Votre pseudo est ',NomJoueur,'. c''est pas ouf');
        readln;
        clrscr;
    end;

    if NumJoueur=2 then
    begin
        writeln('Quel est votre pseudo ',NumJoueur,'.');
        readln(NomJoueur);
        writeln('D''accord votre pseudo est donc ',NomJoueur,'. c''est pas ouf non plus vive l''imagination quoi... ');
        readln;
        clrscr;
    end;
    RecuperationNomJoueur:=NomJoueur;
end;

function Remp(h : char):integer;
begin
    case h of
        'A','a' : Remp:=1;
        'B','b' : Remp:=2;
        'C','c' : Remp:=3;
        'D','d' : Remp:=4;
        'E','e' : Remp:=5;
        'F','f' : Remp:=6;
        'G','g' : Remp:=7;
        'H','h' : Remp:=8;
        'I','i' : Remp:=9;
        'J','j' : Remp:=10;
    end;
end;

function Map_vide(map:LaMap; car:char):LaMap;
var i, m :integer;
begin
    for i := 1 to 10 do
    begin
        for m := 1 to 10 do
        begin
            map[i,m]:=car;
        end;            
    end;
    Map_vide:=map;        
end;

function AffichageCordination (f : integer):Char;

begin
    case f of
        1 : AffichageCordination:='A';
        2 : AffichageCordination:='B';
        3 : AffichageCordination:='C';
        4 : AffichageCordination:='D';
        5 : AffichageCordination:='E';
        6 : AffichageCordination:='F';
        7 : AffichageCordination:='G';
        8 : AffichageCordination:='H';
        9 : AffichageCordination:='I';
        10 : AffichageCordination:='J';
    end;
end;

function AffichageCordination2 (f : integer):Char;

begin
    case f of
        1 : AffichageCordination2:=' ';
        2 : AffichageCordination2:='1';
        3 : AffichageCordination2:='2';
        4 : AffichageCordination2:='3';
        5 : AffichageCordination2:='4';
        6 : AffichageCordination2:='5';
        7 : AffichageCordination2:='6';
        8 : AffichageCordination2:='7';
        9 : AffichageCordination2:='8';
        10 : AffichageCordination2:='9';
    end;
end;

function SignesMap (Map : LaMap):LaMap;

begin
    for i:=1 to 10 do
    begin
        for a:=1 to 10 do
        begin
            gotoxy(i*2,a);
            //Map [i,a]:='-';
            if Map[i,a]='-' then
                textcolor(green)
            else if Map[i,a]='X' then
                textcolor(blue)
            else if Map[i,a]='o' then
                textcolor(6)
            else
                textcolor(8);
            write (Map[i,a]);
        end;
    end;

    for i := 1 to 10 do

    begin
        Map[i,1]:=AffichageCordination(i);
        gotoxy(i*2,1);
        textcolor(2);
        write(Map[i,1]);
        Map[1,i]:=AffichageCordination2(i);
        gotoxy(1,i);
        textcolor(2);
        writeln(Map[1,i]);
    end;
SignesMap:=Map;
end;

function PositionMap(Pos1,Sor1:char; Pos2,Sor2:integer; map:LaMap; SensPositionV_H:char):LaMap;

var MapTemporaire:LaMap;
var i, s, Pos1_Deb, Sor1_Fin:integer; 

begin
    MapTemporaire:=map;
    Pos1_Deb:=Remp(Pos1);
    Sor1_Fin:=Remp(Sor1);

    if SensPositionV_H='V' then
    begin
        for i:=Pos2 to Sor2 do
        begin
            for s:=Pos1_Deb to Sor1_Fin do
            begin
                MapTemporaire[i,Pos1_Deb]:='X';
                //Pos1_Deb:=Pos1_Deb+1;
            end;
        end;
        SignesMap(MapTemporaire);
    end
    else
        if SensPositionV_H='H' then
        begin
            for i:=Pos1_Deb to Sor1_Fin do
            begin
                for s:=Pos2 to Sor2 do
                begin
                    MapTemporaire[s, Pos1_Deb]:='X';
                    //Pos1_Deb:=Pos1_Deb+1;
                end;
            end;
             SignesMap(MapTemporaire);
        end
    else 
        if SensPositionV_H=' ' then
         begin
             MapTemporaire[Pos2, Remp(Pos1)]:='*';
         end;   
    PositionMap:=MapTemporaire;
end;

function Cordinations(map:LaMap; SensPositionV_H:char; Bat:Integer):LaMap;

var Pos1,Sor1:Char;
var Pos1_Deb, Sor1_Fin, Pos2, Sor2, Placement:integer;

begin
    repeat
        pos1:=' ';
        Sor1:=' ';
        Pos2:=0;
        Sor2:=0;
        while ((Pos1_Deb<1) or (Pos1_Deb>10))And((Pos2<1) or (Pos2>10)) do
        begin
            writeln('Donner la 1er positions en commencent par la lettre de la première case.');
            readln(Pos1);
            Pos1_Deb:=Remp(pos1);
            readln(Pos2);
            Pos2:=Pos2+1;
        end;

        while ((Sor1_Fin<1) or (Sor1_Fin>10)) And ((Sor2<1) or (Sor2>10)) do
        begin
            writeln('Donner la positions de Fin du bateau en commencent par le chiffre.');
            readln(Sor1);
            Sor1_Fin:=Remp(Sor1);
            readln(Sor2);
            Sor2:=Sor2+1;
        end;

        if SensPositionV_H='V' then
        begin
            Placement:=(Sor1_Fin - Pos1_Deb)+1;
        end;

        if SensPositionV_H='H' then
        begin
            Placement:=(Sor2 - Pos2)+1;
        end;

        if (map[Pos2, Pos1_Deb]='o') or (map[Sor2, Sor1_Fin]='o') or (map[Pos2, Pos1_Deb]='X') or (map[Sor2, Sor1_Fin]='X') or (Placement>Bat) or (Placement<Bat) then
            begin
                writeln('L''emplacement selectionner manque de place ou est inexistant');
                writeln('Veuillez r''appuyer sur ENTER pour choisir un nouvelle emplacement');
            end;
            readln;

    until ((map[Pos2, Pos1_Deb]='-') and (map[Sor2, Sor1_Fin]='-') and (Placement=Bat));
        Cordinations:=PositionMap(Pos1,Sor1, Pos2,Sor2, map, SensPositionV_H);
end;

function PlacementLibre(map:LaMap; CharVide:char; BatNom:string; CasBat:integer):LaMap;
var i,m,nombrecases,caseslibre,Temporaire:integer;
    CharLibre,SensPositionV_H:char;
    MapTemporaire:LaMap;

begin
    caseslibre:=0;
    nombrecases:=1;
    Temporaire:=2;
    CharLibre:=' ';
    MapTemporaire:=map;

    SignesMap(map);
    writeln('Le',BatNom,' a ',CasBat,' cases en tout.');
    repeat
        writeln('Placez le vous Horizontalement ou Verticalement ? (H ou V)');
        readln(SensPositionV_H);
    until(SensPositionV_H='V') or (SensPositionV_H='H');

    if SensPositionV_H='V' then
    begin
        for i:=1 to 10 do
        begin
            for m:=1 to 10 do
            begin
                if MapTemporaire[i,m]=CharVide then
                    caseslibre:=caseslibre+1
                    else
                    caseslibre:=0;
                    if caseslibre=CasBat then
                    begin
                        MapTemporaire[i,m]:='-';
                        for nombrecases := 1 to CasBat do
                        begin
                        MapTemporaire[i,m]:='-';
                    end;
                    caseslibre:=0;
                end;
                
            end;
        end;
        caseslibre:=0;
    end;

    if SensPositionV_H='H' then
    begin
        for i:=1 to 10 do
        begin
             for m:=1 to 10 do
             begin
                 if MapTemporaire[m,i]=CharVide then
                    caseslibre:=caseslibre+1
                 else
                
                    caseslibre:=0;

                 if caseslibre=CasBat then 
                 begin
                     MapTemporaire[m,i]:='-';
                     Temporaire:=m+1;
                     for nombrecases:=1 to CasBat do 
                     begin
                        Temporaire:=Temporaire-1;
                        MapTemporaire[Temporaire,i]:='-';
                     end;
                     caseslibre:=0; 

                 end;
             end;
             caseslibre:=0; 
        end;
     end;
    SignesMap(MapTemporaire);
    PlacementLibre:=Cordinations(MapTemporaire, SensPositionV_H, CasBat);
end;

function initialisationMap(map:LaMap; CharVide:char; bateauNom:string; CasBat:integer):LaMap;
begin
    map:=PlacementLibre(map,CharVide,bateauNom,CasBat);

    readln;
    clrscr;
    initialisationMap:=map;
end;

function VerificationPosition(Pos1:Char; Pos2:integer; map:LaMap):LaMap;
var MapTemporaire:LaMap;
    Pos1_Deb:integer;
begin
    Pos1_Deb:=Remp(Pos1);
    MapTemporaire:=map;

    if map[Pos2, Pos1_Deb]='X' then
    begin
        if (Pos1_Deb>1) or (Pos1_Deb<10) then
        begin
            if (Pos2>1) or (Pos2<10) then
            begin
                if (map[Pos2-1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb-1]='X') or (map[Pos2, Pos1_Deb]='X') then
                    begin
                        writeln('Touche');
                    end
                else
                begin
                    writeln('Toucher..couler');
                end;    
            end
            else if Pos2=1 then
            begin
                if (map[Pos2+1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb-1]='X') or (map[Pos2, Pos1_Deb+1]='X') then
                begin
                        writeln('Toucher');
                     end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                 end
                 else if Pos2=10 then
                begin
                    if  (map[Pos2-1, Pos1_Deb]='X') or(map[Pos2, Pos1_Deb-1]='X') or (map[Pos2, Pos1_Deb+1]='X') then
                        begin
                        writeln('Toucher');
                        end
                     else
                        begin
                        writeln('Toucher...couler !');
                        end;
                end;
            end
        else if Pos1_Deb=1 then
        begin
                if (Pos2>1) or (Pos2<10) then
                begin
                     if  (map[Pos2-1, Pos1_Deb]='X') or (map[Pos2+1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb+1]='X') then
                    begin
                         writeln('Toucher')
                     end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                end
                else if Pos2=1 then
                begin
                      if (map[Pos2+1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb+1]='X') then
                        begin
                        writeln('Toucher');
                        end
                     else
                     begin
                        writeln('Toucher...couler !');
                      end;
                 end
                 else if Pos2=10 then
                begin
                      if  (map[Pos2-1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb+1]='X') then
                      begin
                        writeln('Toucher');
                        end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                end;

         end
         else if Pos1_Deb=10 then
         begin
                if (Pos2>1) or (Pos2<10) then
                begin
                     if  (map[Pos2-1, Pos1_Deb]='X') or (map[Pos2+1, Pos1_Deb]='X') or(map[Pos2, Pos1_Deb-1]='X') then
                     begin
                         writeln('Toucher');
                     end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                end
                else if Pos2=1 then
                begin
                     if  (map[Pos2+1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb-1]='X') then
                        begin
                        writeln('Toucher')
                        end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                 end
                else if Pos2=10 then
                begin
                     if  (map[Pos2-1, Pos1_Deb]='X') or (map[Pos2, Pos1_Deb-1]='X') then
                     begin
                        writeln('Toucher');
                     end
                     else
                     begin
                        writeln('Toucher...couler !');
                     end;
                end;

         end;
         MapTemporaire:=PositionMap(Pos1,' ',Pos2,0,map, ' ');
    end
    else
        begin
        writeln('Rater');
        end;
     VerificationPosition:=MapTemporaire;
end;

function tir (var map:LaMap):LaMap;
var Pos1:char;
var Pos2, Pos1_Deb:integer;
var MapTemporaire:LaMap;

begin
    while (Pos1_Deb<1) or (Pos1_Deb>10) do
    begin
    writeln('Sur quel ligne de la lettre souhaitez vous tirer ?');
    readln(Pos1);
    Pos1_Deb:=Remp(Pos1);
    end;

    while (Pos2<1) or (Pos2>10) do
    begin
    writeln('Sur quel ligne de chiffre souhaitez vous tirer ?');
    readln(Pos2);
    end;

    MapTemporaire:=VerificationPosition(Pos1, Pos2, map);
    tir:=MapTemporaire;
end;

function TirSuivant(var map:LaMap; SuiviMap:LaMap):LaMap;

var i,m:integer;
begin
    for i:=1 to 10 do
    begin
        for m:=1 to 10 do
        begin
            if map[i,m]='*' then 
                SuiviMap[i,m]:='/';
        end;
    end;
    TirSuivant:=SuiviMap;
end;

function Victoire(var map:LaMap; Abattre:integer):boolean;

var i,m,caseslibre:integer;
var bool:boolean;
begin
    bool:=false;
    caseslibre:=0;
    for i:=1 to 10 do
        begin
        for m:=1 to 10 do
            begin
            if map[i,m]='*' then
                caseslibre:=caseslibre+1;
            end;
        end;

    if caseslibre=Abattre then
        bool:=true
    else
        bool:=false;
    victoire:=bool;
end;

var nj1, nj2,croiseur, con_torp, torp, nbCasesNavires:integer;
    nom1,nom2,croiseurNom,con_TorpNom,torpNom:string;
    CharVide:char;
    map1, map2,mapSuivante1, mapSuivante2:LaMap;
    Victoire1, Victoire2:boolean;

BEGIN
    clrscr;
    CharVide:='o';
    croiseur:=4;
    con_torp:=3;
    torp:=2;
    nbCasesNavires:=17;
    i := 1;
    a := 1;
    nj1:=1;
    nj2:=2;
    croiseurNom:='Croiseur';
    con_TorpNom:='Contre-Torpilleur';
    TorpNom:='Torpilleur';
    nom1:=RecuperationNomJoueur(nj1);
    nom2:=RecuperationNomJoueur(nj2);
    //initialisation map 1
    map1:=SignesMap(map1);
    //initialisation map2
    map2:=SignesMap(map2);

    map1:=Map_vide(map1, CharVide);
    map2:=Map_vide(map2, CharVide);
    mapSuivante1:=Map_vide(mapSuivante1, CharVide);
    mapSuivante2:=Map_vide(mapSuivante2, CharVide);

    clrscr;
    writeln('Bataille naval');
    writeln('Ce joue a 2');
    readln;
    clrscr;
    nom1:=RecuperationNomJoueur(nj1);
    nom2:=RecuperationNomJoueur(nj2);

    SignesMap(map1);
    writeln('La map du joueur 1',nom1);
    writeln('Appuyez sur entrer');
    readln;
    clrscr;

    map1:=initialisationMap(map1, CharVide, con_TorpNom, con_torp);
    map1:=initialisationMap(map1, CharVide, croiseurNom, croiseur);
    map1:=initialisationMap(map1, CharVide, torpNom, torp);
    readln;
    clrscr;

    SignesMap(map2);
    writeln('La map du joueur 2',nom2);
    writeln('Appuyez sur entrer');
    readln;
    clrscr;

    map1:=initialisationMap(map1, CharVide, con_TorpNom, con_torp);
    map1:=initialisationMap(map1, CharVide, croiseurNom, croiseur);
    map1:=initialisationMap(map1, CharVide, torpNom, torp);
    readln;
    clrscr;

    writeln('Fin du placement');

    while ((Victoire1=false) and (Victoire2=false)) do
    begin
        SignesMap(mapSuivante2);
        writeln('Position de l''attack ?',nom1);
        map2:=tir(map2);
        mapSuivante2:=TirSuivant(map2, mapSuivante2);
        SignesMap(mapSuivante2);
        Victoire1:=Victoire(map2, nbCasesNavires);
        readln;
        clrscr;

        SignesMap(mapSuivante1);
        writeln('Position de l''attack ?',nom2);
        map1:=tir(map1);
        mapSuivante1:=TirSuivant(map1, mapSuivante1);
        SignesMap(mapSuivante1);
        Victoire2:=Victoire(map1, nbCasesNavires);
        readln;
        clrscr;
    end;
END.
