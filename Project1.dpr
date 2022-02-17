program Project1;

uses
  Forms,
  OpenGL,
  Interface_u in 'Interface_u.pas' {InterfaceForm},
  Main_u in 'Main_u.pas' {MainForm},
  Info_u in 'Info_u.pas' {InfoForm};

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInterfaceForm, InterfaceForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.Run;
end.
