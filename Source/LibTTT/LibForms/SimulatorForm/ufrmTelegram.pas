unit ufrmTelegram;

interface

uses
  Winapi.Windows, System.IOUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Win.ComObj, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg, uSimMgr_Client, uClassData, uT3SimManager, uRecordData, uLibSetting;

type
  TfrmTelegram = class(TForm)
    pnlRight: TPanel;
    ListView1: TListView;
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
    pnlBeritaMasuk: TPanel;
    pnlBeritaBaruDibaca: TPanel;
    pnlDraft: TPanel;
    pnlBeritaTerkirim: TPanel;
    pnlSemuaBerita: TPanel;
    lblTo: TLabel;
    btnKirim: TButton;
    cbbxTo: TComboBox;
    Image2: TImage;
    btnBuatTelegramTerbatas: TButton;
    btnBuatTelegramRahasia: TButton;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure btnBuatTelegramTerbatasClick(Sender: TObject);
    procedure btnBuatTelegramRahasiaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnKirimClick(Sender: TObject);
    procedure cbbxToDropDown(Sender: TObject);
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
    WordFileName := 'C:\\[DENTA]\\TelegramRahasia_'+System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now)+'.docx';
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

//        If VarIsNull(WordFile) = False then
//         begin
//              WordFile.SaveAs(WordFileNameNew);
//              //reference
//              //https://docs.microsoft.com/en-us/office/vba/api/word.documents.save
//         end;
     finally
//        WordFile.Close;
//        WordApplication.DisplayAlerts := True;
//        WordApplication.Quit;

//        WordFile := Unassigned;
//        WordApplication := Unassigned;
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
    WordFileName := 'C:\\[DENTA]\\TelegramTerbatas_'+System.SysUtils.FormatDateTime('dd-mm-yy_hh;nn;ss', Now)+'.docx';
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

//        If VarIsNull(WordFile) = False then
//         begin
//              WordFile.SaveAs(WordFileNameNew);
//              //reference
//              //https://docs.microsoft.com/en-us/office/vba/api/word.documents.save
//         end;
     finally
//        WordFile.Close;
//        WordApplication.DisplayAlerts := True;
//        WordApplication.Quit;

//        WordFile := Unassigned;
//        WordApplication := Unassigned;
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

    

//    with fileDataTemp do
//    begin
//      Nama_File           := filNameTemp;
//      Directory_Path      := vGameDataSetting.FileDirectory;
//      Encripted_File_Name := '';
//      Tipe_File           := ExtractFileExt(saveDialog.FileName);
//      Modified_Date       := DateToStr(Now);
//      Modified_By         := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim;
//      id_User             := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
//
//      if dmINWO.InsertFile(fileDataTemp) then
//      begin
//        dmINWO.UpdateFile(fileDataTemp);
//        ShowMessage('Data has been saved');
//      end;
//    end;
    if not TDirectory.Exists(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' +  cbbxTo.Text) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text);
      CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + filNameTemp), False);
    end
    else
    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\\' + 'TELEGRAM' + '\\' + cbbxTo.Text + '\\' + filNameTemp), False);
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
  path := 'C:\\[DENTA]';

  ListBox1.Items.AddStrings(TDirectory.GetFiles(path));

end;

procedure TfrmTelegram.Button2Click(Sender: TObject);
var
WordApplication, WordFile: Variant;
begin
  WordApplication := null;
  WordFile := null;

  ListBox1.Items.Strings[ListBox1.ItemIndex];

  try
    //create Word OLE
    WordApplication := CreateOleObject('Word.Application');
  except
    WordApplication := Null;
    //add error/exception handling code as desired
  end;

  If VarIsNull(WordApplication) = False then
  begin
     try
        WordApplication.Visible := True; //set to False if you do not want to see the activity in the background
        WordApplication.DisplayAlerts := False; //ensures message dialogs do not interrupt the flow of your automation process. May be helpful to set to True during testing and debugging.

        try
           WordFile := WordApplication.Documents.Open(ListBox1.Items.Strings[ListBox1.ItemIndex]);
        except
              WordFile := Null;
        end;
     finally

     
     end;
     end;
  
end;

procedure TfrmTelegram.cbbxToDropDown(Sender: TObject);
begin
//  UpdateClientTelegramList;
end;

procedure TfrmTelegram.UpdateClientTelegramList;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
//  lstUserChat.Items.Clear;
  cbbxTo.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
//      if (userRoleTemp.isInUse) and (userRoleTemp.FData.UserRoleIndex <> simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex) then
//      begin
//        lstUserChat.Items.AddObject(userRoleTemp.FData.UserRoleIdentifier, userRoleTemp);
        cbbxTo.Items.AddObject(userRoleTemp.FData.UserRoleIdentifier, userRoleTemp);
//      end;
    end;
  end;
end;

end.
