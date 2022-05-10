unit Image;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TImageVwr = class(TForm)
    Background: TRectangle;
    ToolBar1: TToolBar;
    TB_Color: TRectangle;
    ImageControl1: TImageControl;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImageVwr: TImageVwr;

implementation

{$R *.fmx}

procedure TImageVwr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= TCloseAction.caFree;
  ImageVwr:= Nil;
end;

procedure TImageVwr.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.
