unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls;

type
  TMainForm = class(TForm)
    ActionsGroupBox: TGroupBox;
    StatsGroupBox: TGroupBox;
    LabelHP: TLabel;
    LabelPower: TLabel;
    LabelSpeed: TLabel;
    LabelDefence: TLabel;
    StatsEdit1: TSpinEdit;
    StatsEdit2: TSpinEdit;
    StatsEdit3: TSpinEdit;
    StatsEdit4: TSpinEdit;
    StatsEdit5: TSpinEdit;
    StatsEdit6: TSpinEdit;
    StatsEdit7: TSpinEdit;
    StatsEdit8: TSpinEdit;
    StatsEdit9: TSpinEdit;
    StatsEdit10: TSpinEdit;
    StatsEdit11: TSpinEdit;
    StatsEdit12: TSpinEdit;
    StatsEdit13: TSpinEdit;
    StatsEdit14: TSpinEdit;
    StatsEdit15: TSpinEdit;
    StatsEdit16: TSpinEdit;
    StatsEdit17: TSpinEdit;
    StatsEdit18: TSpinEdit;
    StatsEdit19: TSpinEdit;
    StatsEdit20: TSpinEdit;
    TeamAvatarsImage: TImage;
    TeamSelect: TComboBox;
    LoadRomButton: TButton;
    SaveCurrentButton: TButton;
    TeamSelectLabel: TLabel;
    OpenRom: TOpenDialog;
    procedure LoadRomButtonClick(Sender: TObject);
    procedure TeamSelectSelect(Sender: TObject);
    procedure SaveCurrentButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  MyComponent, mc: TComponent;
  f: File of Byte;
  StatsArray: array[0..19] of byte;
  i: ShortInt;
  rom_file_path: string;
const
  team: array[0..4] of String = ('$3DB7', '$3DCB', '$3DDF', '$3DF3', '$3E07');
implementation

procedure LoadCharacteristics();
var
  img_path, work_directory: string;
begin
  Assignfile(f, rom_file_path);
  FileMode:=fmOpenRead;
  Reset(f);
  Seek(f, StrToInt(team[MainForm.TeamSelect.ItemIndex]));
  BlockRead(f, StatsArray, 20);
  CloseFile(f);

  for i:=1 to 20 do
  begin
    MyComponent:=MainForm.FindComponent('StatsEdit'+IntToStr(i));
    TSpinEdit(MyComponent).text:=IntToStr(StatsArray[i-1]);
  end;

  work_directory:=extractfilepath(paramstr(0)) + 'img\';
  img_path:=work_directory + AnsiLowerCase(MainForm.TeamSelect.Text) + '.bmp';
  MainForm.TeamAvatarsImage.Picture.LoadFromFile(img_path);
end;

{$R *.dfm}

procedure TMainForm.LoadRomButtonClick(Sender: TObject);
begin
  if OpenRom.Execute then
    begin
      rom_file_path:=OpenRom.FileName;
      TeamSelect.Enabled:=True;
      SaveCurrentButton.Enabled:=True;
      for i:=1 to 20 do
      begin
        MyComponent:=FindComponent('StatsEdit'+IntToStr(i));
        TSpinEdit(MyComponent).Enabled:=True;
      end;
      LoadCharacteristics();
    end
end;

procedure TMainForm.TeamSelectSelect(Sender: TObject);
begin
  LoadCharacteristics();
end;

procedure TMainForm.SaveCurrentButtonClick(Sender: TObject);
begin
  Assignfile(f, rom_file_path);
  FileMode:=fmOpenWrite;
  Reset(f);
  Seek(f, StrToInt(team[MainForm.TeamSelect.ItemIndex]));

  for i:=1 to 20 do
  begin
    MyComponent:=FindComponent('StatsEdit'+IntToStr(i));
    StatsArray[i-1]:=StrToInt(TSpinEdit(MyComponent).Text);
  end;

  BlockWrite(f, StatsArray, 20);
  CloseFile(f);
end;

end.
