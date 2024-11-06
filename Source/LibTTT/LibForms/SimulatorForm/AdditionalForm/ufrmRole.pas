unit ufrmRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmSummaryRole = class(TForm)
    btnApply: TImage;
    btnCancel: TImage;
    btnOk: TImage;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    btnShowPassword: TImage;
    btnShowPassword2: TImage;
    Label14: TLabel;
    Label15: TLabel;
    chkPelaksanaan: TCheckBox;
    chkPengakhiran: TCheckBox;
    chkPerencanaan: TCheckBox;
    chkPersiapan: TCheckBox;
    edtConfirmPassword: TEdit;
    edtPassword: TEdit;
    edtUsername: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSummaryRole: TfrmSummaryRole;

implementation

{$R *.dfm}

end.
