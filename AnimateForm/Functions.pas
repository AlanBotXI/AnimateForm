unit Functions;

interface

uses FMX.Forms, FMX.Objects, FMX.StdCtrls, FMX.Types, System.UITypes, FMX.Graphics, FMX.Platform, FMX.Controls, FMX.Ani, System.Classes,
     System.SysUtils;

  Procedure AnimateForm(Form1, Form2: TForm; Vertical: Boolean = False);
  Function  PutIndicator(Form: TForm): TRectangle;
  Function  IsDeviceVertical: Boolean;
  procedure AnimateAccelerated(Comp: TControl; Prop: String; FVal: Integer; Dtn: Single);

implementation

Procedure AnimateForm(Form1, Form2: TForm; Vertical: Boolean = False);
var Content, Indicator: TRectangle; Prop: String; Dtn: Single; FVal: Integer;
begin
  Try
    if not Assigned(Form2) then Exit;
    Content:= (Form2.FindComponent('Background')) as TRectangle;  //Finds the background
    if Content = Nil then Exit;
    Content.Visible:= False;                                      //Hides it
    Indicator:= PutIndicator(Form2);                              //Creates a loading indicator
    Indicator.Align:= TAlignLayout.None;
    Indicator.Height:= Form1.Height;
    if not Vertical then begin                                    //For a vertical animation
      Indicator.Position.X:= Form1.ClientWidth;
      Prop:= 'Position.X';                                        //Position.X will be animated
      FVal:= Trunc(Content.Position.X);                           //The final position for the indicator
      if IsDeviceVertical then
        Dtn:= 0.2
      else
        Dtn:= 0.3;
    end else begin
      Indicator.Position.Y:= Form1.ClientHeight;
      Prop:= 'Position.Y';                                        //Position.X will be animated
      FVal:= Trunc(Content.Position.Y);                           //The final position for the indicator
      if IsDeviceVertical then
        Dtn:= 0.3
      else
        Dtn:= 0.2;
    end;
    Form2.Show;                                                   //Shows the form
    AnimateAccelerated(Indicator, Prop, FVal, Dtn);               //And animates the loader
  Finally
    TThread.CreateAnonymousThread(procedure begin
      Sleep(Trunc(Dtn*1500));                                     //Waits for the animation to end
      TThread.Synchronize(TThread.Current, procedure begin
        Content.Visible:= True;                                   //Shows the content of the form
      end);
    end).Start;
  End;
end;

Function PutIndicator(Form: TForm): TRectangle;
var Rec: TRectangle; Ind: TAniIndicator;
begin
  Try
    Rec:= TRectangle.Create(Form);
    With Rec do begin
      Fill.Color:= TAlphaColors.White;                            //Creates a white rectangle
      Stroke.Kind:= TBrushKind.None;
      Align:= TAlignLayout.Client;
      Parent:= Form;
    end;
    Ind:= TAniIndicator.Create(Form);
    With Ind do begin
      Align:= TAlignLayout.Center;                                //And puts an indicator in the center
      Enabled:= True;
      Parent:= Rec;
    end;
    Result:= Rec;
  Except
    Result:= Nil;
  End;
end;

Function  IsDeviceVertical: Boolean;
//This functions returns a true if the device is vertical (portrait or inverted portrait)
//or a false if it's vertical
var Svc: IFMXScreenService;
begin
  Try
    if not TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, Svc) then Exit;
    case Svc.GetScreenOrientation of
      TScreenOrientation.Portrait:          Result:= True;
      TScreenOrientation.InvertedPortrait:  Result:= True;
      TScreenOrientation.Landscape:         Result:= False;
      TScreenOrientation.InvertedLandscape: Result:= False;
    end;
  Finally

  End;
end;

procedure AnimateAccelerated(Comp: TControl; Prop: String; FVal: Integer; Dtn: Single);
var Anim: TIntAnimation;
begin                     //Creates an Int Animation for the indicator, to create an effect as if the form was animated
  Try
    TThread.CreateAnonymousThread(procedure begin
      Sleep(100);
      TThread.Synchronize(TThread.Current, procedure begin
        Anim:= TIntAnimation.Create(Nil);
        With Anim do begin
          Interpolation:= TInterpolationType.Quadratic;
          StartFromCurrent:= True;
          PropertyName:= Prop;
          StopValue:= FVal;
          Duration:= Dtn;
          Parent:= Comp;
          Enabled:= True;
        end;
      end);
      Sleep(Trunc(Dtn*5000));
      TThread.Synchronize(TThread.Current, procedure begin
        Comp.Free;                                          //Deletes the indicator
      end);
    end).Start;
  Finally

  End;
end;

end.
