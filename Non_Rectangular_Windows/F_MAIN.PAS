{*********************************************************}
{                                                         }
{     Creating Non-Rectangular Windows                    }
{                                                         }
{     Requires Win32 API (Delphi 2.0 or 3.0 or newer)     }
{                                                         }
{     Copyright © 1997 Steven J. Colagiovanni             }
{                                                         }
{*********************************************************}

unit F_Main;

interface

uses     
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls;

type
	TfrmMain = class(TForm)
		Button1: TButton;
		Button2: TButton;
		Button3: TButton;
		Button4: TButton;
		Button5: TButton;
		Button6: TButton;
		Button7: TButton;
		Label1: TLabel;
    Label2: TLabel;
		procedure FormCreate(Sender: TObject);
		procedure FormActivate(Sender: TObject);
		procedure Button1Click(Sender: TObject);
		procedure Button2Click(Sender: TObject);
		procedure Button3Click(Sender: TObject);
		procedure Button4Click(Sender: TObject);
		procedure Button5Click(Sender: TObject);
		procedure Button6Click(Sender: TObject);
		procedure Button7Click(Sender: TObject);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
	private
		{ Private declarations }
		Loading: Boolean;
	public
		{ Public declarations }
	end;

var
	frmMain: TfrmMain;

implementation

{$R *.DFM}

uses
	Ellipse, BowTie, Aperture, HourGlas, Text, Delphi;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
	Screen.Cursor := crHourglass;
	Loading := True;		// Used by FormActivate event
	Left := 5;
	Top := 5;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
	{ Chect to see if form is loading. If not loading, then
		the form was only activated. In that case, no need to
		pause the program for 5 seconds. }
	If Loading then
	begin
		{ Wait 5 seconds after form is displayed, then
			close splash screen }
		Sleep(5000);		// pause program for 5 seconds (5000 milliseconds)
		frmText.Close;
		Loading := False;
		Screen.Cursor := crDefault;
	end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
	frmEllipse.Show;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
	frmBowTie.Show;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
	Close;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
	frmAperture.Show;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
begin
	frmHourGlass.Show;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
begin
	frmText.Show;
end;

procedure TfrmMain.Button7Click(Sender: TObject);
begin
	frmDelphi.Show;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	{ just in case any of the windows are displayed,
		let's close each one and free the resources for each window. }
	frmEllipse.free;

	frmBowTie.free;

	frmAperture.free;

	frmHourGlass.free;

	frmText.free;

	frmDelphi.Free;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

end.
