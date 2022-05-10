unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMain = class(TForm)
    ToolBar1: TToolBar;
    Background: TRectangle;
    Rectangle1: TRectangle;
    Btn_Vertical: TSpeedButton;
    btn_Horizontal: TSpeedButton;
    procedure Btn_VerticalClick(Sender: TObject);
    procedure btn_HorizontalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.fmx}

uses Image, Functions;

procedure TMain.btn_HorizontalClick(Sender: TObject);
begin
  if not Assigned(ImageVwr) then
    Application.CreateForm(TImageVwr, ImageVwr);
  AnimateForm(Self, ImageVwr);                    //Shows the form with an horizontal animation
end;

procedure TMain.Btn_VerticalClick(Sender: TObject);
begin
  if not Assigned(ImageVwr) then
    Application.CreateForm(TImageVwr, ImageVwr);
  AnimateForm(Self, ImageVwr, True);                    //Shows the form with a vertical animation
end;

end.
