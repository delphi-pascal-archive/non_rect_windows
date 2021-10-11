{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit ellipse;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ExtCtrls;

type
	TfrmEllipse = class(TForm)
		Shape1: TShape;
		Label1: TLabel;
    Label2: TLabel;
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
	frmEllipse: TfrmEllipse;

implementation

{$R *.DFM}

procedure TfrmEllipse.WMNCHitTest(Var Msg: TMessage);
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

procedure TfrmEllipse.FormCreate(Sender: TObject);
var
	Region: hRgn;
begin
	{ Create region, or window boundaries }
	Region := CreateEllipticRgn(0, 0, Width, Height);
	{ Assign the region to the window }
	SetWindowRgn(Handle, Region, True);

	{ Do not delete region - Windows now has control
		of the region. }
end;

procedure TfrmEllipse.FormPaint(Sender: TObject);
begin
	{ Paint window border }
	with canvas do
	begin
		Pen.Color := clBlack;
		Pen.Width := 2;
		Ellipse(1, 1, width-2, height-2);
	end;
end;

procedure TfrmEllipse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if key = VK_Escape then Close;
end;

end.
