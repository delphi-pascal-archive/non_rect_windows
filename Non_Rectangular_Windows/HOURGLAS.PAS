{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit Hourglas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TfrmHourGlass = class(TForm)
    procedure FormCreate(Sender: TObject);
		procedure FormKeyDown(Sender: TObject; var Key: Word;
			Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
	private
		{ Private declarations }
		procedure CalcRgnPoints;
	public
		{ Public declarations }
	end;

var
	frmHourGlass: TfrmHourGlass;

implementation

{$R *.DFM}

var
	RgnPts: array[0..17] of TPoint;
	ScnPts: array[0..13] of TPoint;

const
	nPts: byte = 18;

procedure TfrmHourGlass.CalcRgnPoints;
var
	TitleHeight: Integer;

begin
	{ Get height of title bar }
	TitleHeight := GetSystemMetrics(SM_CYCAPTION) +
		GetSystemMetrics(SM_CYDLGFRAME) + 1;

	{Set width and height of form }
	Width := 130;
	Height := 240 + (TitleHeight * 2);

	{ Window region (borders) }
	RgnPts[0] := Point(0, 0);
	RgnPts[1] := Point(Width, 0);
	RgnPts[2] := Point(Width, TitleHeight);
	RgnPts[3] := Point(Width - 5, TitleHeight);
	RgnPts[4] := Point(Width - 5, TitleHeight + 60);
	RgnPts[5] := Point(Width - 60, TitleHeight + 120);
	RgnPts[6] := Point(Width - 5, TitleHeight + 180);
	RgnPts[7] := Point(Width - 5, TitleHeight + 240);
	RgnPts[8] := Point(Width, TitleHeight + 240);
	RgnPts[9] := Point(Width, (TitleHeight * 2) + 240);
	RgnPts[10] := Point(0, (TitleHeight * 2) + 240);
	RgnPts[11] := Point(0, TitleHeight + 240);
	RgnPts[12] := Point(5, TitleHeight + 240);
	RgnPts[13] := Point(5, TitleHeight + 180);
	RgnPts[14] := Point(60, TitleHeight + 120);
	RgnPts[15] := Point(5, TitleHeight + 60);
	RgnPts[16] := Point(5, TitleHeight);
	RgnPts[17] := Point(0, TitleHeight);

	{ Window Outline region }
	ScnPts[0] := Point(-2, 1);
	ScnPts[1] := Point(Width-4, 1);
	ScnPts[2] := Point(Width - 9, 1);
	ScnPts[3] := Point(Width - 9, 61);
	ScnPts[4] := Point(Width - 64, 121);
	ScnPts[5] := Point(Width - 9, 181);
	ScnPts[6] := Point(Width - 9, 242);
	ScnPts[7] := Point(Width-4, 242);
	ScnPts[8] := Point(-2, 242);
	ScnPts[9] := Point(3, 242);
	ScnPts[10] := Point(3, 181);
	ScnPts[11] := Point(58, 121);
	ScnPts[12] := Point(3, 61);
	ScnPts[13] := Point(3, 1);

end;


procedure TfrmHourGlass.FormCreate(Sender: TObject);
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

procedure TfrmHourGlass.FormKeyDown(Sender: TObject; var Key: Word;
	Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

procedure TfrmHourGlass.FormMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if button = mbRight then
		{ Assign the region NULL to the window }
		{ to restore it's rectangular shape. }
		SetWindowRgn(Handle, 0, True);
end;

procedure TfrmHourGlass.FormPaint(Sender: TObject);
begin
	with canvas do
	begin
		{ paint base of hourglass to match caption bar }
		brush.color := clActiveCaption;
		brush.Style := bsSolid;
		Pen.Color := clActiveCaption;
		Rectangle(0, ClientHeight - GetSystemMetrics(SM_CYCAPTION),
			ClientWidth, ClientHeight);

		{ Paint window border }
		Brush.Color := clYellow;
		Pen.Color := clActiveBorder;
		Pen.Width := 2;
		Polygon(Slice(ScnPts, nPts-4));
	end;

end;

end.
