unit ufrmToteDisplay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.IOUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,

  ufrmFileManager, uClassData, uRecordData, uSimMgr_Client, uDataModule, uLibSetting,
  ufrmSummaryUserRole, uT3SimManager, uConsoleData,
  Vcl.Imaging.pngimage, RzBmpBtn, Vcl.Buttons;

type
  TfrmToteDisplay = class(TForm)
    pnlMain: TPanel;
    lvConsoleList: TListView;
    lblConcoleList: TLabel;
    pnlMenu: TPanel;
    lblFileTransfer: TLabel;
    btnLogout: TButton;
    btnSend: TButton;
    pnlConsole: TPanel;
    pnlFileTransfer: TPanel;
    pnllvConsoleList: TPanel;
    pnlHeader: TPanel;
    Label1: TLabel;
    cbbConsole: TComboBox;
    btnUpload: TRzBmpButton;
    pnlSend: TPanel;
    pnlLogout: TPanel;
    pnlHeaderConsole: TPanel;
    Label2: TLabel;
    pnllvTransfer: TPanel;
    lvFileTransfer: TListView;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    btnConsoleList: TSpeedButton;
    btnMyDesktop: TSpeedButton;

    {$REGION 'Console List'}
    procedure pnlConsoleListManajemenShow;
    procedure lvConsoleListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure UpdateConsoleList;
    procedure btnLogoutClick(Sender: TObject);
    procedure ConsoleListClick(Sender: TObject);
    {$ENDREGION}

    {$REGION 'File Transfer'}
    procedure pnlFileTransferManajemenShow;
    procedure lvFileTransferSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure CbbConsoleDestination(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure FileTransferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);

    procedure UpdateFile;
    {$ENDREGION}

    procedure FormShow(Sender: TObject);
    procedure cbbConsoleSelect(Sender: TObject);
  private
    FConsoleList  : TList;
    FFileTransfer : TList;

//    addressTemp     : PWideChar;
    addressTemp     : string;
    AddressPath     : string;
    fileNameTemp    : string;

    consolenameTemp : string;

    FSelectedFileTransfer : TFile_Data;
    FSelectedConsole      : TUserRole;
  public
    FileListName : string;
    SelectedUserRoleIP : string;

    procedure Initialize;
    property SelectedFile : TFile_Data read FSelectedFileTransfer write FSelectedFileTransfer;
  end;

var
  frmToteDisplay: TfrmToteDisplay;

implementation

uses
  ufrmDisplayArea, ufrmTacticalDisplay;

{$R *.dfm}

procedure TfrmToteDisplay.FormShow(Sender: TObject);
begin
  cbbConsole.ItemIndex := -1;

end;

procedure TfrmToteDisplay.FormCreate(Sender: TObject);
var
  i: Integer;

begin
  if Screen.MonitorCount > 1 then
    i := 1
  else
    i := 0;

  DefaultMonitor := dmDesktop;

  Width := Screen.Monitors[vGameDataSetting.ToteScreen].Width;
  Height := Screen.Monitors[vGameDataSetting.ToteScreen].Height;
  Left := Screen.Monitors[vGameDataSetting.ToteScreen].Left;
  Top := Screen.Monitors[vGameDataSetting.ToteScreen].Top;

  FConsoleList  := TList.Create;
  FFileTransfer := TList.Create;

  btnLogout.Visible := False;
  btnLogout.Enabled := False;
end;

{$REGION 'Console List'}
procedure TfrmToteDisplay.ConsoleListClick(Sender: TObject);
begin
  pnlConsoleListManajemenShow;
end;

procedure TfrmToteDisplay.pnlConsoleListManajemenShow;
begin
  pnlConsole.BringToFront;

  UpdateConsoleList;
end;

procedure TfrmToteDisplay.UpdateConsoleList;
var
  i : Integer;
  consoleListTemp : TUserRole;
  consoleInfoTemp : TConsoleInfo;
  subRoleTemp     : TSubRole;
  li : TListItem;
begin
  lvConsoleList.Items.Clear;

  for i := 0 to simMgrClient.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrClient.SimConsole.ConsoleList.Objects[i]);
    li := lvConsoleList.Items.Add;
    li.Caption := consoleInfoTemp.ConsoleName;

    consoleListTemp := SimManager.SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(consoleListTemp) then
    begin
      if consoleListTemp.isInUse then
      begin
        li.SubItems.Add(consoleListTemp.FData.UserRoleAcronim);

        subRoleTemp := SimManager.SimSubRole.getSubRoleByID(consoleListTemp.FData.SubRoleIndex);
        li.SubItems.Add(subRoleTemp.FData.SubRoleAcronim);
      end;
    end;
    li.Data := consoleInfoTemp;
    li.Data := consoleListTemp;
  end;
end;

procedure TfrmToteDisplay.lvConsoleListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   FSelectedConsole := nil;

   if Selected then
   begin
      if (Item = nil) or (item.Data = nil) then
      begin
        MessageDlg('User cannot be selected', mtInformation, [mbOK], 0);
        Exit;
      end;

      FSelectedConsole := TUserRole(Item.Data);
      consolenameTemp  := FSelectedConsole.FData.UserRoleAcronim;

      btnLogout.Visible := True;
      btnLogout.Enabled := True;
   end
   else
   begin
     btnLogout.Visible := False;
     btnLogout.Enabled := False;
   end;
end;

procedure TfrmToteDisplay.btnLogoutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;
  consoleInfoTemp : TConsoleInfo;
  consoleListTemp: TUserRole;
begin

  if FSelectedConsole = nil then
  begin
    ShowMessage('Select console to logout');
    Exit;
  end;

  consolenameTemp := FSelectedConsole.FData.UserRoleAcronim;

  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    rec.UserRoleInUse := False;

    ShowMessage('User "' + consolenameTemp + '"Logout');

    simMgrClient.netSend_CmdUserState(rec);
  end;

  if Assigned(frmDisplayArea) then
  frmDisplayArea.Close;

  if Assigned(frmTacticalDisplay) then
  begin
    frmTacticalDisplay.UpdateClientLogout(nil);
    frmTacticalDisplay.Show;
  end;

  Close;
end;

{$ENDREGION}

{$REGION 'File Transfer'}
procedure TfrmToteDisplay.FileTransferClick(Sender: TObject);
begin
 pnlFileTransferManajemenShow;
end;

procedure TfrmToteDisplay.Initialize;
var
  i : Integer;
begin
  if Screen.MonitorCount > 1 then
  begin
    Width := Screen.Monitors[vGameDataSetting.ToteScreen].Width;
    Height := Screen.Monitors[vGameDataSetting.ToteScreen].Height;
    Left := Screen.Monitors[vGameDataSetting.ToteScreen].Left;
    Top := Screen.Monitors[vGameDataSetting.ToteScreen].Top;
  end
  else
  begin
    Width := Screen.Monitors[0].Width;
    Height := Screen.Monitors[0].Height;
    Left := Screen.Monitors[0].Left;
    Top := Screen.Monitors[0].Top;
  end;
end;

procedure TfrmToteDisplay.pnlFileTransferManajemenShow;
begin
  pnlFileTransfer.BringToFront;
end;

procedure TfrmToteDisplay.btnAddClick(Sender: TObject);
var
  openDialog   : TOpenDialog;
  saveFileTemp : TFile_Data;
  i : Integer;
begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := openDialog.Options + [ofAllowMultiSelect];
  openDialog.Filter := 'All Files (*.*)|*.*';

  if openDialog.Execute then
  begin
    for i := 0 to openDialog.Files.Count - 1 do
    begin
      addressTemp  := openDialog.Files[i];
      fileNameTemp := ExtractFileName(openDialog.Files[i]);

      saveFileTemp := TFile_Data.Create;
      saveFileTemp.FData.Nama_File := fileNameTemp;
      saveFileTemp.FData.Directory_Path := addressTemp;

      FFileTransfer.Add(saveFileTemp);

      btnSend.Visible := True;
      btnSend.Enabled := True;
    end;
  end
  else
  ShowMessage('Save file was cancelled');

  openDialog.Free;
  UpdateFile;
end;

procedure TfrmToteDisplay.btnDeleteClick(Sender: TObject);
var
  fileDeleteTemp : string;
  warning        : Integer;
  fileTemp       : TFile_Data;

  i: Integer;
begin
   if lvFileTransfer.ItemIndex < 0  then
    Exit;

  warning := MessageDlg('Are you sure delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOk then
  begin
    if lvFileTransfer.ItemIndex = -1 then
    begin
      ShowMessage('No item selected.');
      Exit;
    end;

     fileDeleteTemp := lvFileTransfer.Items[lvFileTransfer.ItemIndex].Caption;

    for i := FFileTransfer.Count - 1 downto 0 do
    begin
      fileTemp := FFileTransfer[i];

      if fileTemp.FData.Nama_File = fileDeleteTemp then
      begin
        FFileTransfer.Delete(i);
        Break;
      end;
    end;

    lvFileTransfer.Items.Delete(lvFileTransfer.ItemIndex);

    UpdateFile;
  end;
end;

procedure TfrmToteDisplay.btnClearClick(Sender: TObject);
var
  warning       : Integer;
begin
  if MessageDlg('Are you sure you want to clear all items?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FFileTransfer.Clear;
    lvFileTransfer.Items.Clear;
    ShowMessage('All items have been cleared');
  end;

  UpdateFile;
end;

procedure TfrmToteDisplay.lvFileTransferSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  fileTemp : TFile_Data;
  SelectedItem : string;

  i : Integer;
begin
  FSelectedFileTransfer := nil;

  if Selected then
  begin
    if (Item = nil) or (item.Data = nil) then
    begin
      MessageDlg('File Corrupted', mtInformation, [mbOK], 0);
      Exit;
    end;

    FSelectedFileTransfer := TFile_Data(Item.Data);
    fileNameTemp := FSelectedFileTransfer.FData.Nama_File;
    AddressPath := FSelectedFileTransfer.FData.Directory_Path;
  end
end;

procedure TfrmToteDisplay.btnSendClick(Sender: TObject);
var
  SelectedConsoleName: string;
  ConsoleInfo  : TConsoleInfo;

  Item : TListItem;
  SelectedItem : string;

  openDialog   : TOpenDialog;
  fileDataTemp : TRecFile_Data;
  fileTemp     : TFile_Data;

  i: Integer;
begin
  openDialog := TOpenDialog.Create(Self);
  fileTemp := TFile_Data.Create;

  if cbbConsole.ItemIndex = -1 then
  begin
    ShowMessage('Select console name');
    Exit;
  end;

  if FSelectedFileTransfer = nil then
  begin
    ShowMessage('Select a file to send.');
    Exit;
  end;

  SelectedConsoleName := cbbConsole.Text;
  ConsoleInfo := TConsoleInfo(simMgrClient.SimConsole.ConsoleList.Objects[cbbConsole.ItemIndex]);

  fileNameTemp := FSelectedFileTransfer.FData.Nama_File;
  AddressPath := FSelectedFileTransfer.FData.Directory_Path;

  for i := 0 to FFileTransfer.Count -1 do
  begin
    fileTemp := FFileTransfer[i];

    if not (TDirectory.Exists(vGameDataSetting.FileTransfer + '\' +  simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\' + 'SEND')) then
    begin
      TDirectory.CreateDirectory(vGameDataSetting.FileTransfer + '\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\' + 'SEND');
    end;

    if CopyFile(PWideChar(addressTemp), PWideChar('\\' + SelectedUserRoleIP + '\' + vGameDataSetting.FileTransfer + '\' + simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleAcronim + ' - ' + simMgrClient.MyConsoleData.UserRoleData.FSubRoleData.SubRoleIdentifier + '\' + 'SEND' + '\' + fileNameTemp), False) then
    begin
      ShowMessage('File "' + fileNameTemp + '" successfully shared');
    end

    else
    begin
      ShowMessage('Failed to share file "' + fileNameTemp + '"');
    end;
  end;
end;

procedure TfrmToteDisplay.UpdateFile;
var
  i: Integer;
  li: TListItem;
  fileTemp : TFile_Data;
begin
  lvFileTransfer.Items.Clear;

  for i := 0 to FFileTransfer.Count -1 do
  begin
    fileTemp := TFile_Data(FFileTransfer.Items[i]);

    li := lvFileTransfer.Items.Add;
    li.Caption := fileTemp.FData.Nama_File;
    li.SubItems.Add(fileTemp.FData.Directory_Path);

    li.Data := fileTemp;
  end;
end;

procedure TfrmToteDisplay.CbbConsoleDestination(Sender: TObject);
var
  i : Integer;
  consoleInfoTemp : TConsoleInfo;
  userRoleTemp : TUserRole;
  subRoleTemp : TSubRole;
begin
  cbbConsole.Items.Clear;

  for i := 0 to simMgrClient.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrClient.SimConsole.ConsoleList.Objects[i]);

    userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.isInUse then
      begin
//        cbbConsole.Items.Add(consoleInfoTemp.ConsoleName);
        cbbConsole.Items.Add(userRoleTemp.FData.UserRoleAcronim);
      end
    end;
  end;
end;

procedure TfrmToteDisplay.cbbConsoleSelect(Sender: TObject);
var
  userRoleTemp : TUserRole;
  ipTemp : string;
begin
  if cbbconsole.ItemIndex = -1 then
    Exit;

  userRoleTemp := TUserRole(cbbconsole.Items.Objects[cbbconsole.ItemIndex]);
  SelectedUserRoleIP := userRoleTemp.ConsoleIP;
//  lblNamaFile.Caption := userRoleTemp.ConsoleIP;
end;

{$ENDREGION}
end.
