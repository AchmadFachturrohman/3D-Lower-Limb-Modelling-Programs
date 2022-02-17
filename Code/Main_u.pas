unit Main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Interface_u, Info_u, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, Vcl.Buttons;

type
  TMainForm = class(TForm)
    btnClose: TButton;
    MuscleActivationChart: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    MainPanel: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnActive: TButton;
    btnPassive: TButton;
    btnAbout: TButton;
    btnExit: TButton;
    CommandPanel: TPanel;
    btnReset: TButton;
    HipChart: TChart;
    KneeChart: TChart;
    AnkleChart: TChart;
    AnkleTorqueSeries: TLineSeries;
    IliopsoasMuscleChart: TChart;
    GluteusMuscleChart: TChart;
    BSFHMuscleChart: TChart;
    IloMuscleForceSeries: TLineSeries;
    IloMuscleLenghtSeries: TLineSeries;
    GluMuscleForceSeries: TLineSeries;
    GluMuscleLenghtSeries: TLineSeries;
    BSFHMuscleForceSeries: TLineSeries;
    BSFHMuscleLenghtSeries: TLineSeries;
    HipTorqueSeries: TLineSeries;
    KneeTorqueSeries: TLineSeries;
    btnShowInterface: TButton;
    TestModeGroup: TRadioGroup;
    ConditionGroup: TRadioGroup;
    AnkleAngleSeries: TLineSeries;
    HipAngleSeries: TLineSeries;
    KneeAngleSeries: TLineSeries;
    VastusMuscleChart: TChart;
    VasMuscleForceSeries: TLineSeries;
    VasMuscleLenghtSeries: TLineSeries;
    SoleusMuscleChart: TChart;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    SoleusMuscleForceSeries: TLineSeries;
    SoleusMuscleLenghtSeries: TLineSeries;
    TibialisMuscleChart: TChart;
    TibialisMuscleForceSeries: TLineSeries;
    TibialisMuscleLenghtSeries: TLineSeries;
    IloMuscle_fl_Series: TLineSeries;
    IloMuscle_fv_Series: TLineSeries;
    GluMuscle_fl_Series: TLineSeries;
    GluMuscle_fv_Series: TLineSeries;
    BSFHMuscle_fl_Series: TLineSeries;
    BSFHMuscle_fv_Series: TLineSeries;
    VasMuscle_fl_Series: TLineSeries;
    VasMuscle_fv_Series: TLineSeries;
    SoleusMuscle_fl_Series: TLineSeries;
    SoleusMuscle_fv_Series: TLineSeries;
    TibialisMuscle_fl_Series: TLineSeries;
    TibialisMuscle_fv_Series: TLineSeries;
    procedure displayActived;
    procedure displayPassived;
    procedure btnCloseClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnActiveClick(Sender: TObject);
    procedure btnPassiveClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnShowInterfaceClick(Sender: TObject);
    procedure rbtnActiveClick(Sender: TObject);
    procedure rbtnPassiveClick(Sender: TObject);
    procedure TestModeGroupClick(Sender: TObject);
    procedure ConditionGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  FC :boolean;

implementation

{$R *.dfm}
procedure TMainForm.displayActived;
begin
  CommandPanel.Color := $00F184CD;
  InterfaceForm.btnClose.Top := 24;
end;

procedure TMainForm.displayPassived;
begin
  CommandPanel.Color := $00EA5EA5;
  InterfaceForm.PassiveTestBox.Visible := true;
  InterfaceForm.ActiveTestBox.Visible := false;
  InterfaceForm.btnClose.Top := 64;
end;

procedure TMainForm.rbtnActiveClick(Sender: TObject);
begin
  displayactived;
end;

procedure TMainForm.rbtnPassiveClick(Sender: TObject);
begin
  displaypassived;
end;

procedure TMainForm.TestModeGroupClick(Sender: TObject);
begin
  if TestModeGroup.ItemIndex = 0 then
  begin
    displayactived;
  end;
  if TestModeGroup.ItemIndex = 1 then
  begin
    displaypassived;
  end;
end;

procedure TMainForm.btnResetClick(Sender: TObject);
begin
  Series1.Clear; Series2.Clear; Series3.Clear; Series4.Clear;
  Series5.Clear; Series6.Clear;

  HipAngleSeries.Clear;
  KneeAngleSeries.Clear;
  AnkleAngleSeries.Clear;

  HipTorqueSeries.Clear;
  KneeTorqueSeries.Clear;
  AnkleTorqueSeries.Clear;

  IloMuscleForceSeries.Clear;
  IloMuscleLenghtSeries.Clear;
  IloMuscle_fl_Series.Clear;
  IloMuscle_fv_Series.Clear;

  GluMuscleForceSeries.Clear;
  GluMuscleLenghtSeries.Clear;
  GluMuscle_fl_Series.Clear;
  GluMuscle_fv_Series.Clear;

  BSFHMuscleForceSeries.Clear;
  BSFHMuscleLenghtSeries.Clear;
  BSFHMuscle_fl_Series.Clear;
  BSFHMuscle_fv_Series.Clear;

  VasMuscleForceSeries.Clear;
  VasMuscleLenghtSeries.Clear;
  VasMuscle_fl_Series.Clear;
  VasMuscle_fv_Series.Clear;

  SoleusMuscleForceSeries.Clear;
  SoleusMuscleLenghtSeries.Clear;
  SoleusMuscle_fl_Series.Clear;
  SoleusMuscle_fv_Series.Clear;

  TibialisMuscleForceSeries.Clear;
  TibialisMuscleLenghtSeries.Clear;
  TibialisMuscle_fl_Series.Clear;
  TibialisMuscle_fv_Series.Clear;

  ConditionGroup.ItemIndex := -1;
  if ConditionGroup.ItemIndex = 0 then
  begin
    InterfaceForm.ScrollBar1.Position := 90;
    InterfaceForm.ScrollBar2.Position := 120;
    InterfaceForm.ScrollBar3.Position := 0;
  end;
  if ConditionGroup.ItemIndex = 1 then
  begin
    InterfaceForm.ScrollBar1.Position := 48;
    InterfaceForm.ScrollBar2.Position := 120;
    InterfaceForm.ScrollBar3.Position := 10;
  end;
end;

procedure TMainForm.btnActiveClick(Sender: TObject);
begin
  MainForm.WindowState := wsMaximized;
  CommandPanel.Visible := true;
  displayActived;
  TestModeGroup.ItemIndex := 0;
end;

procedure TMainForm.btnPassiveClick(Sender: TObject);
begin
  MainForm.WindowState := wsMaximized;
  CommandPanel.Visible := true;
  displayPassived;
  TestModeGroup.ItemIndex := 1;
end;

procedure TMainForm.btnShowInterfaceClick(Sender: TObject);
begin
  InterfaceForm.Show;
end;

procedure TMainForm.ConditionGroupClick(Sender: TObject);
begin
  if ConditionGroup.ItemIndex = 0 then
  begin
    if TestModeGroup.ItemIndex = 0 then
    begin
      InterfaceForm.PassiveTestBox.Visible := false;
      InterfaceForm.FlexorHip.Enabled := false;
      InterfaceForm.ExtensorHip.Enabled := false;
      InterfaceForm.ActiveTestBox.Visible := true;
      xpos := 0;
      ypos := 0.5;
    end else
    if TestModeGroup.ItemIndex = 1 then
    begin
      xpos := -1;
      ypos := 0.5;
    end;
    InterfaceForm.Show;
    InterfaceForm.renderkakiseated;
    InterfaceForm.ScrollBar1.Position := 90;
    InterfaceForm.ScrollBar2.Position := 120;
    InterfaceForm.ScrollBar3.Position := 0;
  end else
  if ConditionGroup.ItemIndex = 1 then
  begin
    if TestModeGroup.ItemIndex = 0 then
    begin
      InterfaceForm.PassiveTestBox.Visible := false;
      InterfaceForm.FlexorHip.Enabled := true;
      InterfaceForm.ExtensorHip.Enabled := true;
      InterfaceForm.ActiveTestBox.Visible := true;
    end;
    xpos := 0;
    ypos := 1;
    InterfaceForm.Show;
    InterfaceForm.renderkakistanding;
    InterfaceForm.ScrollBar1.Position := 48;
    InterfaceForm.ScrollBar2.Position := 120;
    InterfaceForm.ScrollBar3.Position := 10;
  end;
  MainForm.btnShowInterface.Visible := true;
end;

procedure TMainForm.btnAboutClick(Sender: TObject);
begin
  InfoForm.Show;
end;

procedure TMainForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

end.
