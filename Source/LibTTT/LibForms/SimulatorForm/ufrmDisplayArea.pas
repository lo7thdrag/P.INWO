unit ufrmDisplayArea;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Winapi.ShellAPI, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.WinXCalendars, AdvTimePickerDropDown, Vcl.FileCtrl,

  {Project Uses}
  uRecordData, uConstantaData, uSimMgr_Client, uT3SimManager, uClassData, ufrmVideoConference, ufrmSituationBoard,
  ufrmTelegram, uLibSetting, uSimContainers, ufrmSummaryUserRole, ufrmAvailableUserRole , UfrmMapEditor, ufrmSimbolTaktis,
   ufrmMapPreview;

type
  TfrmDisplayArea = class(TForm)
    pnlTop: TPanel;
    pnlLeft: TPanel;
    pnlCenter: TPanel;
    pnlMainCenter: TPanel;
    pnlMenejemenPengguna: TPanel;
    pnlMenejemenSimbolTaktis: TPanel;
    pnlMenejemenPeta: TPanel;
    pnlMenejemenReferensi: TPanel;
    imgMainBackground: TImage;
    pnlMainChatting: TPanel;
    pnlRight: TPanel;
    pnlMainBackground: TPanel;
    pnlLogout: TPanel;
    btnLogout: TSpeedButton;
    lblLogOut: TLabel;
    pnlResources: TPanel;
    pnlBottomResources: TPanel;
    pnlUserRole: TPanel;
    btnUserRole: TSpeedButton;
    lblUserRole: TLabel;
    pnlHeaderResouces: TPanel;
    SpeedButton3: TSpeedButton;
    lblResources: TLabel;
    pnlAsset: TPanel;
    btnAsset: TSpeedButton;
    lblAsset: TLabel;
    pnlTacticalSymbol: TPanel;
    btnTacticalSymbol: TSpeedButton;
    lblTacticalSymbol: TLabel;
    PnlMap: TPanel;
    btnMap: TSpeedButton;
    lblMap: TLabel;
    pnlReference: TPanel;
    SpeedButton7: TSpeedButton;
    lblReferensi: TLabel;
    pnlServices: TPanel;
    pnlBottomServices: TPanel;
    pnlOfficeEditor: TPanel;
    btnOfficeEditor: TSpeedButton;
    lblOfficeEditor: TLabel;
    pnlHeaderServices: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    pnlSituationBoard: TPanel;
    btnSituationBoard: TSpeedButton;
    lblSituationBoard: TLabel;
    pnlChatting: TPanel;
    btnChatting: TSpeedButton;
    lblChatting: TLabel;
    pnlTelegram: TPanel;
    btnTelegram: TSpeedButton;
    lblTelegram: TLabel;
    pnlVideoConference: TPanel;
    btnVideoConference: TSpeedButton;
    lblVideoConference: TLabel;
    mmoChat: TMemo;
    pnlSparatorchat: TPanel;
    pnlBottomChat: TPanel;
    btnSendChat: TButton;
    pnlHeaderChat: TPanel;
    btnMessageChat: TSpeedButton;
    btnCloseChat: TSpeedButton;
    btnUserChat: TSpeedButton;
    pnlMainOfficeEditor: TPanel;
    Panel5: TPanel;
    imgMsWord: TImage;
    imgMsExcel: TImage;
    imgMsPowerPoint: TImage;
    imgMsPaint: TImage;
    Label8: TLabel;
    Panel1: TPanel;
    SpeedButton4: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    edtChatBox: TEdit;
    imgChrome: TImage;
    Panel7: TPanel;
    pnlMyDesktop: TPanel;
    btnMyDesktop: TSpeedButton;
    lblMyDesktop: TLabel;
    pnlMenejemenBeranda: TPanel;
    pnlTopSide: TPanel;
    pnlSeparatorBawah: TPanel;
    pnlLogoHeader: TPanel;
    btnAOTC: TSpeedButton;
    lblOrganisasiTugas: TLabel;
    pnlSparatorAtas: TPanel;
    pnlListMyFile: TPanel;
    pnlMdmConsoleName: TPanel;
    Label2: TLabel;
    pnlHeaderMyDeskstop: TPanel;
    ilClientStateColor: TImageList;
    pnlCariPengguna: TPanel;
    pnlListPengguna: TPanel;
    cbbSearchType: TComboBox;
    cbbxFilterSearch: TComboBox;
    lblsearch: TLabel;
    lvUserRole: TListView;
    pnlCariReferensi: TPanel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    pnlListReferensi: TPanel;
    lvReferensi: TListView;
    pnlCariPeta: TPanel;
    Label9: TLabel;
    pnlListPeta: TPanel;
    lvGameArea: TListView;
    pnlCariSimbolTaktis: TPanel;
    Label10: TLabel;
    cbbSearchTipe: TComboBox;
    cbbFilterSearch: TComboBox;
    pnlListSImbolTaktis: TPanel;
    lvTacticalSymbol: TListView;
    lblConsoleName: TLabel;
    pnlMdmOrganisasiTugas: TPanel;
    Label12: TLabel;
    pnlMdmUserRole: TPanel;
    Label14: TLabel;
    lblKogas: TLabel;
    lblUserRoleIdentifier: TLabel;
    pnlMdmTahapan: TPanel;
    Label5: TLabel;
    lblTahapan: TLabel;
    lvFileData: TListView;
    pnlHeaderFileData: TPanel;
    Label3: TLabel;
    edtCari: TEdit;
    pnlMdmTools: TPanel;
    pnlSparMdm: TPanel;
    AdvWatch1: TAdvWatch;
    CalendarView1: TCalendarView;
    pnlMdmMainLeft: TPanel;
    pnlHeaderBeranda: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Memo1: TMemo;
    Label6: TLabel;
    pnlHeaderPengguna: TPanel;
    Label7: TLabel;
    pnlSparBottom: TPanel;
    pnlSparLeft: TPanel;
    pnlSparRight: TPanel;
    pnlHeaderReferensi: TPanel;
    Label13: TLabel;
    pnlHeaderSimbolTaktis: TPanel;
    Label15: TLabel;
    pnlHeaderPeta: TPanel;
    Label16: TLabel;
    lstUserChat: TListBox;
    imgUpload: TImage;
    imgDownload: TImage;
    imgHapus: TImage;
    edtSearch: TEdit;
    edtSearchMap: TEdit;
    btnAddMap: TImage;
    btnEditMap: TImage;
    btnDeleteMap: TImage;
    btnPreview: TImage;
    btnDownloadReferensi: TImage;
    btnUploadReferensi: TImage;
    btnRemoveReferensi: TImage;
    btnAddTacticalSymbol: TImage;
    btnEditTacticalSymbol: TImage;
    btnDeleteTacticalSymbol: TImage;
    edtTacticalSearch: TEdit;
    pnlRightTactical: TPanel;
    imgPreview: TImage;
    Image1: TImage;
    Label11: TLabel;
    pnlKeteranganGambar: TPanel;
    Label17: TLabel;
    lblKeterangan: TLabel;
    lblTipe: TLabel;
    lblKategori: TLabel;
    Image2: TImage;
    lblNamaGambar: TLabel;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    pnlMenejemenAsset: TPanel;
    pnlHeaderAsset: TPanel;
    Label18: TLabel;
    pnlCariAsset: TPanel;
    Label19: TLabel;
    btnAddAsset: TImage;
    btnEditAsset: TImage;
    btnDeleteAsset: TImage;
    editSearch: TEdit;
    cbbCariTipe: TComboBox;
    cbbFilterCari: TComboBox;
    pnlListAsset: TPanel;
    lvAsset: TListView;

    procedure btnAOTCClick(Sender: TObject);

    {$REGION ' Form Procedure '}
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    {$ENDREGION}

    {$REGION ' Beranda Procedure '}
    procedure BerandaClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);

    procedure lvFileDataSelectItem(Sender: TObject; Item: TListItem;Selected: Boolean);
    procedure pnlBerandaManajemenShow;
    procedure UpdateDataFile;
    {$ENDREGION}

    {$REGION ' Asset Procedure '}
    procedure AssetClick(Sender: TObject);
    procedure pnlAsetManajemenShow;
    procedure UpdateDataAset;
    {$ENDREGION}

    {$REGION ' Simbol Taktis Procedure '}
    procedure SimbolTaktisClick(Sender: TObject);
    procedure btnAddTacticalSymbolClick(Sender: TObject);
    procedure btnEditTacticalSymbolClick(Sender: TObject);
    procedure btnDeleteTacticalSymbolClick(Sender: TObject);
    procedure edtSearchKeyPressTactical(Sender: TObject; var Key: Char);

    procedure cbbFilterSearchSelect(Sender: TObject);
    procedure cbbSearchtipeSelect(Sender: TObject);
    procedure lvTacticalSymbolleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

    procedure pnlSimbolTaktisManajemenShow;
    procedure UpdateSimbolTaktis;
    {$ENDREGION}

    {$REGION ' Pengguna Procedure '}
    procedure PenggunaClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);

    procedure cbbxFilterSearchSelect(Sender: TObject);
    procedure cbbSearchTypeSelect(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure lvUserRoleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

    procedure pnlPenggunaManajemenShow;
    procedure UpdateDataPengguna;
    {$ENDREGION}

    {$REGION ' Peta Procedure '}
    procedure PetaClick(Sender: TObject);
    procedure btnAddMapClick(Sender: TObject);
    procedure btnEditMapClick(Sender: TObject);
    procedure btnDeleteMapClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure lvGameAreaSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure edtSearchMapKeyPress(Sender: TObject; var Key: Char);
    procedure DeleteGameAreaDirectory(const aPathName, aFileName: string);
    procedure pnlPetaManajemenShow;
    procedure UpdateGameAreaList;
    {$ENDREGION}

    {$REGION ' Referensi Procedure '}
    procedure ReferensiClick(Sender: TObject);

    procedure btnUploadReferensiClick(Sender: TObject);
    procedure btnDownloadReferensiClick(Sender: TObject);
    procedure pnlReferensiShow;
    procedure UpdateDataReferensi;
    {$ENDREGION}
    
    {$REGION ' Office Editor Procedure '}
    procedure OfficeEditorClick(Sender: TObject);
    procedure imgMsPaintClick(Sender: TObject);
    procedure imgMsPowerPointClick(Sender: TObject);
    procedure imgMsExcelClick(Sender: TObject);
    procedure imgMsWordClick(Sender: TObject);
    procedure imgChromeClick(Sender: TObject);

    procedure IconMenuMouseEnter(Sender: TObject);
    procedure IconMenuMouseLeave(Sender: TObject);
    procedure IconLoad;
    {$ENDREGION}

    {$REGION ' Situation Board Procedure '}
    procedure SituationBoardClick(Sender: TObject);
    {$ENDREGION}
    
    {$REGION ' Obrolan Procedure '}
    procedure ObrolanClick(Sender: TObject);
    procedure btnUserChatClick(Sender: TObject);
    procedure btnMessageChatClick(Sender: TObject);
    procedure btnCloseChatClick(Sender: TObject);
    procedure lstUserChatDblClick(Sender: TObject);

    {$ENDREGION}
     
    {$REGION ' Telegram Procedure '}
    procedure TelegramClick(Sender: TObject);
    {$ENDREGION}

    {$REGION ' Video Conference Procedure '}
    procedure VideoConferenceClick(Sender: TObject);
    {$ENDREGION}

    procedure LogOutClick(Sender: TObject);

    procedure btnSendChatClick(Sender: TObject);
    procedure lvReferensiSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnRemoveReferensiClick(Sender: TObject);
//    procedure LlvFileDataSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);

  private
    iconName : string;
    filePath, imgChoice : string;

    flagTable : Boolean;
    SearchName : string;
    ItemSearchIndex : Integer;

    FFileDataList : TList;
    FFileReferensiList : TList;
    FUserRoleList : TList;
    FGameAreaList : TList;
    FTacticalSymbolList : TList;
    FAssetList : TList;

    FSelectedPengguna : TUser_Role;
    FSelectedUserChat : TUser_Role;
    FSelectedFileBeranda : TFile_Data;
    FSelectedFileReferensi : TFile_Data;
    FSelectedGameArea : TGame_Area_Definition;
    FSelectedTacticalSymbol : TTactical_Symbol;

    procedure RoundCornerOf(Control: TWinControl; val1, val2: Integer);
    procedure AddSearchTypeItems;
    procedure AddSearchTacticalSymbolItems;

  public

    procedure UpdateClientChatting;
    procedure UpdateClientHistoryChat;

  end;

var
  frmDisplayArea: TfrmDisplayArea;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmDisplayArea.RoundCornerOf(Control: TWinControl; val1, val2: Integer);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, val1, val2);
    SetWindowRgn(Handle, Rgn, True) ;
    Invalidate
  end;
end;

procedure TfrmDisplayArea.btnAOTCClick(Sender: TObject);
begin
  if pnlLeft.Width > 50 then
  begin
    pnlLeft.Width := 50;
  end
  else
  begin
    pnlLeft.Width := 250;
  end;
end;

{$REGION ' Form Procedure '}

procedure TfrmDisplayArea.FormCreate(Sender: TObject);
begin
  EnableComposited(pnlMainBackground);
  EnableComposited(pnlTop);
  EnableComposited(pnlLeft);
  EnableComposited(pnlCenter);
  EnableComposited(pnlRight);

  RoundCornerOf(pnlMdmConsoleName, 15, 15);
  RoundCornerOf(pnlMdmOrganisasiTugas, 15, 15);
  RoundCornerOf(pnlMdmUserRole, 15, 15);
  RoundCornerOf(pnlMdmTahapan, 15, 15);

  FFileDataList := TList.Create;
//  FSelectedFileBeranda := TFile_Data.Create;
//  FSelectedFileBeranda := nil;

  FUserRoleList := TList.Create;
//  FSelectedPengguna := TUser_Role.Create;
//  FSelectedPengguna := nil;

  FGameAreaList := TList.Create;

  FFileReferensiList := TList.Create;
end;

procedure TfrmDisplayArea.FormDestroy(Sender: TObject);
begin
  FreeItemsAndFreeList(FFileDataList);
  FreeItemsAndFreeList(FUserRoleList);
  FreeItemsAndFreeList(FGameAreaList);
  FreeItemsAndFreeList(FFileReferensiList);
end;

procedure TfrmDisplayArea.FormShow(Sender: TObject);
begin
  pnlBerandaManajemenShow;
  pnlRight.Width := 0;
end;

{$ENDREGION}

{$REGION ' Beranda Procedure '}

procedure TfrmDisplayArea.BerandaClick(Sender: TObject);
begin
  pnlBerandaManajemenShow;
end;

procedure TfrmDisplayArea.pnlBerandaManajemenShow;
begin
  pnlMenejemenBeranda.BringToFront;

  with simMgrClient.MyConsoleData do
  begin
    lblConsoleName.Caption := Identifier;
    lblKogas.Caption := SetSubOrganisasiTugasToString(TSubOrganisasiTugas(UserRoleData.SubOrganisasiTugas));
    lblUserRoleIdentifier.Caption := UserRoleData.UserRoleIdentifier;
    lblTahapan.Caption := SetTipeTahapanToString(TTipeTahapan(TipeTahapan));
  end;

  CalendarView1.Date := Now;

  UpdateDataFile;
end;

procedure TfrmDisplayArea.btnDownloadClick(Sender: TObject);
var
  localDirTemp : String;
  serverDirTemp : String;
  localFileTemp : String;

begin
  if Assigned(FSelectedFileBeranda) then
  begin
    SelectDirectory('Select a directory', vGameDataSetting.LocalDirectory, localDirTemp);

    serverDirTemp := vGameDataSetting.FileDirectory + FSelectedFileBeranda.FData.Encripted_File_Name;
    localFileTemp := localDirTemp + '\' + FSelectedFileBeranda.FData.Nama_File;

    CopyFile(PWideChar(serverDirTemp), PWideChar(localFileTemp), False);
  end;

end;

procedure TfrmDisplayArea.btnUploadClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

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

    with fileDataTemp do
    begin
      Nama_File           := filNameTemp;
      Directory_Path      := vGameDataSetting.FileDirectory;
      Encripted_File_Name := '';
      Tipe_File           := ExtractFileExt(saveDialog.FileName);
      Modified_Date       := DateToStr(Now);
      Modified_By         := simMgrClient.MyConsoleData.UserRoleData.UserRoleIdentifier;
      id_User             := simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex;

      if dmINWO.InsertFile(fileDataTemp) then
      begin
        dmINWO.UpdateFile(fileDataTemp);
        ShowMessage('Data has been saved');
      end;
    end;

    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileDirectory + '\' + fileDataTemp.Encripted_File_Name), False);
  end
  else
    ShowMessage('Save file was cancelled');

  saveDialog.Free;

  UpdateDataFile;
end;

procedure TfrmDisplayArea.btnRemoveClick(Sender: TObject);
var
  warning : Integer;
  serverDirTemp : String;

begin
  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    if Assigned(FSelectedFileBeranda) then
    begin
      serverDirTemp := vGameDataSetting.FileDirectory + FSelectedFileBeranda.FData.Encripted_File_Name;

      with FSelectedFileBeranda.FData do
      begin
        if dmINWO.DeleteFile(ID_File) then
          ShowMessage('Data has been deleted');
      end;

      DeleteFile(serverDirTemp);
      FSelectedFileBeranda := nil;
    end;

    UpdateDataFile;
  end;
end;

procedure TfrmDisplayArea.lvFileDataSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  FSelectedFileBeranda := nil;

  if Selected then
  begin
    if (Item = nil) or (item.Data = nil) then
    begin
      MessageDlg('File Corrupted', mtInformation, [mbOK], 0);
      Exit;
    end;

    FSelectedFileBeranda := Item.Data;
  end
end;

procedure TfrmDisplayArea.UpdateDataFile;
var
  i : Integer;
  fileDataTemp : TFile_Data;
  li : TListItem;

begin
  lvFileData.Items.Clear;

  dmINWO.GetAllFile(FFileDataList);

  for i := 0 to FFileDataList.Count - 1 do
  begin
    fileDataTemp := FFileDataList.Items[i];
    li := lvFileData.Items.Add;
    li.SubItems.Add(fileDataTemp.FData.Nama_File);
    li.StateIndex := Integer(SetFileExtentionToEnum(fileDataTemp.FData.Tipe_File));
    li.SubItems.Add(fileDataTemp.FData.Directory_Path);
    li.SubItems.Add(fileDataTemp.FData.Modified_Date);
    li.SubItems.Add(fileDataTemp.FData.Modified_By);
    li.Data := fileDataTemp;
  end;
end;

{$ENDREGION}

{$REGION ' Asset Procedure '}

procedure TfrmDisplayArea.AssetClick(Sender: TObject);
begin
  pnlMenejemenAsset.BringToFront;
end;

procedure TfrmDisplayArea.pnlAsetManajemenShow;
begin
  pnlMenejemenAsset.BringToFront;
  UpdateDataAset
end;

procedure TfrmDisplayArea.UpdateDataAset;
var
  i : Integer;
  AssetTemp : TAsset;
  li: TListItem;
begin
  lvAsset.Items.Clear;

  if flagTable = true then
    dmINWO.GetAllVehicleDef(FAssetList);

  for i := 0 to FAssetList.Count - 1 do
  begin
    AssetTemp := FAssetList.Items[i];

    li := lvAsset.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(AssetTemp.FData.Vehicle_Identifier);
    li.SubItems.Add(IntToStr(AssetTemp.FData.Platform_Domain));
    li.SubItems.Add(IntToStr(AssetTemp.FData.Platform_Category));
  end;
end;


{$ENDREGION}

{$REGION ' Simbol Taktis Procedure '}

procedure TfrmDisplayArea.SimbolTaktisClick(Sender: TObject);
begin
  pnlSimbolTaktisManajemenShow;
end;

procedure TfrmDisplayArea.pnlSimbolTaktisManajemenShow;
begin
  pnlMenejemenSimbolTaktis.BringToFront;

  UpdateSimbolTaktis
end;

procedure TfrmDisplayArea.AddSearchTacticalSymbolItems;
begin
  if cbbFilterSearch.ItemIndex = 1 then
  begin
    cbbSearchTipe.Items.Clear;
    cbbSearchTipe.Items.Add('TAKTIS TNI AL');
    cbbSearchTipe.Items.Add('TAKTIS TNI AU');
    cbbSearchTipe.Items.Add('TAKTIS TNI AD');
  end
  else if cbbFilterSearch.ItemIndex = 2 then
  begin
    cbbSearchTipe.Items.Clear;
    cbbSearchTipe.Items.Add('PANGKALAN TNI AL');
    cbbSearchTipe.Items.Add('PANGKALAN TNI AU');
    cbbSearchTipe.Items.Add('PANGKALAN TNI AD');
  end;
end;

procedure TfrmDisplayArea.cbbSearchtipeSelect(Sender: TObject);
begin
  ItemSearchIndex := cbbFilterSearch.ItemIndex;
  SearchName := IntToStr(cbbSearchTipe.ItemIndex);
  flagTable := True;
  UpdateSimbolTaktis;
end;

procedure TfrmDisplayArea.cbbFilterSearchSelect(Sender: TObject);
begin
   cbbSearchTipe.ItemIndex := 0;

   if cbbFilterSearch.ItemIndex = 0 then
   begin
     edtTacticalSearch.Clear;
     flagTable := False;
     UpdateSimbolTaktis;
     edtTacticalSearch.BringToFront;
   end
   else if cbbFilterSearch.ItemIndex = 1 then
   begin
     AddSearchTacticalSymbolItems;
     cbbSearchTipe.BringToFront;
   end
   else if cbbFilterSearch.ItemIndex = 2 then
   begin
     AddSearchTacticalSymbolItems;
     cbbSearchTipe.BringToFront;
   end;
end;

procedure TfrmDisplayArea.UpdateSimbolTaktis;
var
  i : Integer;
  tacticalSymbolTemp : TTactical_Symbol;
  li : TListItem;
begin
  lvTacticalSymbol.Items.Clear;

  if flagTable = true then
     dmINWO.GetSearchTacticalSymbol(ItemSearchIndex, SearchName, FTacticalSymbolList)
  else
     dmINWO.GetAllTacticalSymbol(FTacticalSymbolList);

  for i := 0 to FTacticalSymbolList.Count -1 do
  begin
     tacticalSymbolTemp := FTacticalSymbolList.Items[i];

     li := lvTacticalSymbol.Items.Add;
     li.Caption := IntToStr(i+1);
     li.SubItems.Add(tacticalSymbolTemp.FData.Keterangan);
     li.SubItems.Add(IntToStr(tacticalSymbolTemp.FData.Tipe));
     li.SubItems.Add(IntToStr(tacticalSymbolTemp.FData.Kategori));

     li.Data := tacticalSymbolTemp;
  end;

end;

procedure TfrmDisplayArea.btnAddTacticalSymbolClick(Sender: TObject);
begin
  frmSimbolTaktis := TfrmSimbolTaktis.Create(Self);
  try
    with frmSimbolTaktis do
    begin
      SelectedTacticalSymbol := TTactical_Symbol.Create;
      ShowModal;
    end;
  finally
    frmSimbolTaktis.Free;
  end;
    UpdateSimbolTaktis;
end;

procedure TfrmDisplayArea.lvTacticalSymbolleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  imagepath :  string;
  serverDirTemp : String;
  localFileTemp : String;

begin
  FSelectedTacticalSymbol := nil;

  if Selected then
  begin
    if (Item = nil) or (Item.Data = nil) then
      Exit;

    FSelectedTacticalSymbol := TTactical_Symbol(lvTacticalSymbol.Selected.Data);

    imagepath := FSelectedTacticalSymbol.FData.Path_Directori + '\' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.jpg';
    if FileExists(imagepath) then
    begin
      imgPreview.Picture.LoadFromFile(imagepath);
      pnlRightTactical.Visible := True;
    end
    else
    begin
        ShowMessage('File gambar tidak ditemukan' + imagepath);
    end;

    lblNamaGambar.Caption := 'Nama Gambar: ' + IntToStr(FSelectedTacticalSymbol.FData.Id_Tactical_Symbol) + '.jpg';
    lblKeterangan.Caption := 'Keterangan: ' + Item.SubItems[0];
    lblTipe.Caption       := 'Tipe: ' + Item.SubItems[1];
    lblKategori.Caption   := 'Kategori: ' + Item.SubItems[2];
  end;
end;

procedure TfrmDisplayArea.btnEditTacticalSymbolClick(Sender: TObject);
begin
   if lvTacticalSymbol.ItemIndex <> -1 then
   begin
      frmSimbolTaktis := TfrmSimbolTaktis.Create(Self);
      try
        with frmSimbolTaktis do
        begin
          SelectedTacticalSymbol := FSelectedTacticalSymbol;
          ShowModal;
        end;
      finally
         frmSimbolTaktis.Free;
      end;
   end;

   UpdateSimbolTaktis;

end;

procedure TfrmDisplayArea.btnDeleteTacticalSymbolClick(Sender: TObject);
var
  warning: Integer;
begin
   if lvTacticalSymbol.ItemIndex <> -1  then
   begin
     warning := MessageDlg('Are you sure delete this item?', mtConfirmation, mbOKCancel, 0);

     if warning = mrOK then
     begin
       with FSelectedTacticalSymbol.FData do
       begin
         if dmINWO.DeleteTacticalSymbol(Id_Tactical_Symbol)then
             ShowMessage('Data has been deleted');
       end;

       UpdateSimbolTaktis;

     end;
   end;
end;

procedure TfrmDisplayArea.edtSearchKeyPressTactical(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (edtTacticalSearch.Text <> '') and (cbbFilterSearch.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbFilterSearch.ItemIndex;
      SearchName := edtTacticalSearch.Text;
      flagTable := true;
      UpdateSimbolTaktis;
    end
    else if edtTacticalSearch.Text = '' then
    begin
      flagTable := false;
      UpdateSimbolTaktis;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Pengguna Procedure '}

procedure TfrmDisplayArea.PenggunaClick(Sender: TObject);
begin
  pnlPenggunaManajemenShow;
end;

procedure TfrmDisplayArea.pnlPenggunaManajemenShow;
begin
  pnlMenejemenPengguna.BringToFront;
  UpdateDataPengguna
end;

procedure TfrmDisplayArea.UpdateDataPengguna;
var
  i : Integer;
  userRoleTemp : TUser_Role;
  li : TListItem;

begin
  lvUserRole.Items.Clear;

  if flagTable = true then
    dmINWO.GetSearchUserRole(ItemSearchIndex, SearchName, FUserRoleList)
  else
    dmINWO.GetAllUserRole(FUserRoleList);

  for i := 0 to FUserRoleList.Count - 1 do
  begin
    userRoleTemp := FUserRoleList.Items[i];
    li := lvUserRole.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(userRoleTemp.FData.UserRoleIdentifier);
    li.SubItems.Add(SetOrganisasiTugasAkronimToString(TOrganisasiTugas(userRoleTemp.FData.OrganisasiTugas)));
    li.SubItems.Add(SetSubOrganisasiTugasToString(TSubOrganisasiTugas(userRoleTemp.FData.SubOrganisasiTugas)));

    if userRoleTemp.FData.Perencanaan = 1 then
      li.SubItems.Add('✔')
    else
      li.SubItems.Add('❌');

    if userRoleTemp.FData.Persiapan = 1 then
      li.SubItems.Add('✔')
    else
      li.SubItems.Add('❌');

    if userRoleTemp.FData.Pelaksanaan = 1 then
      li.SubItems.Add('✔')
    else
      li.SubItems.Add('❌');

    if userRoleTemp.FData.Pengakhiran = 1 then
      li.SubItems.Add('✔')
    else
      li.SubItems.Add('❌');

    li.Data := userRoleTemp;
  end;
end;

procedure TfrmDisplayArea.AddSearchTypeItems ;
begin
   if cbbxFilterSearch.ItemIndex = 2 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('INWO');
    cbbSearchType.Items.Add('NTWO');
    cbbSearchType.Items.Add('ATWO');
    cbbSearchType.Items.Add('LFWO');
    cbbSearchType.Items.Add('ALWO');
    cbbSearchType.Items.Add('CDWO');
    cbbSearchType.Items.Add('SUWO');
  end
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    cbbSearchType.Items.Clear;
    cbbSearchType.Items.Add('KPL');
    cbbSearchType.Items.Add('STAFLAT');
    cbbSearchType.Items.Add('WASDAL');
    cbbSearchType.Items.Add('KOGAB');
    cbbSearchType.Items.Add('KOGASGABLA');
    cbbSearchType.Items.Add('KOGASGABFIB');
    cbbSearchType.Items.Add('PASRAT');
    cbbSearchType.Items.Add('KOGASRATMIN');
    cbbSearchType.Items.Add('KOGASHANTAI');
    cbbSearchType.Items.Add('SATGASDUK');
  end;
end;

procedure TfrmDisplayArea.btnAddClick(Sender: TObject);
begin
  frmSummaryUserRole := TfrmSummaryUserRole.Create(self) ;
  try
    with frmSummaryUserRole do
    begin
      SelectedUserRole := TUser_Role.Create;
      ShowModal;
      SelectedUserRole.Free;
    end;
  finally
    frmSummaryUserRole.Free
  end;

  UpdateDataPengguna;
end;

procedure TfrmDisplayArea.btnEditClick(Sender: TObject);
begin
 if lvUserRole.ItemIndex <> -1 then
  begin
    frmSummaryUserRole := TfrmSummaryUserRole.Create(Self);
    try
      with frmSummaryUserRole do
      begin
        SelectedUserRole := FSelectedPengguna;
        ShowModal;
//        FUpdateList := AfterClose;
      end;
    finally
      frmSummaryUserRole.Free;
    end;

//    if FUpdateList then
      UpdateDataPengguna;
  end;
end;

procedure TfrmDisplayArea.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
begin
  if lvUserRole.ItemIndex <> -1 then
  begin
    warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

    if warning = mrOK then
    begin
      with FSelectedPengguna.FData do
      begin
        if dmINWO.DeleteUserRole(UserRoleIndex) then
          ShowMessage('Data has been deleted');
      end;

      UpdateDataPengguna;
    end;
  end;
end;

procedure TfrmDisplayArea.lvUserRoleSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected  then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedPengguna := TUser_Role(lvUserRole.Selected.Data);
  end;
end;

procedure TfrmDisplayArea.cbbSearchTypeSelect(Sender: TObject);
begin
  ItemSearchIndex := cbbxFilterSearch.ItemIndex;
  SearchName := IntToStr(cbbSearchType.ItemIndex);
  flagTable := true;
  UpdateDataPengguna;
end;

procedure TfrmDisplayArea.cbbxFilterSearchSelect(Sender: TObject);
begin
  cbbSearchType.ItemIndex := 0;

  if cbbxFilterSearch.ItemIndex = 0 then
  begin
    edtSearch.Clear;
    flagTable := false;
    UpdateDataPengguna;
    edtSearch.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 1 then
  begin
    edtSearch.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 2 then
  begin
    AddSearchTypeItems;
    cbbSearchType.BringToFront;
  end
  else if cbbxFilterSearch.ItemIndex = 3 then
  begin
    AddSearchTypeItems;
    cbbSearchType.BringToFront;
  end;
end;

procedure TfrmDisplayArea.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (edtSearch.Text <> '') and (cbbxFilterSearch.ItemIndex > 0) then
    begin
      ItemSearchIndex := cbbxFilterSearch.ItemIndex;
      SearchName := edtSearch.Text;
      flagTable := true;
      UpdateDataPengguna;
    end
    else if edtSearch.Text = '' then
    begin
      flagTable := false;
      UpdateDataPengguna;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Peta Procedure '}

procedure TfrmDisplayArea.PetaClick(Sender: TObject);
begin
  pnlPetaManajemenShow;
end;

procedure TfrmDisplayArea.pnlPetaManajemenShow;
begin
  pnlMenejemenPeta.BringToFront;

  UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnAddMapClick(Sender: TObject);
begin
  frmMapEditor := TfrmMapEditor.Create(Self);
  try
    with frmMapEditor do
    begin
      SelectedGameArea := TGame_Area_Definition.Create;
      SelectedGameArea.FData.Detail_Map := 'ENC';
      ShowModal;
//      FUpdateList := AfterClose;
    end;
  finally
    frmMapEditor.Free;
  end;

//  if FUpdateList then
    UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnEditMapClick(Sender: TObject);
begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  frmMapEditor := TfrmMapEditor.Create(Self);
  try
    with frmMapEditor do
    begin
      SelectedGameArea := FSelectedGameArea;
      ShowModal;
//      FUpdateList := AfterClose;
    end;
  finally
    frmMapEditor.Free;
  end;

//  if FUpdateList then
    UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnPreviewClick(Sender: TObject);
begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  frmMapPreview := TfrmMapPreview.Create(Self);
  try
    with frmMapPreview do
    begin
      SelectedGameArea := FSelectedGameArea;
      ShowModal;
    end;
  finally
    frmMapPreview.Free;
  end;

end;

procedure TfrmDisplayArea.btnDeleteMapClick(Sender: TObject);
var
  warning : Integer;
  tempList : TList;
  MapDirPath : string;

begin
  if lvGameArea.ItemIndex = -1 then
  begin
    ShowMessage('Select Game Area !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this Game Area ?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedGameArea.FData do
    begin
      {Pengecekan Relasi Dengan Tabel Game Environment Definition}
      tempList := TList.Create;

      MapDirPath := vGameAreaSetting.MapGSTGame + '\' + Game_Area_Identifier;
      DeleteGameAreaDirectory(MapDirPath, MapDirPath);

      if dmINWO.DeleteGameAreaDef(Game_Area_Index) then
        ShowMessage('Data has been deleted');
    end;

    UpdateGameAreaList;
  end;
end;

procedure TfrmDisplayArea.lvGameAreaSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected  then
  begin
    if (Item = nil) or (item.Data = nil) then
      Exit;

    FSelectedGameArea := TGame_Area_Definition(lvGameArea.Selected.Data);
  end;
end;

procedure TfrmDisplayArea.edtSearchMapKeyPress(Sender: TObject; var Key: Char);
var
  i : Integer;
  gameArea : TGame_Area_Definition;
begin
  if Key = #13 then
  begin
    UpdateGameAreaList
  end;
end;

procedure TfrmDisplayArea.UpdateGameAreaList;
var
  i : Integer;
  gameAreaTemp : TGame_Area_Definition;
  li : TListItem;

begin
  lvGameArea.Items.Clear;

  if edtSearchMap.Text <> '' then
  begin
    dmINWO.GetFilterGameAreaDef(FGameAreaList, edtSearchMap.Text)
  end
  else if edtSearch.Text = '' then
  begin
    dmINWO.GetAllGameAreaDef(FGameAreaList);
  end;

  for i := 0 to FGameAreaList.Count - 1 do
  begin
    gameAreaTemp := FGameAreaList.Items[i];
    li := lvGameArea.Items.Add;
    li.Caption := IntToStr(i+1);
    li.SubItems.Add(gameAreaTemp.FData.Game_Area_Identifier);
    li.Data := gameAreaTemp;
  end;

end;

procedure TfrmDisplayArea.DeleteGameAreaDirectory(const aPathName,aFileName: string);
var
  F : TSearchRec;
begin
  if FindFirst(aFileName + '*.*', faAnyFile, F) = 0 then
  begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then
        begin
          if (F.Name <> '.') and (F.Name <> '..') then
            DeleteGameAreaDirectory(aPathName, aFileName + '\' + F.Name);
        end
        else
          DeleteFile(aPathName + '\' + F.Name);
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;

    RemoveDir(aPathName);
  end;
end;

{$ENDREGION}

{$REGION ' Referensi Procedure '}

procedure TfrmDisplayArea.ReferensiClick(Sender: TObject);
begin
  pnlReferensiShow
end;

procedure TfrmDisplayArea.pnlReferensiShow;
begin
  pnlMenejemenReferensi.BringToFront;

  UpdateGameAreaList;
end;

procedure TfrmDisplayArea.btnDownloadReferensiClick(Sender: TObject);
var
  localDirTemp : String;
  serverDirTemp : String;
  localFileTemp : String;

begin
  if Assigned(FSelectedFileReferensi) then
  begin
    SelectDirectory('Select a directory', vGameDataSetting.LocalDirectory, localDirTemp);

    serverDirTemp := vGameDataSetting.FileReferensi + FSelectedFileReferensi.FData.Encripted_File_Name;
    localFileTemp := localDirTemp + '\' + FSelectedFileReferensi.FData.Nama_File;

    CopyFile(PWideChar(serverDirTemp), PWideChar(localFileTemp), False);
  end;
end;

procedure TfrmDisplayArea.btnUploadReferensiClick(Sender: TObject);
var
  addressTemp : PWideChar;
  filNameTemp : string;
  saveDialog : TSaveDialog;
  saveFileTemp : TFile_Data;
  fileDataTemp : TRecFile_Data;

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

    with fileDataTemp do
    begin
      Nama_File           := filNameTemp;
      Directory_Path      := vGameDataSetting.FileReferensi;
      Encripted_File_Name := '';
      Tipe_File           := ExtractFileExt(saveDialog.FileName);
      Modified_Date       := DateToStr(Now);
      Modified_By         := simMgrClient.MyConsoleData.UserRoleData.UserRoleIdentifier;
      id_User             := simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex;

      if dmINWO.InsertReferensi(fileDataTemp) then
      begin
        dmINWO.UpdateFile(fileDataTemp);
        ShowMessage('Data has been saved');
      end;
    end;

    CopyFile(addressTemp, PWideChar(vGameDataSetting.FileReferensi + fileDataTemp.Encripted_File_Name), False);
  end
  else
    ShowMessage('Save file was cancelled');

  saveDialog.Free;

  UpdateDataFile;
end;

procedure TfrmDisplayArea.btnRemoveReferensiClick(Sender: TObject);
var
  warning : Integer;
  serverDirTemp : String;

begin
  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    if Assigned(FSelectedFileReferensi) then
    begin
      serverDirTemp := vGameDataSetting.FileDirectory + FSelectedFileReferensi.FData.Encripted_File_Name;

      with FSelectedFileReferensi.FData do
      begin
        if dmINWO.DeleteReferensi(ID_File) then
          ShowMessage('Data has been deleted');
      end;

      DeleteFile(serverDirTemp);
      FSelectedFileReferensi := nil;
    end;

    UpdateDataFile;
  end;
end;

procedure TfrmDisplayArea.lvReferensiSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  FSelectedFileReferensi := nil;

  if Selected then
  begin
    if (Item = nil) or (item.Data = nil) then
    begin
      MessageDlg('File Corrupted', mtInformation, [mbOK], 0);
      Exit;
    end;

    FSelectedFileReferensi := Item.Data;
  end
end;

procedure TfrmDisplayArea.UpdateDataReferensi;
var
  i : Integer;
  fileDataTemp : TFile_Data;
  li : TListItem;

begin
  lvFileData.Items.Clear;

  dmINWO.GetAllFile(FFileDataList);

  for i := 0 to FFileDataList.Count - 1 do
  begin
    fileDataTemp := FFileDataList.Items[i];
    li := lvFileData.Items.Add;
    li.SubItems.Add(fileDataTemp.FData.Nama_File);
    li.StateIndex := Integer(SetFileExtentionToEnum(fileDataTemp.FData.Tipe_File));
    li.SubItems.Add(fileDataTemp.FData.Directory_Path);
    li.SubItems.Add(fileDataTemp.FData.Modified_Date);
    li.SubItems.Add(fileDataTemp.FData.Modified_By);
    li.Data := fileDataTemp;
  end;
end;

{$ENDREGION}

{$REGION ' Office Editor Procedure '}

procedure TfrmDisplayArea.OfficeEditorClick(Sender: TObject);
begin
  pnlRight.Width := 130;
  pnlMainOfficeEditor.BringToFront;
end;

procedure TfrmDisplayArea.IconLoad;
begin
  if iconName = 'imgMsWord' then
  begin
    imgMsWord.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsExcel' then
  begin
    imgMsExcel.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsPowerPoint' then
  begin
    imgMsPowerPoint.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgMsPaint' then
  begin
    imgMsPaint.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
  else if iconName = 'imgChrome' then
  begin
    imgChrome.Picture.LoadFromFile(filePath + iconName + imgChoice);
  end
end;

procedure TfrmDisplayArea.IconMenuMouseEnter(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '_Select.png';

  IconLoad;
end;

procedure TfrmDisplayArea.IconMenuMouseLeave(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '.png';

  IconLoad;
end;

procedure TfrmDisplayArea.imgMsExcelClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('EXCEL'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsPaintClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('mspaint'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsPowerPointClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('POWERPNT'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgMsWordClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('WINWORD'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

procedure TfrmDisplayArea.imgChromeClick(Sender: TObject);
begin
  try
    ShellExecute(Handle, 'open', PWideChar('chrome'), nil, nil, SW_SHOW) ;
  except
    Exception.Create('Error');
  end;
end;

{$ENDREGION}

{$REGION ' Situation Board Procedure '}

procedure TfrmDisplayArea.SituationBoardClick(Sender: TObject);
begin
  frmSituationBoard.Show;
//  frmSituationBoard := TfrmSituationBoard.Create(Self);
//  try
//    with frmSituationBoard do
//    begin
//      Show;
//    end;
//
//  finally
//    frmSituationBoard.Free;
//  end;
end;

{$ENDREGION}

{$REGION ' Obrolan Procedure '}

procedure TfrmDisplayArea.ObrolanClick(Sender: TObject);
begin
  pnlRight.Width := 430;
  pnlMainChatting.BringToFront;
end;

procedure TfrmDisplayArea.btnCloseChatClick(Sender: TObject);
begin
  pnlRight.Width := 0;
end;

procedure TfrmDisplayArea.btnMessageChatClick(Sender: TObject);
begin
  mmoChat.BringToFront;
end;

procedure TfrmDisplayArea.btnUserChatClick(Sender: TObject);
begin
  lstUserChat.BringToFront;

end;

procedure TfrmDisplayArea.lstUserChatDblClick(Sender: TObject);
begin
  if lstUserChat.ItemIndex = -1 then
    Exit;

  FSelectedUserChat := TUser_Role(lstUserChat.Items.Objects[lstUserChat.ItemIndex]);
end;

procedure TfrmDisplayArea.UpdateClientHistoryChat;
var
tempList : TList;
i : Integer;
chattingTemp : TChatting;
userRoleTemp : TUser_Role;
namaRole : string;
begin
  tempList := TList.Create;

  SimManager.SimChatting.GetChattingBySending(simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex, FSelectedUserChat.FData.UserRoleIndex, tempList);

  for i := 0 to tempList.Count - 1 do
  begin
    chattingTemp := tempList.Items[i];

    if chattingTemp.IdUserRoleReceive = simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex then
    begin
      mmoChat.Font.Color := clBlack;
      mmoChat.Lines.Add('You :');
    end
    else
    begin
      mmoChat.Font.Color := clBlue;
      mmoChat.Lines.Add(FSelectedUserChat.FData.UserRoleIdentifier + ' :');
    end;

      mmoChat.Lines.Add('/n');
      mmoChat.Lines.Add(chattingTemp.ChatMessage);
      mmoChat.Lines.Add('/n');


//    userRoleTemp := SimUserRole.getUserRoleByID(rec.UserRoleId);
//    mmoChat.Lines.Add(chattingTemp.IdUserRoleReceive, chattingTemp.ChatMessage);
//    mmoChat.Lines.Add(IntToStr(chattingTemp.IdUserRoleSending));
//    mmoChat.Lines.Add(IntToStr(chattingTemp.IdUserRoleReceive));
//    mmoChat.Lines.Add(chattingTemp.ChatMessage);
  end;
end;

procedure TfrmDisplayArea.btnSendChatClick(Sender: TObject);
var
//i : Integer;
rec : TRecTCPSendChatUserRole;
begin
   rec.OrderID := 0;
   rec.SenderUserRoleId := simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex;
   rec.ReceiverUserRoleId := FSelectedUserChat.FData.UserRoleIndex;
   rec.ChatMessage := edtChatBox.Text;

   simMgrClient.netSend_CmdSendMessage(rec);
end;

procedure TfrmDisplayArea.UpdateClientChatting;
var
  i : Integer;
  userRoleTemp : TUser_Role;
begin
  lstUserChat.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count - 1 do
  begin
    userRoleTemp := simMgrClient.SimUserRole.UserList[i];
    if Assigned(userRoleTemp) then
    begin
      lstUserChat.Items.AddObject(userRoleTemp.FData.UserRoleIdentifier, userRoleTemp);
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Telegram Procedure '}

procedure TfrmDisplayArea.TelegramClick(Sender: TObject);
begin
  frmTelegram := TfrmTelegram.Create(Self);
  try
    with frmTelegram do
    begin
      ShowModal;
    end;

  finally
    frmTelegram.Free;
  end;
end;

{$ENDREGION}

{$REGION ' Video Conference Procedure '}

procedure TfrmDisplayArea.VideoConferenceClick(Sender: TObject);
begin
  frmVideoConference := TfrmVideoConference.Create(Self);
  try
    with frmVideoConference do
    begin
      ShowModal;
    end;

  finally
    frmVideoConference.Free;
  end;
end;

{$ENDREGION}

procedure TfrmDisplayArea.LogOutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex;
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    rec.UserRoleInUse := False;

    simMgrClient.netSend_CmdUserState(rec);
  end;

  Close;
end;

end.
