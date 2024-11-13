unit ufrmReferensi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData;

type
  TfrmReferensi = class(TForm)
    pnlMain: TPanel;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    btnApply: TImage;
    btnCancel: TImage;
    btnOk: TImage;
    Panel1: TPanel;
    btnUpload: TImage;
    imgReferensi: TImage;
    Label2: TLabel;
    Label3: TLabel;
    edtNameDocument: TEdit;
    Label5: TLabel;
    edtKategori: TEdit;
    procedure btnUploadClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editKategoriChange(Sender: TObject);
    procedure edtNameDocumentChange(Sender: TObject);
  private
    FSelectedReferensi : TFile_Data;
    FAddressPath  : string;
    function CekInput: Boolean;

    procedure UpdateReferensi;
  public
    { Public declarations }
    isOk : Boolean;
    AfterClose : Boolean;

    property SelectedReferensi : TFile_Data read FSelectedReferensi write FSelectedReferensi;
  end;

var
  frmReferensi: TfrmReferensi;

implementation

{$R *.dfm}

{$REGION 'Form Event'}

procedure TfrmReferensi.FormShow(Sender: TObject);
var
  fileDataTemp : TRecFile_Data;
begin
  UpdateReferensi;

  with FSelectedReferensi.FData do
    btnApply.Enabled := ID_File = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Button Event'}

procedure TfrmReferensi.btnApplyClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

begin
    with FSelectedReferensi.FData do
    begin
      Tipe_File           := ExtractFileExt(saveDialog.FileName);
      Nama_File           := edtNameDocument.Text;
      Modified_Date       := DateToStr(Now);
      Modified_By         := edtKategori.Text;
      Encripted_File_Name := '';
      Directory_Path      := vGameDataSetting.FileReferensi;
      id_User             := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;

      if not CekInput then
      begin
        isOK := False;
        Exit;
      end;

      if ID_File = 0 then
      begin
        if dmINWO.InsertReferensi(FSelectedReferensi.FData) then
        begin
          ShowMessage('Data has been saved');
        end
      end
      else
      begin
        if dmINWO.UpdateFile(FSelectedReferensi.FData) then
        begin
          ShowMessage('Data has been updated');
        end;
      end;

     CopyFile(PWideChar(FAddressPath), PWideChar(vGameDataSetting.FileReferensi + '\' + IntToStr(ID_File) + '.docx'), False);

    end;

    FAddressPath := '';
    isOK := True;
    AfterClose := True;
    btnApply.Enabled := False;
    btnCancel.Enabled := False;
end;

procedure TfrmReferensi.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReferensi.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
  btnApplyClick(btnApply);

  if isOk then
    Close;
end;

procedure TfrmReferensi.btnUploadClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'Word file|*.docx|Power Point file|*.pptx|Pdf file|*.pdf';
  saveDialog.DefaultExt := 'docx';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
  begin
    FAddressPath := PWideChar(saveDialog.FileName);
    filNameTemp  := ExtractFileName(saveDialog.FileName);

    btnApply.Enabled := True;
  end
  else
  ShowMessage('Save file was cancelled');

  saveDialog.Free;
end;

{$ENDREGION}

{$REGION 'Filter Event'}

procedure TfrmReferensi.editKategoriChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

function TfrmReferensi.CekInput: Boolean;
var
  addressTemp : PWideChar;
  fileDataTemp : TRecFile_Data;
begin
  Result := False;

  if (edtNameDocument.Text = '') or (edtKategori.Text = '') then
  begin
    ShowMessage('Inputan data tidak lengkap');
    Exit;
  end;

  if FAddressPath = '' then
  begin
    ShowMessage('Inputan dokumen tidak lengkap');
    Exit;
  end;

  if (dmINWO.GetFilterByReferensi(FSelectedReferensi.FData)>0) and (FSelectedReferensi.FData.ID_File = 0)then
  begin
    ShowMessage('Data sudah ada didalam database');
    Exit;
  end;

  Result := True;
end;

procedure TfrmReferensi.edtNameDocumentChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

{$ENDREGION}

{$REGION 'Additional Event'}

procedure TfrmReferensi.UpdateReferensi;
var
  docPath : string;
begin
  if Assigned(FSelectedReferensi) then
  begin
    with FSelectedReferensi.FData do
    begin
      edtKategori.Text     := Modified_By;
      edtNameDocument.Text := Nama_File;

      if ID_File = 0 then
        exit;

      docPath := Directory_Path + '\' + IntToStr(ID_File) + '.docx';
      if FileExists(docPath) then
      begin
        FAddressPath := docPath;
      end;
    end;
  end;
end;

{$ENDREGION}

end.
