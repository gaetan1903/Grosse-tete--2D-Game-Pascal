unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Unit2,MMsystem;

type

  { TForm1 }

  TForm1 = class(TForm)
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
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public


  end;

var
  Form1: TForm1;
  n: integer = 1;
  tmp1, tmp2 : integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Position:= poScreenCenter;
  tmp1 := Form1.Image2.Top;
  tmp2 := Form1.Image2.Left;
  PlaySound('mic.wav',0,SND_ASYNC);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  Form2.Show;
  Form1.Hide;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  if (n < 3) then
  begin
       Form1.Image2.Top:= Form1.Image2.Top - n;
  end
  else if (n < 5) then
  begin
       Form1.Image2.Left:= Form1.Image2.Left - n;
  end
  else if (n < 7) then
  begin
    Form1.Image2.Top:= Form1.Image2.Top + n;
  end
  else if (n < 9) then
  begin
       Form1.Image2.Left := Form1.Image2.Left + n;
  end
  else
  begin
    Form1.Image2.Top := tmp1;
    Form1.Image2.Left := tmp2;
  end;
  n := n + 1;

end;
end.

