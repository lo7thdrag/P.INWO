unit ufrmFileManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ImageButton, Vcl.ExtCtrls, uClassData, uT3SimManager, uSimMgr_Client;

type
  TFileManager = class(TForm)
    pnlMainFileManager: TPanel;
    lblFileSharing: TLabel;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    lblShareTo: TLabel;
    cbbxShareTo: TComboBox;
    imgbtnChooseFile: TImageButton;
    pnlChooseFile: TPanel;
    lblPilihFile: TLabel;
    lstbxFileShareName: TListBox;
    lblNamaFile: TLabel;
    imgbtnShare: TImageButton;
    pnlShare: TPanel;
    Label1: TLabel;
    procedure cbbxShareToDropDown(Sender: TObject);
    procedure cbbxShareToSelect(Sender: TObject);
    procedure imgbtnChooseFileClick(Sender: TObject);
    procedure imgbtnShareClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SelectedUserRoleIP : string;
    fileNameTempFileSharing : string;
    fileNameArray : array of string;
    pathFileArray : array of PWideChar;
    addressTempFileFileSharing : PWideChar;


    procedure UpdateUserListFileSharing;
    procedure UpdateFilenameComboBox;
  end;

var
  frmFileManager: TFileManager;

implementation

{$R *.dfm}

{ TFileManager }

procedure TFileManager.cbbxShareToDropDown(Sender: TObject);
begin
  UpdateUserListFileSharing;
end;

procedure TFileManager.cbbxShareToSelect(Sender: TObject);
var
  userRoleTemp : TUserRole;
  ipTemp : string;
begin
  if cbbxShareTo.ItemIndex = -1 then
    Exit;

  userRoleTemp := TUserRole(cbbxShareTo.Items.Objects[cbbxShareTo.ItemIndex]);
  SelectedUserRoleIP := userRoleTemp.ConsoleIP;
//  lblNamaFile.Caption := userRoleTemp.ConsoleIP;
end;

procedure TFileManager.imgbtnChooseFileClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  openDialog : TOpenDialog;
  saveFileTemp : TFile_Data;
  i: Integer;
//  fileDataTemp : TRecTCPSendTelegramUserRole;

begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := 'D:\Telegram\';
  openDialog.Options := openDialog.Options + [ofAllowMultiSelect];
//  openDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
  openDialog.Filter := 'All Files (*.*)|*.*';
//  saveDialog.DefaultExt := 'docx';

//  openDialog.FilterIndex := 1;
    SetLength(fileNameArray,0);
    SetLength(pathFileArray,0);

  if openDialog.Execute then
  begin
    SetLength(pathFileArray, openDialog.Files.Count);
    SetLength(fileNameArray, openDialog.Files.Count);

    for i := 0 to openDialog.Files.Count - 1 do
    begin
      addressTemp := PWideChar(openDialog.Files[i]);
      filNameTemp := ExtractFileName(openDialog.Files[i]);
//      filNameTemp := openDialog.Files[i];
      fileNameArray[i] := filNameTemp;
      pathFileArray[i] := addressTemp;

//      lstbxFileShareName.Items.AddStrings(filNameTemp);
  //    lblNamaFile.Caption
      addressTempFileFileSharing := addressTemp;
      fileNameTempFileSharing := filNameTemp;

//      lblNamaFile.Caption := fileNameTempFileSharing;
    end;
//    UpdateFilenameComboBox;

    // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text + '\\' + 'INBOX')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
////      TDirectory.de
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
//    end;
//
//    // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
//    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT')) then
//    begin
//      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT');
//      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end
//    else
//    begin
//    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
//    end;
  end
  else
    ShowMessage('Save file was cancelled');

  openDialog.Free;
  UpdateFilenameComboBox;
//  UpdateDataFile;
end;

procedure TFileManager.imgbtnShareClick(Sender: TObject);
var
i : Integer;
addressfiletemp : PWideChar;
filenametemp : string;
begin

  if not (TDirectory.Exists('\\' + SelectedUserRoleIP + '\\File Sharing')) then
    exit;

  for i := 0 to Length(pathFileArray) - 1 do
  begin
    addressfiletemp := pathFileArray[i];
    filenametemp := fileNameArray[i];
    CopyFile(addressfiletemp, PWideChar('\\' + SelectedUserRoleIP + '\\File Sharing' + '\\' + filenametemp), False);
  end;

end;

procedure TFileManager.UpdateFilenameComboBox;
begin
  lstbxFileShareName.Clear;
  lstbxFileShareName.Items.AddStrings(TArray<string>(fileNameArray));
end;

procedure TFileManager.UpdateUserListFileSharing;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxShareTo.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
      begin
        cbbxShareTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
      end;
    end;
  end;
end;

end.
