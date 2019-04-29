unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

{ TForm5 }

procedure TForm5.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'Ceci est un petit jeu conçu pour un projet' + #13#10 + 'C"est un jeu inspiré de jeu de bulles qui tire sur des bulles tombant' +#13#10 + 'sauf qu"ici, ce sont les têtes des G2 pour le fun';
end;

end.

