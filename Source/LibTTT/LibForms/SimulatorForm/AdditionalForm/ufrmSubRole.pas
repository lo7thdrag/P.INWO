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
    Label10: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label13: TLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSubRole: TfrmSubRole;

implementation

{$R *.dfm}

end.
