unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Crt,
  LCLType, StdCtrls, Buttons,MMsystem;

type
  stab = array [1..16] of string;
  tab = array [1..11] of integer;



  { TForm3 }

  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image20: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure Image25Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public

  end;

const
  HauteurJeu =  656;
  LargeurJeu = 1048;



var
  Form3: TForm3;
  score : integer = 0;
  min : integer = 50;
  max : integer = 500;
  f : textFile;
  image: stab;
  tmp : tab;
  i_sauter, traj, i, ii : integer;
  Stmp, choix_timer : string;
  sauter: Boolean = False;
  balle: Boolean = False;
  decal1, decal2, decal3 : integer;
  Obstacle1, Obstacle2, Obstacle3, entre1, entre2, entre3, entre4, entre5: Boolean;
  tmp_score :integer = 1;
  vitesse : integer = 8;
  pause : Boolean = True;
  // ***************************
  // variable pour les têtes

  {nbrDescente, image_load, image_tete, j: integer;
  image10Traj : integer;
  nbrDescente_bool : Boolean = False;
  a : integer; // a pour 0 par defaut en tant que Integer;
  start_load: Boolean;
  choix_tete1: Boolean = True;
  descente : Boolean = True; }


  i1: integer;
  Im10 : Boolean = False;
  Im11 : Boolean = False;
  Im12 : Boolean = False;
  Im13 : Boolean = False;
  Im14 : Boolean = False;
  Im15 : Boolean = False;
  Im16 : Boolean = False;
  Im17 : Boolean = False;
  Im18 : Boolean = False;
  Im19 : Boolean = False;
  x, image_load1 , image_load2, image_load3, image_load4, image_load5, image_load6,image_load7, image_load8 , image_load9, image_load10: integer;

implementation

{$R *.lfm}

{ TForm3 }
uses
  Unit2;

function hasard(minimum:integer;maximum:integer):longInt;
var
  z: integer;
begin
  z := random(maximum - minimum);
  z:= z + minimum;
  hasard := z;
end;

function GameOver():Boolean;
begin
   pause := True;
   Form3.Timer1.Enabled := False;
   Form3.Timer2.Enabled := False;
   Form3.Image26.Visible:= True;
   Form3.BitBtn1.Visible:= True;
end;

function pointDeVie():integer;
begin
  if (Form3.Image6.Visible = True) then
  begin
       Form3.Image6.Visible := False;
  end
  else
  begin
       if (Form3.Image7.Visible = True) then
       begin
            Form3.Image7.Visible := False;
       end
       else
       begin
            if (Form3.Image8.Visible = True) then
            begin
               Form3.Image8.Visible := False;
            end
            else
            begin
              if (Form3.Image9.Visible = True) then
              begin
                Form3.Image9.Visible := False;
                GameOver();
                if (score > Form2.meilleur_score) then
                begin
                    assignFile(f, 'score.gj');
                    Rewrite(f);
                    Write(f, score);
                    closefile(f);
                end;
              end;
            end;
       end;
   end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
     Height:= HauteurJeu;
     Width:= LargeurJeu;
     Position:= poScreenCenter;
     //BorderStyle:= bsNone;
     Form3.Timer1.Enabled := False;
     Form3.Timer2.Enabled := False;
     Obstacle1 := False;
     Obstacle2 := False;
     Obstacle3 := False;
     Randomize;


     //**************************
     Form3.Image10.Visible := False;
     Form3.Image11.Visible := False;
     Form3.Image12.Visible := False;
     Form3.Image13.Visible := False;
     Form3.Image14.Visible := False;
     Form3.Image15.Visible := False;
     Form3.Image16.Visible := False;
     Form3.Image17.Visible := False;
     Form3.Image18.Visible := False;
     Form3.Image19.Visible := False;
     Form3.Image20.Visible := False;


     // **************************
     for i := 1 to 16 do
     begin
          image[i] := IntToStr(i) + '.png'
     end;
     // *************************
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
    pause := False;
    Form3.Timer1.Enabled := True;
    Form3.Timer2.Enabled := True;
    Form3.Image26.Visible:= False;
    Form3.BitBtn1.Visible:= False;
    Im10 := False;
    Im11 := False;
    Im12 := False;
    Im13 := False;
    Im14 := False;
    Im15 := False;
    Im16 := False;
    Im17 := False;
    Im18 := False;
    Im19 := False;
    Form3.Image10.Top := 0;
    Form3.Image11.Top := 0;
    Form3.Image12.Top := 0;
    Form3.Image13.Top := 0;
    Form3.Image14.Top := 0;
    Form3.Image15.Top := 0;
    Form3.Image16.Top := 0;
    Form3.Image17.Top := 0;
    Form3.Image18.Top := 0;
    Form3.Image19.Top := 0;
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: char);
begin
     if (pause = False) then
     begin

        case ord(key) of
        VK_8:begin  // touche pour sauter
             Sauter := True;
             if  Form3.Timer1.Enabled = False then
                 Form3.Timer1.Enabled := True;

        end;
        Vk_4:begin
             if (Form3.Image5.Left > 50) then
             begin
               for i:= 1 to 50 do
               begin
                    Form3.Image5.Left :=  Form3.Image5.Left - 1;
                    if (Form3.Image20.Top = 460) then
                    begin
                         Form3.Image20.Left :=  Form3.Image5.Left + 14;
                    end;
               end;
             end;
        end;
        Vk_6:begin
             if (Form3.Image5.Left < 950) then
             begin
             for i:= 1 to 50 do
             begin
                  Form3.Image5.Left :=  Form3.Image5.Left + 1;
                  if (Form3.Image20.Top = 460) then // si encore sur la position initiale
                  begin
                     Form3.Image20.Left :=  Form3.Image5.Left + 14;
                  end;
             end;
             end;
        end;
        VK_SPACE:begin  // pour tirer
             balle := True;
             PlaySound('lazer.wav',0,SND_ASYNC);
             if (Form3.Timer1.Enabled = False) then
                Form3.Timer1.Enabled := True;
         end;


      end;

     end;
end;

procedure TForm3.Image25Click(Sender: TObject);
begin
  ShowMessage('Utiliser les touches "4", "6" pour se deplacer');
  ShowMessage('Utiliser la touche "ESPACE" pour tirer');
  Form3.Timer2.Enabled := True;
  Form3.Timer1.Enabled := True;
  pause := False;
  Form3.Image25.Visible := False;
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  if (score > Form2.meilleur_score) then
  begin
      assignFile(f, 'score.gj');
      Rewrite(f);
      Write(f, score);
      closefile(f);
  end;
  Form3.Timer2.Enabled := False;
  Form3.Timer1.Enabled := False;
  pause := True;
  Form3.Image24.Visible := True;
  Form3.Hide;
  Form2.Show;
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
  if (score > Form2.meilleur_score) then
  begin
       assignFile(f, 'score.gj');
       Rewrite(f);
       Write(f, score);
       closefile(f);
  end;
  Application.Terminate;
end;

procedure TForm3.Image4Click(Sender: TObject);
begin
  if (Form3.Timer2.Enabled = True) then
  begin
       Form3.Timer2.Enabled := False;
       Form3.Timer2.Enabled := False;
       pause := True;
       Form3.Image24.Visible := True;
  end
  else
  begin
       Form3.Timer2.Enabled := True;
       Form3.Timer2.Enabled := True;
       pause := False;
       Form3.Image24.Visible := False;
  end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
     if sauter then  // pour sauter
     begin
       if (i_sauter <= 15) then
       begin
            for ii:= 1 to 8 do
                Form3.Image5.Top :=  Form3.Image5.Top - 1;
       end
       else if (i_sauter <= 30) then
       begin
            for ii:= 1 to 8 do
                Form3.Image5.Top := Form3.Image5.Top + 1;
       end
       else
       begin
            if (balle = False) then
            begin
              Form3.Timer1.Enabled:= False;
            end;
            Sauter := False;
            i_sauter := 0;
       end;
       i_sauter := i_sauter + 1;
     end;

     if balle then
     begin
          Form3.Image20.Visible := True;
          if (Form3.Image20.Top > 0) then
          begin
               if (abs(Form3.Image20.Top - (Form3.Image10.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image10.Left + 14)) then
               begin
                   PlaySound('boom.wav',0,SND_ASYNC);
                   Score := Score + 1;
                   Form3.Label2.Caption:= IntToStr(score);
                   Form3.Image10.Visible := False;
                   Form3.Image10.Top:= 0;
                   Im10 := False;
                   Form3.Image20.Visible := False;
                   Form3.Image20.Top := 460; // position initiale de depart de la balle
                   Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                   balle := False;
                   Beep;
                   if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image11.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image11.Left + 14)) then
               begin
                    PlaySound('boom.wav',0,SND_ASYNC);
                    Score := Score + 1;
                    Form3.Label2.Caption:= IntToStr(score);
                    Form3.Image11.Visible := False;
                    Form3.Image11.Top:=0;
                    Im11 := False;
                    Form3.Image20.Visible := False;
                    Form3.Image20.Top := 460; // position initiale de depart de la balle
                    Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                    balle := False;
                    if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top  - (Form3.Image12.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image12.Left + 14)) then
               begin
                    Score := Score + 1;
                    PlaySound('boom.wav',0,SND_ASYNC);
                    Form3.Label2.Caption:= IntToStr(score);
                    Form3.Image12.Visible := False;
                    Form3.Image12.Top:=0;
                    Im12 := False;
                    Form3.Image20.Visible := False;
                    Form3.Image20.Top := 460; // position initiale de depart de la balle
                    Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                    balle := False;
                    if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image13.Top + 48)) < 8 ) and (Form3.Image20.Left = (Form3.Image13.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image13.Visible := False;
                 Form3.Image13.Top:=0;
                 Im13 := False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image14.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image14.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image14.Visible := False;
                 Form3.Image14.Top := 0;
                 Im14 := False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image15.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image15.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image15.Visible := False;
                 Form3.Image15.Top:=0;
                 Im15 := False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image16.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image16.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image16.Visible := False;
                 Form3.Image16.Top:=0;
                 Im16 := False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image17.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image17.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image17.Visible := False;
                 Form3.Image17.Top := 0;
                 Im17:= False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image18.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image18.Left + 14)) then
               begin
                 Score := Score + 1;
                 PlaySound('boom.wav',0,SND_ASYNC);
                 Form3.Label2.Caption:= IntToStr(score);
                 Form3.Image18.Visible := False;
                 Form3.Image18.Top:=0;
                 Im18 := False;
                 Form3.Image20.Visible := False;
                 Form3.Image20.Top := 460; // position initiale de depart de la balle
                 Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                 balle := False;
                 if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else if (abs(Form3.Image20.Top - (Form3.Image19.Top + 48)) < 8) and (Form3.Image20.Left = (Form3.Image19.Left + 14)) then
               begin
                   Score := Score + 1;
                   PlaySound('boom.wav',0,SND_ASYNC);
                   Form3.Label2.Caption:= IntToStr(score);
                   Form3.Image19.Visible := False;
                   Form3.Image19.Top := 0;
                   Im19:= False;
                   Form3.Image20.Visible := False;
                   Form3.Image20.Top := 460; // position initiale de depart de la balle
                   Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
                   balle := False;
                   if (sauter = False) then
                      Form3.Timer1.Enabled := False;
               end
               else
               begin
                 for i:= 1 to vitesse do
                 begin
                    Form3.Image20.Top := Form3.Image20.Top - 1;
                 end;
               end;
          end
          else
          begin
               Form3.Image20.Visible := False;
               Form3.Image20.Top := 460; // position initiale de depart de la balle
               Form3.Image20.Left := Form3.Image5.Left + 14; // 14 est pour rendre au milieu du tirreur la balle
               balle := False;
               if (sauter = False) then
                      Form3.Timer1.Enabled := False;
          end;
     end;
end;

procedure TForm3.Timer2Timer(Sender: TObject);
begin

     // ******************************** OBSTACLE **********************
     //****************************************************************
    {for traj := 1 to vitesse do
    begin
      if (Form3.Image21.Left > 5) then
      begin
        Form3.Image21.Left := Form3.Image21.Left  - 1;
        if (Form3.Image21.Left + 48 = Form3.Image5.Left) and (Form3.Image5.Top - 108 > Form3.Image21.Top ) then
        begin
          ShowMessage('Voa anao zay');
        end;
        // pourque il passe par tous les points
        if (Obstacle1 = False) then
        begin
            decal1 := hasard(min, max);
        end;
        Obstacle1 := True;
      end
      else
      begin
          Obstacle1:= False;
          Form3.Image21.Left := 1048;  // Position au coin de depart
      end;
      //**********************************

      if (Form3.Image22.Left - Form3.Image21.Left = decal1) or (Obstacle2) then
      begin
        if (Form3.Image22.Left > 5) then
        begin
          Form3.Image22.Visible := True;
          Form3.Image22.Left := Form3.Image22.Left - 1;
          if (Obstacle2 = False) then
          begin
            decal2 := hasard(min, max);
          end;
          Obstacle2 := True;
        end
        else
        begin
          Obstacle2 := False;
          Form3.Image22.Left := 1048;
        end;
      end;
      // *************************************************
      if (Form3.Image23.Left - Form3.Image22.Left = decal2) or (Obstacle3) then
      begin
        if (Form3.Image23.Left > 5) then
        begin
          Form3.Image23.Visible := True;
          Form3.Image23.Left := Form3.Image23.Left - 1;
          if (Obstacle3 = False) then
          begin
            decal3 := hasard(min, max);
          end;
          Obstacle3 := True;
        end
        else
        begin
          Obstacle3 := False;
          Form3.Image23.Left := 1048;
        end;
      end;
    end;        }

    //***********************************************************
  {  if (score = 10) and (entre1) then
    begin
       Form3.Timer2.Interval:= Form3.Timer2.Interval - 200;
       vitesse := vitesse * 2;
       entre1 := False;
       max := 350;
    end
    else if (score = 20) and (entre2) then
    begin
       Form3.Timer2.Interval:= Form3.Timer2.Interval - 200;
       vitesse := vitesse * 2;
       entre2 := False;
       max := 250;
    end
    else if (score = 30) and (entre3) then
    begin
         Form3.Timer2.Interval:= Form3.Timer2.Interval - 200;
         vitesse := vitesse * 2;
         entre3 := False;
         max := 200;
    end
    else if (score = 40) and (entre4) then
    begin
       Form3.Timer2.Interval:= Form3.Timer2.Interval - 200;
       vitesse := vitesse * 2;
       entre4 := False;
       max := 150;
    end
    else if (score = 50) and (entre5) then
    begin
       Form3.Timer2.Interval:= Form3.Timer2.Interval - 199;
       vitesse := vitesse * 2;
       entre5 := False;
       max := 125;
       min := 40;
    end
    else
    begin          }
    {  if (tmp_score <> score) then
      begin
         max := 110;
         min := 5;
         vitesse := vitesse + 1;
      end;
      tmp_score := score;
    end;




    // ************************ BALLOOMMMMMMMMMMM *************************
    // *****************************************************************

    if descente then
    begin
      nbrDescente:= hasard(3, 10);
      descente := False;
      nbrdescente_bool := True;
      start_load := False;
      // fonction que j ai cree pour trouver le random entre deux nombres
    end;
    if nbrDescente_bool then
    begin
      tmp[11] := 11;
      while a < nbrDescente do
      begin
        if (start_load = False ) then
        begin
          Repeat
                image_load := hasard(1,10); // chosit la tete qui va descendre
          Until ((image_load <> tmp[1]) or (image_load <> tmp[2]) or (image_load <> tmp[3]) or (image_load <> tmp[4]) or (image_load <> tmp[5]) or (image_load <> tmp[6]) or (image_load <> tmp[7]) or (image_load <> tmp[8]) or (image_load <> tmp[9]) or (image_load <> tmp[10]) or (tmp[11]= 11));
          tmp[a+1] := image_load;
          tmp[11] := 0;
        end;
        start_load:= True;
        a := a + 1;
       end;

        // ------------------------------------------------ //
      for j:= 1 to 10 do
      begin
        image_load := 1 ;

        if (image_load = 1) then
        begin
             if choix_tete1 then
             begin
                image_tete := hasard(1,16);
                choix_tete1 := False;
             end;

             Form3.Image10.Picture.LoadFromFile(image[image_tete]);

             for image10Traj:= 1 to 2  do
             begin
                  Form3.Image10.Top := Form3.Image10.Top + 1;
             end;
        end
        else if (image_load = 1) then
        begin

        end
        else if (image_load = 2) then
        begin

        end
        else if (image_load = 3) then
        begin

        end
        else if (image_load = 4) then
        begin

        end
        else if (image_load = 5) then
        begin

        end
        else if (image_load = 6) then
        begin

        end
        else if (image_load = 7) then
        begin

        end
        else if (image_load = 8) then
        begin

        end
        else if (image_load = 9) then
        begin

        end
        else if (image_load = 10) then
        begin

        end

      end;

    end;
            }

    x := hasard(1,100);

    if (x mod 5 = 0) and (Im10 = False) then
    begin
      Im10 := True;
      image_load1:= hasard(1,16);
    end;

    if Im10 then
    begin
      Form3.Image10.Picture.LoadFromFile(image[image_load1]);
      Form3.Image10.Visible := True;
      if (Form3.Image10.Top < 475) then // position du sol
      begin
           for i1 := 1 to (vitesse)do
           begin
               Form3.Image10.Top := Form3.Image10.Top + 1;
           end;
      end
      else
      begin
        Form3.Image10.Visible := False;
        Form3.Image10.Top := 0;
        Im10 := False;

        pointDeVie();
      end;
    end;

    {Image11}
    x := hasard(1,100);

    if (x mod 4 = 0) and (Im11 = False) then
    begin
      Im11 := True;
      image_load2:= hasard(1,16);
    end;

    if Im11 then
    begin

      Form3.Image11.Picture.LoadFromFile(image[image_load2]);
      Form3.Image11.Visible := True;
      if (Form3.Image11.Top < 475) then // position du sol
      begin
           for i1 := 1 to vitesse do
           begin
               Form3.Image11.Top := Form3.Image11.Top + 1;
           end;
      end
      else
      begin
        Form3.Image11.Visible := False;
        Form3.Image11.Top := 0;
        Im11 := False;

        pointDeVie();
      end;

    end;

    {Image12}
    x := hasard(1,100);

    if (x mod 3 = 0) and (Im12 = False) then
    begin
      Im12 := True;
      image_load3:= hasard(1,16);
    end;

    if Im12 then
    begin

      Form3.Image12.Picture.LoadFromFile(image[image_load3]);
      Form3.Image12.Visible := True;
      if (Form3.Image12.Top < 475) then // position du sol
      begin
           for i1 := 1 to vitesse do
           begin
               Form3.Image12.Top := Form3.Image12.Top + 1;
           end;
      end
      else
      begin
        Form3.Image12.Visible := False;
        Form3.Image12.Top := 0;
        Im12 := False;

        pointDeVie();
      end;

    end;

    {Image13}
     x := hasard(1,400);

     if (x mod 10 = 0) and (Im13 = False) then
     begin
       Im13 := True;
       image_load4:= hasard(1,16);
     end;

     if Im13 then
     begin

       Form3.Image13.Picture.LoadFromFile(image[image_load4]);
       Form3.Image13.Visible := True;
       if (Form3.Image13.Top < 475) then // position du sol
       begin
            for i1 := 1 to vitesse do
            begin
                Form3.Image13.Top := Form3.Image13.Top + 1;
            end;
       end
       else
       begin
         Form3.Image13.Visible := False;
         Form3.Image13.Top := 0;
         Im13 := False;

         pointDeVie();
       end;

     end;
     {Image14}
      x := hasard(1,455);

      if (x mod 7 = 0) and (Im14 = False) then
      begin
        Im14 := True;
        image_load5:= hasard(1,16);
      end;

      if Im14 then
      begin

        Form3.Image14.Picture.LoadFromFile(image[image_load5]);
        Form3.Image14.Visible := True;
        if (Form3.Image14.Top < 475) then // position du sol
        begin
             for i1 := 1 to vitesse do
             begin
                 Form3.Image14.Top := Form3.Image14.Top + 1;
             end;
        end
        else
        begin
          Form3.Image14.Visible := False;
          Form3.Image14.Top := 0;
          Im14 := False;

          pointDeVie();
        end;

      end;

      {Image15}
       x := hasard(1,100);

       if (x < 50) and (Im15 = False) then
       begin
         Im15 := True;
         image_load6:= hasard(1,16);
       end;

       if Im15 then
       begin

         Form3.Image15.Picture.LoadFromFile(image[image_load6]);
         Form3.Image15.Visible := True;
         if (Form3.Image15.Top < 475) then // position du sol
         begin
              for i1 := 1 to vitesse do
              begin
                  Form3.Image15.Top := Form3.Image15.Top + 1;
              end;
         end
         else
         begin
           Form3.Image15.Visible := False;
           Form3.Image15.Top := 0;
           Im15 := False;

           pointDeVie();
         end;

       end;
       {Image16}
       x := hasard(1,100);

       if (x < 20) and (Im16 = False) then
       begin
         Im16 := True;
         image_load7:= hasard(1,16);
       end;

       if Im16 then
       begin

         Form3.Image16.Picture.LoadFromFile(image[image_load7]);
         Form3.Image16.Visible := True;
         if (Form3.Image16.Top < 475) then // position du sol
         begin
              for i1 := 1 to vitesse do
              begin
                  Form3.Image16.Top := Form3.Image16.Top + 1;
              end;
         end
         else
         begin
           Form3.Image16.Visible := False;
           Form3.Image16.Top := 0;
           Im16 := False;

           pointDeVie();
         end;

       end;
       {Image17}
       x := hasard(1,1000);

       if (x < 650) and (Im17 = False) then
       begin
         Im17 := True;
         image_load8:= hasard(1,16);
       end;

       if Im17 then
       begin

         Form3.Image17.Picture.LoadFromFile(image[image_load8]);
         Form3.Image17.Visible := True;
         if (Form3.Image17.Top < 475) then // position du sol
         begin
              for i1 := 1 to vitesse do
              begin
                  Form3.Image17.Top := Form3.Image17.Top + 1;
              end;
         end
         else
         begin
           Form3.Image17.Visible := False;
           Form3.Image17.Top := 0;
           Im17 := False;

           pointDeVie();
         end;

       end;
       {Image18}
       x := hasard(1,200);

       if (x mod 5 = 0) and (Im18 = False) then
       begin
         Im18 := True;
         image_load9:= hasard(1,16);
       end;

       if Im18 then
       begin

         Form3.Image18.Picture.LoadFromFile(image[image_load9]);
         Form3.Image18.Visible := True;
         if (Form3.Image18.Top < 475) then // position du sol
         begin
              for i1 := 1 to vitesse do
              begin
                  Form3.Image18.Top := Form3.Image18.Top + 1;
              end;
         end
         else
         begin
           Form3.Image18.Visible := False;
           Form3.Image18.Top := 0;
           Im18 := False;

           pointDeVie();
         end;

       end;
       {Image19}
       x := hasard(1,100);

       if (x mod 2 = 1) and (Im19 = False) then
       begin
         Im19 := True;
         image_load10:= hasard(1,16);
       end;

       if Im19 then
       begin

         Form3.Image19.Picture.LoadFromFile(image[image_load10]);
         Form3.Image19.Visible := True;
         if (Form3.Image19.Top < 475) then // position du sol
         begin
              for i1 := 1 to vitesse do
              begin
                  Form3.Image19.Top := Form3.Image19.Top + 1;
              end;
         end
         else
         begin
           Form3.Image19.Visible := False;
           Form3.Image19.Top := 0;
           Im19 := False;

           pointDeVie();
         end;

       end;
end;
end.

