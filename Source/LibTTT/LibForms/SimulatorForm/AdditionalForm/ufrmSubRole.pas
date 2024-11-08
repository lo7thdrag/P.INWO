unit ufrmSubRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uDataModule;

type
  TfrmSubRole = class(TForm)
    btnCancel: TImage;
    btnOk: TImage;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnlSubRole: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    cbbOrganisasiTugas: TComboBox;
    chkPelaksanaan: TCheckBox;
    chkPengakhiran: TCheckBox;
    chkPerencanaan: TCheckBox;
    chkPersiapan: TCheckBox;
    edtSubOrganisasiTugas: TEdit;
    lstSubRole: TListBox;
    btnNew: TImage;
    btnEdit: TImage;
    btnDelete: TImage;
    Label1: TLabel;
    edtIdentifier: TEdit;
    btnClose: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

    procedure UpdateListSubRole;
    procedure lstSubRoleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonOkClick(Sender: TObject);

  private
    FSelectedSubRole : TSubRole;
    FSubRoleList : TList;

    function CekInput: Boolean;
    procedure SetAvailableSize;
    procedure SetSummarySize;

  public
    { Public declarations }
     LastName : string;
  end;

var
  frmSubRole: TfrmSubRole;

implementation

{$R *.dfm}

{ TfrmSubRole }


procedure TfrmSubRole.btnCancelClick(Sender: TObject);
begin
  SetAvailableSize;
end;

procedure TfrmSubRole.btnEditClick(Sender: TObject);
begin
  if lstSubRole.ItemIndex <> -1 then
  begin
    SetSummarySize;

    if Assigned(FSelectedSubRole) then
    begin
      cbbOrganisasiTugas.ItemIndex := FSelectedSubRole.FData.RoleIndex;
      edtSubOrganisasiTugas.Text := FSelectedSubRole.FData.SubRoleAcronim;
      edtIdentifier.Text := FSelectedSubRole.FData.SubRoleIdentifier;
      chkPerencanaan.Checked := FSelectedSubRole.FData.Perencanaan = 1;
      chkPersiapan.Checked := FSelectedSubRole.FData.Persiapan = 1;
      chkPelaksanaan.Checked := FSelectedSubRole.FData.Pelaksanaan = 1;
      chkPengakhiran.Checked := FSelectedSubRole.FData.Pengakhiran = 1;
    end;
  end;
end;

procedure TfrmSubRole.btnNewClick(Sender: TObject);
begin
  SetSummarySize;

  cbbOrganisasiTugas.ItemIndex := -1;
  edtSubOrganisasiTugas.Text := '';
  edtIdentifier.Text := '';
  chkPerencanaan.Checked := False;
  chkPersiapan.Checked := False;
  chkPelaksanaan.Checked := False;
  chkPengakhiran.Checked := False;
end;

procedure TfrmSubRole.buttonOkClick(Sender: TObject);
begin
  FSelectedSubRole := TSubRole.Create;

  with FSelectedSubRole do
  begin
    if not CekInput then
    begin
      ShowMessage('Incomplete data input');
      Exit;
    end;

    {$REGION ' General '}
    LastName := edtSubOrganisasiTugas.Text;
    FData.RoleIndex := cbbOrganisasiTugas.ItemIndex;
    FData.SubRoleAcronim := edtSubOrganisasiTugas.Text;
    FData.SubRoleIdentifier := edtIdentifier.Text;
    FData.Perencanaan := Ord(chkPerencanaan.Checked);
    FData.Persiapan := ord(chkPersiapan.Checked);
    FData.Pelaksanaan := ord(chkPelaksanaan.Checked);
    FData.Pengakhiran := ord(chkPengakhiran.Checked);
    {$ENDREGION}

    if FData.SubRoleIndex = 0 then
    begin
      if dmINWO.InsertSubRole(FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateSubRole(FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  FSelectedSubRole.Free;

  UpdateListSubRole;
  SetAvailableSize;
end;

function TfrmSubRole.CekInput;
var
  i, chkSpace, numSpace: Integer;
  checkedCount: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtSubOrganisasiTugas.Text = '') or (edtIdentifier.Text = '') then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  if cbbOrganisasiTugas.ItemIndex = -1 then
  begin
    ShowMessage('Cek ulang tipe anda');
    Exit;
  end;

  checkedCount := 0;

  if chkPersiapan.Checked then Inc(CheckedCount);
  if chkPerencanaan.Checked then Inc(CheckedCount);
  if chkPelaksanaan.Checked then Inc(CheckedCount);
  if chkPengakhiran.Checked then Inc(CheckedCount);

  if checkedCount > 1 then
  begin
      ShowMessage('Cek ulang tipe anda');
    Exit;
  end;


  {Jika berisi spasi semua}
  if Copy(edtSubOrganisasiTugas.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtSubOrganisasiTugas.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtSubOrganisasiTugas.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetSubRoleByName(edtSubOrganisasiTugas.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedSubRole.FData.RoleIndex = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtSubOrganisasiTugas.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;


procedure TfrmSubRole.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSubRole.btnDeleteClick(Sender: TObject);
var
  selectedListSubRole: Integer;
begin
  if lstSubRole.ItemIndex = -1 then
    Exit;

  if Assigned(FSelectedSubRole) then
  begin
    if dmINWO.GetRoleInSubRole(FSelectedSubRole.FData.RoleIndex) > 0 then
    begin
      ShowMessage('Cannot delete, because is already in used by another Sub Role');
      Exit;
    end;

    if dmINWO.DeleteSubRole(FSelectedSubRole.FData.RoleIndex) then
    begin
      ShowMessage('Data has been deleted');
    end;

    UpdateListSubRole;
  end;
end;

procedure TfrmSubRole.FormCreate(Sender: TObject);
begin
  FSubRoleList := TList.Create;
end;

procedure TfrmSubRole.FormShow(Sender: TObject);
begin
  UpdateListSubRole;
  SetAvailableSize;
end;

procedure TfrmSubRole.lstSubRoleClick(Sender: TObject);
begin
  if lstSubRole.ItemIndex = -1 then
    Exit;

  FSelectedSubRole := TSubRole(lstSubRole.Items.Objects[lstSubRole.ItemIndex]);
end;

procedure TfrmSubRole.UpdateListSubRole;
var
  i : Integer;
  subroleTemp : TSubRole;
begin
  lstSubRole.Items.Clear;

  dmINWO.GetAllSubRole(FSubRoleList);

  for i := 0 to FSubRoleList.Count - 1 do
  begin
    subroleTemp := FSubRoleList.Items[i];
    lstSubRole.Items.AddObject(subroleTemp.FData.SubRoleAcronim, subroleTemp);
  end;
end;

procedure TfrmSubRole.SetAvailableSize;
begin
  Width := 322;
  Height := 395;

  btnNew.Visible := True;
  btnEdit.Visible := True;
  btnDelete.Visible := True;
  btnClose.Visible := True;
  lstSubRole.Visible := True;

  pnlSubRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;
end;

procedure TfrmSubRole.SetSummarySize;
begin
  Width := 513;
  Height := 301;

  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  btnClose.Visible := False;
  lstSubRole.Visible := False;

  pnlSubRole.Visible := True;
  btnCancel.Visible := True;
  btnOk.Visible := True;

end;

end.
