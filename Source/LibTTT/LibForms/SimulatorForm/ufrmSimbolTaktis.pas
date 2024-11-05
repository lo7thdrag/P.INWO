unit ufrmSimbolTaktis;

interface

uses
  {uses Delphi}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData;

type
  TfrmSimbolTaktis = class(TForm)
    pnlMain: TPanel;
    lbl14: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    imgSimbolTaktis: TImage;
    edtKeterangan: TEdit;
    cbbTipe: TComboBox;
    cbbKategori: TComboBox;
    UploadImage: TOpenDialog;
    ImgBackgroundForm: TImage;
    Label2: TLabel;
    lblPlatform: TLabel;
    btnUpload: TImage;
    btnOk: TImage;
    btnApply: TImage;
    btnCancel: TImage;
    Panel1: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure cbbTipeChange(Sender: TObject);
    procedure cbbKategoriChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedTacticalSymbol : TTactical_Symbol;
    FPathDirectory : string;
    function CekInput: Boolean;

    procedure UpdateTacticalSymbol;

  public
    { Public declarations }
     isOK : Boolean;
     AfterClose : Boolean;

     property SelectedTacticalSymbol : TTactical_Symbol read FSelectedTacticalSymbol write FSelectedTacticalSymbol;
  end;

var
  frmSimbolTaktis: TfrmSimbolTaktis;

implementation

{$R *.dfm}

function TfrmSimbolTaktis.CekInput: Boolean;
var
  fileDataTemp : TRecTactical_Symbol;
begin
  Result := False;

  {Data ada yg kosong}
  with fileDataTemp do
  begin
    Tipe                := cbbTipe.ItemIndex;
    Kategori            := cbbKategori.ItemIndex;
    Keterangan          := edtKeterangan.Text;
    Path_Directori      := UploadImage.FileName;
  end;

  {Data sudah ada}
  if (dmINWO.GetFilterByTactical(FSelectedTacticalSymbol.FData)>0) and (FSelectedTacticalSymbol.FData.Id_Tactical_Symbol = 0)then
  begin
    ShowMessage('Data sudah ada didalam database');
    Exit;
  end;

  Result := True;
end;

procedure TfrmSimbolTaktis.btnUploadClick(Sender: TObject);
var
  addressTemp  : PWideChar;
  fileNameTemp : string;
  UploadImage  : TSaveDialog;
  saveFileTemp : TTactical_Symbol;
  fileDataTemp : TRecTactical_Symbol;

begin
  UploadImage := TSaveDialog.Create(self);
  UploadImage.InitialDir := GetCurrentDir;
  UploadImage.Filter := 'Image Files(*.bmp)|*.bmp';
//  UploadImage.Filter := 'Image Files|*.jpg;*.jpeg;*.png;*.bmp';
  UploadImage.DefaultExt := 'jpg';
  UploadImage.FilterIndex := 1;

  if UploadImage.Execute then
  begin
    addressTemp := PWideChar(UploadImage.FileName);
    fileNameTemp := ExtractFileName(UploadImage.FileName);

    with fileDataTemp do
    begin
      Tipe                := cbbTipe.ItemIndex;
      Kategori            := cbbKategori.ItemIndex;
      Keterangan          := edtKeterangan.Text;
      Path_Directori      := vGameDataSetting.FileSimbolTaktis;

      if dmINWO.InsertTacticalSymbol(fileDataTemp) then
      begin
     //    ShowMessage('Data has been saved');
      end;
    end;

    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileSimbolTaktis + '\'+ IntToStr(fileDataTemp.Id_Tactical_Symbol) + '.bmp'), False);
  end
  else
    ShowMessage('Save file was cancelled');

    UploadImage.Free;
end;

procedure TfrmSimbolTaktis.cbbKategoriChange(Sender: TObject);
begin
  if cbbKategori.ItemIndex = 0 then
    cbbKategori.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSimbolTaktis.cbbTipeChange(Sender: TObject);
begin
  if cbbTipe.ItemIndex = 0 then
    cbbTipe.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSimbolTaktis.btnApplyClick(Sender: TObject);
var
  filedataTemp : TRecTactical_Symbol;
  addressTemp  : PWideChar;
begin

  with fileDataTemp do
  begin
    Tipe            := cbbTipe.ItemIndex;
    Kategori        := cbbKategori.ItemIndex;
    Keterangan      := edtKeterangan.Text;
    Path_Directori  := vGameDataSetting.FileSimbolTaktis;

    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    if dmINWO.InsertTacticalSymbol(fileDataTemp) then
    begin
      ShowMessage('Data has been saved');
    end
    else
    begin
      if dmINWO.UpdateTacticalSymbol(fileDataTemp) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  isOK := True;
  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSimbolTaktis.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApplyClick(btnApply);

  if isOk then
    Close;
end;

procedure TfrmSimbolTaktis.UpdateTacticalSymbol;
begin
  with FSelectedTacticalSymbol do
  begin
    cbbTipe.ItemIndex;
    cbbKategori.ItemIndex;
  end;
end;

end.
