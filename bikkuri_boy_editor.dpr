program bikkuri_boy_editor;

uses
  Forms,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'BikkuriBoy Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
