unit ufrmToteDisplay;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmToteDisplay = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToteDisplay: TfrmToteDisplay;

implementation

{$R *.dfm}

end.
