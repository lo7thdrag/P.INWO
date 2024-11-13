unit ufrmTelegram;

interface

uses
  Winapi.Windows, System.IOUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Win.ComObj, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg, uSimMgr_Client, uClassData, uT3SimManager, uRecordData, uLibSetting;

type
  TfrmTelegram = class(TForm)
    pnlRight: TPanel;
    pnlLeft: TPanel;
    imgbtnBeritaMasuk: TImageButton;
    lblBeritaMasuk: TLabel;
    imgbtnBeritaBaruDibaca: TImageButton;
    lblBeritaBaruDibaca: TLabel;
    imgbtnDraft: TImageButton;
    lblDraft: TLabel;
    imgbtnBeritaTerkirim: TImageButton;
    lblBeritaTerkirim: TLabel;
    imgbtnSemuaBerita: TImageButton;
    lblSemuaBerita: TLabel;
    pnlTelegramMasuk: TPanel;
    pnlBeritaBaruDibaca: TPanel;
    pnlDraft: TPanel;
    pnlTelegramTerkirim: TPanel;
    pnlSemuaBerita: TPanel;
    lblTo: TLabel;
    btnKirim: TButton;
    cbbxTo: TComboBox;
    Image2: TImage;
    btnBuatTelegramTerbatas: TButton;
    btnBuatTelegramRahasia: TButton;
    LstBxTelegram: TListBox;
    btnOpenTelegram: TButton;
    Label1: TLabel;
    lblTelegramMasuk: TLabel;
    lblTelegramTerkirim: TLabel;
    procedure btnBuatTelegramTerbatasClick(Sender: TObject);
    procedure btnBuatTelegramRahasiaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnOpenTelegramClick(Sender: TObject);
    procedure btnKirimClick(Sender: TObject);
    procedure cbbxToDropDown(Sender: TObject);
    procedure pnlTelegramMasukClick(Sender: TObject);
    procedure pnlTelegramTerkirimClick(Sender: TObject);
  private
    { Private declarations }
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
        WordApplication.DisplayAlerts := False; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.

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
        WordApplication.DisplayAlerts := False; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.

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

procedure TfrmTelegram.btnKirimClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecTCPSendTelegramUserRole;

begin
  saveDialog := TSaveDialog.Create(self);
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'Word file|*.docx|Excel file|*.xlsx|Power Point file|*.pptx';
  saveDialog.DefaultExt := 'docx';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
  begin
    addressTemp := PWideChar(saveDialog.FileName);
    filNameTemp := ExtractFileName(saveDialog.FileName);

    // SAVE FILE KE INBOX FOLDER ROLE TUJUAN
    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text + '\\' + 'INBOX')) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX');
      CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + filNameTemp), False);
    end
    else
    begin
    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + 'INBOX' + '\\' + filNameTemp), False);
    end;

    // SAVE FILE KE SENT BOX FOLDER ROLE PENGIRIM
    if not (TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT')) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT');
      CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + filNameTemp), False);
    end
    else
    begin
    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT' + '\\' + filNameTemp), False);
    end;
  end
  else
    ShowMessage('Save file was cancelled');

  saveDialog.Free;

//  UpdateDataFile;
end;

procedure TfrmTelegram.Button1Click(Sender: TObject);
var
path : string;
begin
  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier;

  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));

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
    if LstBxTelegram.ItemIndex <> null then
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

procedure TfrmTelegram.pnlTelegramMasukClick(Sender: TObject);
var
path : string;
begin
  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'INBOX';
  lblTelegramMasuk.Visible := True;
  lblTelegramTerkirim.Visible := False;
  LstBxTelegram.Items.Clear;

  if not TDirectory.Exists(path) then
  begin
  ShowMessage('Inbox masih kosong');
  Exit
  end
  else
  LstBxTelegram.Items.AddStrings(TDirectory.GetFiles(path));
end;

procedure TfrmTelegram.pnlTelegramTerkirimClick(Sender: TObject);
var
path : string;
begin
  path := vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIdentifier + '\\' + 'SENT';
  lblTelegramMasuk.Visible := False;
  lblTelegramTerkirim.Visible := True;
  LstBxTelegram.Items.Clear;

  if not TDirectory.Exists(path) then
  begin
  ShowMessage('Belum ada Telegram terkirim');
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
        cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleIdentifier, userRoleTemp);
      end;
    end;
  end;
end;

end.
