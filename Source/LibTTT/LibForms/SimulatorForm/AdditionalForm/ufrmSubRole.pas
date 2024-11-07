unit ufrmSubRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

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
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);

  private
    procedure setAvailableRole;
    procedure setSummaryRole;

  public
    { Public declarations }
  end;

var
  frmSubRole: TfrmSubRole;

implementation

{$R *.dfm}

{ TfrmSubRole }


procedure TfrmSubRole.btnCancelClick(Sender: TObject);
begin
  setAvailableRole;

end;


procedure TfrmSubRole.btnDeleteClick(Sender: TObject);
begin
//
end;

procedure TfrmSubRole.btnEditClick(Sender: TObject);
begin
  setSummaryRole;
end;

procedure TfrmSubRole.btnNewClick(Sender: TObject);
begin
  setSummaryRole;
end;

procedure TfrmSubRole.FormShow(Sender: TObject);
begin
  setAvailableRole;
end;



procedure TfrmSubRole.setAvailableRole;
begin
  Width := 322;
  Height := 395;

  btnNew.Visible := True;
  btnEdit.Visible := True;
  btnDelete.Visible := True;
  lstSubRole.Visible := True;

  pnlSubRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;
end;

procedure TfrmSubRole.setSummaryRole;
begin
  Width := 513;
  Height := 301;

  btnNew.Visible := True;
  btnEdit.Visible := True;
  btnDelete.Visible := True;
  lstSubRole.Visible := True;

  pnlSubRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;

end;

end.
