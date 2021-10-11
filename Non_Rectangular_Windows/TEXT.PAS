{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit Text;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
	TfrmText = class(TForm)
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
	frmText: TfrmText;

implementation

{$R *.DFM}

procedure TfrmText.WMNCHitTest(Var Msg: TMessage);
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

procedure TfrmText.ConstructPath;
var
	RgnPts: array[0..11] of TPoint;
	MagLength: word;

begin
	BeginPath(Canvas.Handle);
	{ SetBkMode() allows us to outline letters }
	SetBkMode(Canvas.Handle, TRANSPARENT);

	with canvas do
	begin
		{ Use canvas to paint 'Delphi' }
		Font.Style := [fsBold];
		Font.Name := 'Times New Roman';
		Font.Size := 130;
		TextOut(62, 0, 'Delphi');

		{ Use canvas to paint 'MAGAZINE' }
		{ Square is ANSI character 0183 }
		Font.Name := 'Arial';
		Font.Size := 37;
		TextOut(0, 195, 'M · A · G · A · Z · I · N · E');

		{ Get length of text before changing font }
		MagLength := TextWidth('M · A · G · A · Z · I · N · E');

	end;

	{ 'E' }
	RgnPts[0] := Point(0, 44);
	RgnPts[1] := Point(12, 44);
	RgnPts[2] := Point(12, 66);
	RgnPts[3] := Point(21, 66);
	RgnPts[4] := Point(21, 44);
	RgnPts[5] := Point(32, 44);
	RgnPts[6] := Point(32, 66);
	RgnPts[7] := Point(41, 66);
	RgnPts[8] := Point(41, 44);
	RgnPts[9] := Point(53, 44);
	RgnPts[10] := Point(53, 78);
	RgnPts[11] := Point(0, 78);
	Polygon(Canvas.Handle, RgnPts[0], 12);

	{ 'H' }
	RgnPts[0] := Point(0, 83);
	RgnPts[1] := Point(53, 83);
	RgnPts[2] := Point(53, 95);
	RgnPts[3] := Point(32, 95);
	RgnPts[4] := Point(32, 106);
	RgnPts[5] := Point(53, 106);
	RgnPts[6] := Point(53, 118);
	RgnPts[7] := Point(0, 118);
	RgnPts[8] := Point(0, 106);
	RgnPts[9] := Point(21, 106);
	RgnPts[10] := Point(21, 95);
	RgnPts[11] := Point(0, 95);
	Polygon(Canvas.Handle, RgnPts[0], 12);

	{ 'T' }
	RgnPts[0] := Point(0, 123);
	RgnPts[1] := Point(13, 123);
	RgnPts[2] := Point(13, 135);
	RgnPts[3] := Point(53, 135);
	RgnPts[4] := Point(53, 148);
	RgnPts[5] := Point(13, 148);
	RgnPts[6] := Point(13, 158);
	RgnPts[7] := Point(0, 158);
	Polygon(Canvas.Handle, RgnPts[0], 8);

	{ Create two underlines }
	MoveToEx(Canvas.Handle, 0, 165, nil);
	LineTo(Canvas.Handle, 311, 165);
	LineTo(Canvas.Handle, 311, 175);
	LineTo(Canvas.Handle, 0, 175);
	LineTo(Canvas.Handle, 0, 165);

	MoveToEx(Canvas.Handle, 365, 165, nil);
	{ Right end point = end of text }
	LineTo(Canvas.Handle, MagLength-1, 165);
	LineTo(Canvas.Handle, MagLength-1, 175);
	LineTo(Canvas.Handle, 365, 175);
	LineTo(Canvas.Handle, 365, 165);

	EndPath(Canvas.Handle);
end;

procedure TfrmText.FormCreate(Sender: TObject);
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

procedure TfrmText.FormKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

procedure TfrmText.FormPaint(Sender: TObject);
begin
	with canvas do
	begin
		{ Paint red areas of form }
		Pen.Color := clRed;
		Brush.Color := clRed;
		Brush.Style := bsSolid;
		Rectangle(60, 0, width, 160);		// Delphi

		Rectangle(312, 155,  365, 195);		// P extension

		Rectangle( 48, 195,  76, 260);		// Dot after M
		Rectangle(126, 195, 154, 260);		// Dot after A
		Rectangle(205, 195, 233, 260);		// Dot after G
		Rectangle(283, 195, 309, 260);		// Dot after A
		Rectangle(355, 195, 382, 260);		// Dot after Z
		Rectangle(410, 195, 438, 260);		// Dot after I
		Rectangle(486, 195, 516, 260);		// Dot after N
	end;

end;

end.
