unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TForm4 }

  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;
  f: TextFile;
  meilleur_score: string;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormCreate(Sender: TObject);
begin
  assignFile(f, 'score.gj');
  Reset(f);
  Read(f, meilleur_score);
  Form4.BitBtn1.Caption:= meilleur_score;
end;

procedure TForm4.Image2Click(Sender: TObject);
begin
  Form4.Hide;
end;

end.

