{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit Delphi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TfrmDelphi = class(TForm)
		procedure FormCreate(Sender: TObject);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
	private
		{ Private declarations }
		procedure WMNCHitTest(Var Msg: TMessage); message WM_NCHITTEST;
		procedure ConstructPath;
	public
		{ Public declarations }
	end;

var
	frmDelphi: TfrmDelphi;

implementation

{$R *.DFM}

procedure TfrmDelphi.WMNCHitTest(Var Msg: TMessage);
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

procedure TfrmDelphi.ConstructPath;
var
	RgnPts: array[0..12] of TPoint;

Const
	nPts: integer = 3;

begin
	BeginPath(Canvas.Handle);

	{ Outside 'D' }
	MoveToEx(Canvas.Handle, 49, 0, nil);

	RgnPts[0] := Point(62, 2);		// control point
	RgnPts[1] := Point(79, 18);		// control point
	RgnPts[2] := Point(81, 36);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	LineTo(Canvas.Handle, 81, 53);

	RgnPts[0] := Point(79, 70);		// control point
	RgnPts[1] := Point(64, 86);		// control point
	RgnPts[2] := Point(47, 88);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	RgnPts[0] := Point(47, 88);
	RgnPts[1] := Point(0, 88);
	RgnPts[2] := Point(0, 0);
	RgnPts[3] := Point(49, 0);
	PolylineTo(Canvas.Handle, RgnPts[0],4);

	{ Inside 'D' }
	RgnPts[0] := Point(40, 68);
	RgnPts[1] := Point(27, 68);
	RgnPts[2] := Point(27, 20);
	RgnPts[3] := Point(40, 20);
	PolylineTo(Canvas.Handle, RgnPts[0], 4);

	RgnPts[0] := Point(47, 21);		// control point
	RgnPts[1] := Point(53, 28);		// control point
	RgnPts[2] := Point(54, 36);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	LineTo(Canvas.Handle, 54, 52);

	RgnPts[0] := Point(53, 60);		// control point
	RgnPts[1] := Point(47, 67);		// control point
	RgnPts[2] := Point(40, 68);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	{ 'E' }
	RgnPts[0] := Point(96, 0);
	RgnPts[1] := Point(169, 0);
	RgnPts[2] := Point(169, 18);
	RgnPts[3] := Point(123, 18);
	RgnPts[4] := Point(123, 33);
	RgnPts[5] := Point(165, 33);
	RgnPts[6] := Point(165, 50);
	RgnPts[7] := Point(123, 50);
	RgnPts[8] := Point(123, 68);
	RgnPts[9] := Point(170, 68);
	RgnPts[10] := Point(170, 88);
	RgnPts[11] := Point(96, 88);
	Polygon(Canvas.Handle, RgnPts[0], 12);

	{ 'L' }
	RgnPts[0] := Point(186, 0);
	RgnPts[1] := Point(213, 0);
	RgnPts[2] := Point(213, 67);
	RgnPts[3] := Point(256, 67);
	RgnPts[4] := Point(256, 88);
	RgnPts[5] := Point(186, 88);
	Polygon(Canvas.Handle, RgnPts[0], 6);

	{ Outside 'P' }
	MoveToEx(Canvas.Handle, 320, 0, nil);

	RgnPts[0] := Point(332, 2);		// control point
	RgnPts[1] := Point(342, 11);		// control point
	RgnPts[2] := Point(344, 22);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	LineTo(Canvas.Handle, 344, 33);

	RgnPts[0] := Point(342, 44);		// control point
	RgnPts[1] := Point(332, 53);		// control point
	RgnPts[2] := Point(320, 55);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	RgnPts[0] := Point(296, 55);
	RgnPts[1] := Point(296, 88);
	RgnPts[2] := Point(269, 88);
	RgnPts[3] := Point(269, 0);
	RgnPts[4] := Point(320, 0);
	PolyLineTo(Canvas.Handle, RgnPts[0], 5);

	{ Inside 'P' }
	RgnPts[0] := Point(309, 38);
	RgnPts[1] := Point(296, 38);
	RgnPts[2] := Point(296, 17);
	RgnPts[3] := Point(309, 17);
	PolyLineTo(Canvas.Handle, RgnPts[0], 4);

	RgnPts[0] := Point(313, 18);		// control point
	RgnPts[1] := Point(316, 21);		// control point
	RgnPts[2] := Point(317, 25);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	LineTo(Canvas.Handle, 317, 30);

	RgnPts[0] := Point(316, 34);		// control point
	RgnPts[1] := Point(313, 37);		// control point
	RgnPts[2] := Point(309, 38);		// end point
	PolyBezierTo(Canvas.Handle, RgnPts[0], nPts);

	{ 'H' }
	RgnPts[0] := Point(359, 0);
	RgnPts[1] := Point(386, 0);
	RgnPts[2] := Point(386, 31);
	RgnPts[3] := Point(417, 31);
	RgnPts[4] := Point(417, 0);
	RgnPts[5] := Point(444, 0);
	RgnPts[6] := Point(444, 88);
	RgnPts[7] := Point(417, 88);
	RgnPts[8] := Point(417, 52);
	RgnPts[9] := Point(386, 52);
	RgnPts[10] := Point(386, 88);
	RgnPts[11] := Point(359, 88);
	Polygon(Canvas.Handle, RgnPts[0], 12);

	{ 'I' }
	RgnPts[0] := Point(464, 0);
	RgnPts[1] := Point(491, 0);
	RgnPts[2] := Point(491, 88);
	RgnPts[3] := Point(464, 88);
	Polygon(Canvas.Handle, RgnPts[0], 4);

	EndPath(Canvas.Handle);
end;


procedure TfrmDelphi.FormCreate(Sender: TObject);
var
	Region1: hRgn;
begin
	ConstructPath;
	{ Create region, or window boundaries from the constructed Path }
	Region1 := PathToRegion(Canvas.Handle);
	{ Assign the region to the window }
	SetWindowRgn(Handle, Region1, True);

	{ Do not delete region - Windows now has control
		of the region. }

end;

procedure TfrmDelphi.FormKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

procedure TfrmDelphi.FormPaint(Sender: TObject);
var
	lin, Grn: byte;

begin
	{ Paint Graduated letters/background, from red to yellow }
	Canvas.Brush.Style := bsSolid;
	Canvas.Pen.Style := psClear;

	{ Paint in 30 steps }
	{ First step will be RGB(255, 0, 0) = clRed }
	
	For lin := 0 to 29 do
	begin
		Grn := Trunc(lin * 8.5);
		Canvas.Brush.Color := RGB(255, Grn, 0);
		Canvas.Rectangle(0, lin*3, Width, (lin*3)+4);
	end;

end;

end.
