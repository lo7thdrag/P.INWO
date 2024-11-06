unit ufrmRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmSummaryRole = class(TForm)
    btnCancel: TImage;
    btnOk: TImage;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnlRole: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtRole: TEdit;
    edtIdentifier: TEdit;
    lstRole: TListBox;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    procedure SetAvailableSize;
    procedure SetSummarySize;

  public

  end;

var
  frmSummaryRole: TfrmSummaryRole;

implementation

{$R *.dfm}

procedure TfrmSummaryRole.btnCancelClick(Sender: TObject);
begin
  SetAvailableSize;
end;

procedure TfrmSummaryRole.btnEditClick(Sender: TObject);
begin
  SetSummarySize
end;

procedure TfrmSummaryRole.btnNewClick(Sender: TObject);
begin
  SetSummarySize;
end;

procedure TfrmSummaryRole.FormShow(Sender: TObject);
begin
  SetAvailableSize;
end;

procedure TfrmSummaryRole.SetAvailableSize;
begin
  Width := 321;
  Height := 425;

  btnNew.Visible := True;
  btnEdit.Visible := True;
  btnDelete.Visible := True;
  lstRole.Visible := True;

  pnlRole.Visible := False;
  btnCancel.Visible := False;
  btnOk.Visible := False;
end;

procedure TfrmSummaryRole.SetSummarySize;
begin
  Width := 484;
  Height := 211;

  btnNew.Visible := False;
  btnEdit.Visible := False;
  btnDelete.Visible := False;
  lstRole.Visible := False;

  pnlRole.Visible := True;
  btnCancel.Visible := True;
  btnOk.Visible := True;
end;

end.
