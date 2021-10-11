program Regions;

uses
  Forms,
  F_Main in 'F_Main.pas' {frmMain},
  ellipse in 'ellipse.pas' {frmEllipse},
  bowtie in 'bowtie.pas' {frmBowTie},
  Aperture in 'Aperture.pas' {frmAperture},
  Hourglas in 'Hourglas.pas' {frmHourGlass},
  Delphi in 'Delphi.pas' {frmDelphi},
  Text in 'Text.pas' {frmText};

{$R *.RES}

begin
	{ Load frm.Text and show for use as splash screen }
	{ Select "Options..." from Delphi's "Project" menu
		and make certain that frmText is not in the
		"Auto-create forms" list box. }
	frmText := TfrmText.Create(Application);
	frmText.Show;
	frmText.Repaint;
	{ Splash screen is closed (or destroyed) in the
		frmMain.FormActivate event }

	Application.Initialize;
	Application.Title := 'Non-Rectangular Windows Demonstration';
	Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEllipse, frmEllipse);
  Application.CreateForm(TfrmBowTie, frmBowTie);
  Application.CreateForm(TfrmAperture, frmAperture);
  Application.CreateForm(TfrmHourGlass, frmHourGlass);
  Application.CreateForm(TfrmDelphi, frmDelphi);
  Application.Run;
end.
