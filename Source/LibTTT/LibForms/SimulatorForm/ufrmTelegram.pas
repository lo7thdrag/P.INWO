unit ufrmTelegram;

interface

uses
  Winapi.Windows, System.IOUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Win.ComObj, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Winapi.ShellAPI,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg, uSimMgr_Client, uClassData, uT3SimManager, uRecordData, uLibSetting,
  AdvGroupBox, ufrmFileManager;

type
  TfrmTelegram = class(TForm)
    pnlRight: TPanel;
    pnlLeft: TPanel;
    lblBtnTelegramMasuk: TLabel;
    imgbtnDraft: TImageButton;
    lblDraft: TLabel;
    lblBtnTelegramTerkirim: TLabel;
    pnlTelegramMasuk: TPanel;
    pnlDraft: TPanel;
    pnlTelegramTerkirim: TPanel;
    lblTo: TLabel;
    cbbxTo: TComboBox;
    LstBxTelegram: TListBox;
    lblTelegram: TLabel;
    lblTelegramMasuk: TLabel;
    lblTelegramTerkirim: TLabel;
    pnlSendTelegram: TPanel;
    ImgBtnTelegramMasuk: TImageButton;
    ImgBtnTelegramTerkirim: TImageButton;
    ImgBtnBuatTelegramTerbatas: TImageButton;
    lblBuatTelegramTerbatas: TLabel;
    pnlBuatTelegramTerbatas: TPanel;
    pnlBuatTelegramRahasia: TPanel;
    ImgBtnBuatTelegramRahasia: TImageButton;
    lblBuatTelegramRahasia: TLabel;
    AdvGroupBox1: TAdvGroupBox;
    imgBtnKirimTelegram: TImageButton;
    ImgBtnPilihFile: TImageButton;
    pnlChooseFile: TPanel;
    lblPilihFile: TLabel;
    pnlKirimTelegram: TPanel;
    lblKirimTelegram: TLabel;
    btnClosePanelSendTelegram: TImageButton;
    lblFile: TLabel;
    lblNamaFile: TLabel;
    imgBtnKirim: TImageButton;
    pnlSend: TPanel;
    lblSend: TLabel;
    imgbtnOpenTelegram: TImageButton;
    pnlOpenTelegram: TPanel;
    lblOpenTelegram: TLabel;
    Button1: TButton;
    procedure btnBuatTelegramTerbatasClick(Sender: TObject);
    procedure btnBuatTelegramRahasiaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnOpenTelegramClick(Sender: TObject);
    procedure btnKirimClick(Sender: TObject);
    procedure cbbxToDropDown(Sender: TObject);
    procedure pnlTelegramMasukClick(Sender: TObject);
    procedure pnlTelegramTerkirimClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure btnClosePanelSendTelegramClick(Sender: TObject);
    procedure imgBtnKirimTelegramClick(Sender: TObject);
    procedure lblPilihFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgbtnDraftClick(Sender: TObject);
    procedure cbbxToSelect(Sender: TObject);
  private
    { Private declarations }
    addressTempFileTelegram : PWideChar;
    fileNameTempTelegram : string;
  public
    { Public declarations }
    procedure UpdateClientTelegramList;

  end;

var
  frmTelegram: TfrmTelegram;

implementation

{$R *.dfm}

procedure TfrmTelegram.btnBuatTelegramRahasiaClick(Sender: TObject);
var
WordFileName, WordFileNameTemplateRahasia: String;
WordApplication, WordFile: Variant;
GameTime : TDateTime;
//time : string;
pw : PWideChar;
begin
//  WordFileName := 'C:\\[DENTA]\\aweesdrftyghuijok-Draft.docx';
  WordFileNameTemplateRahasia := 'data\\Template Telegram 2.docx';

  WordApplication := null;
  WordFile := null;

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If VarIsNull(WordApplication) = False then
  begin
    if not (TDirectory.Exists('D:\\Telegram')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram');
    end;
    WordFileName := 'D:\\Telegram\\TelegramRahasia_'+System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now)+'.docx';
    pw := PWideChar(WordFileName);
    CopyFile(PWideChar(WordFileNameTemplateRahasia), pw, False);
     try
        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
        WordApplication.DisplayAlerts := True; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.
        //Open Word File
        try
           WordFile := WordApplication.Documents.Open(WordFileName);
           //reference
           //https://docs.microsoft.com/en-us/office/vba/api/word.documents.open
        except
              WordFile := Null;
              //add error/exception handling code as desired
        end;

     finally

     end;
  end;
end;

procedure TfrmTelegram.btnBuatTelegramTerbatasClick(Sender: TObject);
var
WordFileName, WordFileNameTemplateTerbatas: String;
WordApplication, WordFile: Variant;
GameTime : TDateTime;
//time : string;
pw : PWideChar;
begin
//  WordFileName := 'C:\\[DENTA]\\aweesdrftyghuijok-Draft.docx';
  WordFileNameTemplateTerbatas := 'data\\Template Telegram 1.docx';

  WordApplication := null;
  WordFile := null;

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If VarIsNull(WordApplication) = False then
  begin
    if not (TDirectory.Exists('D:\\Telegram')) then
    begin
      TDirectory.CreateDirectory('D:\\Telegram');
    end;
    WordFileName := 'D:\\Telegram\\TelegramTerbatas_'+System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now)+'.docx';
    pw := PWideChar(WordFileName);
    CopyFile(PWideChar(WordFileNameTemplateTerbatas), pw, False);
     try
        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
        WordApplication.DisplayAlerts := True; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.

        //Open Word File
        try
           WordFile := WordApplication.Documents.Open(WordFileName);
           //reference
           //https://docs.microsoft.com/en-us/office/vba/api/word.documents.open
        except
              WordFile := Null;
              //add error/exception handling code as desired
        end;

     finally

     end;
  end;
end;

procedure TfrmTelegram.btnClosePanelSendTelegramClick(Sender: TObject);
begin
  addressTempFileTelegram := '';
  fileNameTempTelegram := '';
  pnlSendTelegram.Visible := False;
end;

procedure TfrmTelegram.btnKirimClick(Sender: TObject);
//var
//  addressTemp : PWideChar;
//  filNameTemp : string;
//  saveDialog : TSaveDialog;
//  saveFileTemp : TFile_Data;
//  fileDataTemp : TRecTCPSendTelegramUserRole;
//
begin
//  saveDialog := TSaveDialog.Create(self);
//  saveDialog.InitialDir := GetCurrentDir;
//  saveDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
//  saveDialog.DefaultExt := 'docx';
//  saveDialog.FilterIndex := 1;
//
//  if saveDialog.Execute then
//  begin
//    addressTemp := PWideChar(saveDialog.FileName);
//    filNameTemp := ExtractFileName(saveDialog.FileName);
//    addressTempFileTelegram := addressTemp;
//    fileNameTempTelegram := filNameTemp;

    // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
  if (addressTempFileTelegram <> '') and (fileNameTempTelegram <> '') then
  begin
    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text + '\\' + 'INBOX')) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX');
      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
//      TDirectory.de
    end
    else
    begin
    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + fileNameTempTelegram), False);
    end;

    // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT')) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT');
      CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
    end
    else
    begin
    CopyFile(addressTempFileTelegram, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + '\\' + 'SENT' + '\\' + fileNameTempTelegram), False);
    end;

    pnlSendTelegram.Visible := False;
  end
  else
  ShowMessage('Please choose Telegram File first!');
//  end
//  else
//    ShowMessage('Save file was cancelled');
//
//  saveDialog.Free;
//
////  UpdateDataFile;
end;

procedure TfrmTelegram.Button1Click(Sender: TObject);
var
path : string;
begin
  if not Assigned(frmFileManager) then
    frmFileManager := TFileManager.Create(Self);

  frmFileManager.Show;
end;

procedure TfrmTelegram.btnOpenTelegramClick(Sender: TObject);
var
WordApplication, WordFile: Variant;
begin
  WordApplication := null;
  WordFile := null;

//  LstBxTelegram.Items.Strings[LstBxTelegram.ItemIndex];

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If (VarIsNull(WordApplication) = False) then
  begin
    if LstBxTelegram.ItemIndex <> -1 then
    begin
     try
        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
        WordApplication.DisplayAlerts := False; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.

        try
           WordFile := WordApplication.Documents.Open(LstBxTelegram.Items.Strings[LstBxTelegram.ItemIndex]);
        except
              WordFile := Null;
        end;
     finally


     end;
    end;
  end;

end;

procedure TfrmTelegram.cbbxToDropDown(Sender: TObject);
begin
  UpdateClientTelegramList;
end;

procedure TfrmTelegram.cbbxToSelect(Sender: TObject);
var
  userRoleTemp : TUserRole;
  ipTemp : string;

begin
  if cbbxTo.ItemIndex = -1 then
    Exit;

  userRoleTemp := TUserRole(cbbxTo.Items.Objects[cbbxTo.ItemIndex]);
  lblNamaFile.Caption := userRoleTemp.ConsoleIP;
end;

procedure TfrmTelegram.FormShow(Sender: TObject);
begin
  pnlSendTelegram.Visible := False;
end;

procedure TfrmTelegram.imgBtnKirimTelegramClick(Sender: TObject);
begin
  pnlSendTelegram.Visible := True;
  pnlSendTelegram.BringToFront;
  addressTempFileTelegram := '';
  fileNameTempTelegram := '';
  lblNamaFile.Caption := '...';
end;

procedure TfrmTelegram.Label1Click(Sender: TObject);
begin
//  if not TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM') then
//    Exit;
//
//   ShellExecute(0, 'open', ('C:\[DENTA]\removeDir.bat'), nil, nil, SW_SHOW);

end;

procedure TfrmTelegram.lblPilihFileClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  openDialog : TOpenDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecTCPSendTelegramUserRole;

begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := 'D:\Telegram\';
//  openDialog.Options := openDialog.Options + [ofAllowMultiSelect];
//  openDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
  openDialog.Filter := 'All Files (*.*)|*.*';
//  saveDialog.DefaultExt := 'docx';

//  openDialog.FilterIndex := 1;

  if openDialog.Execute then
  begin
    addressTemp := PWideChar(openDialog.FileName);
    filNameTemp := ExtractFileName(openDialog.FileName);
//    lblNamaFile.Caption
    addressTempFileTelegram := addressTemp;
    fileNameTempTelegram := filNameTemp;

    lblNamaFile.Caption := fileNameTempTelegram;

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

//  UpdateDataFile;
end;

procedure TfrmTelegram.pnlTelegramMasukClick(Sender: TObject);
var
path : string;
begin
  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'INBOX';
  lblTelegramMasuk.Visible := True;
  lblTelegramTerkirim.Visible := False;
  LstBxTelegram.Items.Clear;

  if not TDirectory.Exists(path) then
  begin
  ShowMessage('Inbox still empty');
  Exit
  end
  else
  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));
end;

procedure TfrmTelegram.imgbtnDraftClick(Sender: TObject);
var
path : string;
begin
  path := 'D:\Telegram\';
  lblTelegramMasuk.Visible := True;
  lblTelegramMasuk.Caption := 'Draft';

  lblTelegramTerkirim.Visible := False;
  LstBxTelegram.Items.Clear;

  if not TDirectory.Exists(path) then
  begin
  ShowMessage('Inbox still empty');
  Exit
  end
  else
  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));
end;

procedure TfrmTelegram.pnlTelegramTerkirimClick(Sender: TObject);
var
path : string;
begin
  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\\' + 'SENT';
  lblTelegramMasuk.Visible := False;
  lblTelegramTerkirim.Visible := True;
  LstBxTelegram.Items.Clear;

  if not TDirectory.Exists(path) then
  begin
  ShowMessage('Sentbox still empty');
  Exit
  end
  else
  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));
end;

procedure TfrmTelegram.UpdateClientTelegramList;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  cbbxTo.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
      begin
        cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleAcronim + ' - ' + userRoleTemp.FSubRoleData.SubRoleIdentifier, userRoleTemp);
      end;
    end;
  end;
end;

end.
