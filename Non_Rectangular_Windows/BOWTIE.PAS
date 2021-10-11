{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit bowtie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TfrmBowTie = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private
		{ Private declarations }
		procedure WMNCHitTest(Var Msg: TMessage); message WM_NCHITTEST;
	public
		{ Public declarations }
	end;

var
	frmBowTie: TfrmBowTie;

implementation

{$R *.DFM}

var
	RgnPts: array[0..11] of TPoint;		//Window region (outline)
	PgnPts: array[0..11] of TPoint;		//Points for outlining region

Const
	nPts: integer= 12;

procedure TfrmBowTie.WMNCHitTest(Var Msg: TMessage);
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
	{ Set points of polygon for window border }
	RgnPts[0] := Point(30, 12);
	RgnPts[1] := Point(125, 12);
	RgnPts[2] := Point(125, 0);
	RgnPts[3] := Point(250, 0);

	RgnPts[4] := Point(250, 12);
	RgnPts[5] := Point(375, 12);
	RgnPts[6] := Point(345, 81);
	RgnPts[7] := Point(250, 81);

	RgnPts[8] := Point(250, 93);
	RgnPts[9] := Point(125, 93);
	RgnPts[10] := Point(125, 81);
	RgnPts[11] := Point(0, 81);


	{ ============================= }

	{ Set points of polygon for painting window border }
	// Polygon must fit within the window boundaries
	// Reduce all polygon points by one
	PgnPts[0] := Point(31, 13);
	PgnPts[1] := Point(126, 13);
	PgnPts[2] := Point(126, 1);
	PgnPts[3] := Point(249, 1);

	PgnPts[4] := Point(249, 13);
	PgnPts[5] := Point(374, 13);
	PgnPts[6] := Point(344, 80);
	PgnPts[7] := Point(249, 80);

	PgnPts[8] := Point(249, 92);
	PgnPts[9] := Point(126, 92);
	PgnPts[10] := Point(126, 80);
	PgnPts[11] := Point(1, 80);

end;

procedure TfrmBowTie.FormCreate(Sender: TObject);
var
	Region: hRgn;

begin
	CalcRgnPoints;		//Construct polygon
	{ Create region, or window boundaries from the polygon }
	Region := CreatePolygonRgn(RgnPts[0], nPts, ALTERNATE);
	{ Assign the region to the window }
	SetWindowRgn(Handle, Region, True);

	{ Do not delete region - Windows now has control
		of the region. }
end;

procedure TfrmBowTie.FormKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

procedure TfrmBowTie.FormPaint(Sender: TObject);
begin
	{ Paint window border }
	with canvas do
	begin
		Pen.Color := clBlack;
		Pen.Width := 2;
		Brush.Color := clRed;
		Polygon(PgnPts);
	end;

end;

end.
