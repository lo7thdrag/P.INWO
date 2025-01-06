unit ufrmToteDisplay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,

  ufrmFileManager, uClassData, uRecordData, uSimMgr_Client, uDataModule, uLibSetting, ufrmSummaryUserRole,
  Vcl.Imaging.pngimage;

type
  TfrmToteDisplay = class(TForm)
    pnlMain: TPanel;
    lvConsoleList: TListView;
    lblConcoleList: TLabel;
    Panel2: TPanel;
    lblFileTransfer: TLabel;
    btnLogout: TButton;
    btnSend: TButton;
    pnlConsole: TPanel;
    pnlFileTransfer: TPanel;
    lvFileTransfer: TListView;
    Image1: TImage;
    pnllvFileTransfer: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    cbbConsole: TComboBox;

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
    procedure UpdateFileTransfer;
    procedure CbbConsoleDestination(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure FileTransferClick(Sender: TObject);
    {$ENDREGION}
  private
    FConsoleList  : TList;
    FFileTransfer : TList;

    FSelectedConsole : TUserRole;
    FSelectedFile    : TFile_Data;
  public
    AddressPath  : string;
    FileListName : string;

    procedure Initialize;
  end;

var
  frmToteDisplay: TfrmToteDisplay;

implementation

{$R *.dfm}

{$REGION 'Console List'}
procedure TfrmToteDisplay.ConsoleListClick(Sender: TObject);
begin
  pnlConsoleListManajemenShow;
end;

procedure TfrmToteDisplay.pnlConsoleListManajemenShow;
begin
  pnlConsole.BringToFront;

//  UpdateConsoleList;
end;

procedure TfrmToteDisplay.UpdateConsoleList;
var
  i : Integer;
  consoleListTemp : TUserRole;
  li : TListItem;
begin
  lvConsoleList.Items.Clear;

  for i := 0 to FConsoleList.Count -1 do
  begin
    consoleListTemp := FConsoleList.Items[i];

    li.SubItems.Add(consoleListTemp.FData.Username);
    li.SubItems.Add(consoleListTemp.FData.UserRoleAcronim);
    li.SubItems.Add(consoleListTemp.FData.UserRoleIdentifier);

    li.Data := consoleListTemp;
  end;
end;

procedure TfrmToteDisplay.lvConsoleListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   if Selected then
   begin
     if (Item = nil) or (Item.Data = nil) then
     begin
      btnLogout.Visible := False;
      Exit;
     end;

     FSelectedConsole := TUserRole(lvConsoleList.Selected.Data);
//     FSelectedConsole := Item.Data;
     btnLogout.Visible := True;
   end;
end;

procedure TfrmToteDisplay.btnLogoutClick(Sender: TObject);
begin
  if lvConsoleList.ItemIndex <> -1 then
  begin
    Close;
  end;
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
  width := Screen.Monitors[vGameDataSetting.ToteScreen].width;
  height := Screen.Monitors[vGameDataSetting.ToteScreen].height;
  left := Screen.Monitors[vGameDataSetting.ToteScreen].left;
  top := Screen.Monitors[vGameDataSetting.ToteScreen].top;
end;

procedure TfrmToteDisplay.pnlFileTransferManajemenShow;
begin
  pnlFileTransfer.BringToFront;

//  UpdateFileTransfer;
end;

procedure TfrmToteDisplay.UpdateFileTransfer;
var
  i : Integer;
  FileListTemp : TFile_Data;
  li : TListItem;
begin
  lvFileTransfer.Items.Clear;

  dmINWO.GetAllFileByUserRoleId(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, FFileTransfer);

  for i := 0 to FFileTransfer.Count -1 do
  begin
    FileListTemp := FFileTransfer.Items[i];

    li.SubItems.Add(FileListTemp.FData.Nama_File);

    li.Data := FileListTemp;
  end;
end;

procedure TfrmToteDisplay.lvFileTransferSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   if Selected then
   begin
     if (Item = nil) or (Item.Data = nil) then
     begin
        btnSend.Visible := False;
        Exit;
     end;

     FSelectedFile := TFile_Data(lvFileTransfer.Selected.Data);
//     FSelectedFile := Item.Data;
     btnSend.Visible := True;
   end;
end;

procedure TfrmToteDisplay.btnSendClick(Sender: TObject);
begin
  if lvFileTransfer.ItemIndex <> -1 then
  begin
    CopyFile(PWideChar(AddressPath), PWideChar(vGameDataSetting.FileTransfer + FileListName), False);
  end;

end;

procedure TfrmToteDisplay.CbbConsoleDestination(Sender: TObject);
begin
  if cbbConsole.ItemIndex = 0 then
  cbbConsole.ItemIndex := 0;

  btnSend.Enabled := True;
end;

{$ENDREGION}
end.
