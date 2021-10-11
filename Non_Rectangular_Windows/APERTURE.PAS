{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit Aperture;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ExtCtrls, StdCtrls;

type
	TfrmAperture = class(TForm)
		Image1: TImage;
		procedure FormCreate(Sender: TObject);
		procedure FormPaint(Sender: TObject);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
	private
		{ Private declarations }
		procedure WMNCHitTest(Var Msg: TMessage); message WM_NCHITTEST;
	public
		{ Public declarations }
	end;

var
	frmAperture: TfrmAperture;

implementation

{$R *.DFM}

var
	RgnPts: array[0..6] of TPoint;		// Outline of hole
	FlmPts: array[0..7] of TPoint;		// Outline of film

Const
	rPts: integer = 7;
	fPts: integer = 8;

procedure TfrmAperture.WMNCHitTest(Var Msg: TMessage);
begin
	{ Respond to left mouse button down, so we can drag window }
	if GetAsyncKeyState(VK_LButton) < 0 then
		Msg.Result := HTCaption
	else
		Msg.Result := HTClient;

	{ if right mouse button down, close window }
	if GetAsyncKeyState(VK_RButton) < 0 then
		Close;
end;

procedure CalcRgnPoints;
begin
	{ Create polygon, outlining hole in center of window }
	RgnPts[0] := Point(158, 140);
	RgnPts[1] := Point(174, 124);
	RgnPts[2] := Point(192, 126);
	RgnPts[3] := Point(202, 140);

	RgnPts[4] := Point(202, 171);
	RgnPts[5] := Point(174, 178);
	RgnPts[6] := Point(163, 167);

	{ Create polygon, outlining piece of film }
	FlmPts[0] := Point(0, 148);
	FlmPts[1] := Point(198, 11);
	FlmPts[2] := Point(233, 15);
	FlmPts[3] := Point(253, 0);

	FlmPts[4] := Point(259, 0);
	FlmPts[5] := Point(278, 27);
	FlmPts[6] := Point(278, 32);
	FlmPts[7] := Point(37, 201);

end;

procedure TfrmAperture.FormCreate(Sender: TObject);
var
	Region1, Region2: hRgn;
begin
	CalcRgnPoints;		// Construct Polygon
	{ Create first region, the circle }
	Region1 := CreateEllipticRgn(30, 10, ClientWidth, ClientHeight);
	{ Create second region, the polygon for the film strip }
	Region2 := CreatePolygonRgn(FlmPts[0], fPts, ALTERNATE);
	{ Combine the regions, into one region }
	CombineRgn(Region1, Region1, Region2, RGN_OR);

	{ Create third region, the hole in the center }
	Region2 := CreatePolygonRgn(RgnPts[0], rPts, ALTERNATE);
	{ Create a region that consists of the current region,
		minus the third region (the hole) }
	CombineRgn(Region1, Region1, Region2, RGN_DIFF);
	{ Assign the region to the window }
	SetWindowRgn(Handle, Region1, True);
	Repaint;

	{ Do not delete region - Windows now has control
		of the region. }
end;

procedure TfrmAperture.FormPaint(Sender: TObject);
begin
	with canvas do
	begin
		// copy image to window
		Draw(0, 0, Image1.Picture.Bitmap);
		Brush.Style := bsClear;

		{ Outline circle for better visibility }
		Pen.Color := clBlack;
		Pen.Width := 2;
		Ellipse(31, 11, width-1, height-1);
	end;
end;

procedure TfrmAperture.FormKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

end.
