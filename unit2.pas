unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Unit3, Unit4, Unit5;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    meilleur_score : integer;

  end;

var
  Form2: TForm2;
  f: textFile;
  tmp_score : string;
  meilleur_score: integer;

implementation

{$R *.lfm}

{ TForm2 }
{
uses
  MMsystem, LCLType;
}

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  // PlaySound('mic.wav', 0, SND_ASYNC);
  try
    assignFile(f, 'score.gj');
    Reset(f);
    read(f, tmp_score);
    try
       meilleur_score := StrToInt(tmp_score);
    except
      meilleur_score := 0;
    end;
    closeFile(f);
  except
    assignFile(f, 'score.gj');
    Rewrite(f);
    meilleur_score := 0;
    closeFile(f);
  end;


end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
      Form3.Show;
      Form2.Hide;
end;

end.

