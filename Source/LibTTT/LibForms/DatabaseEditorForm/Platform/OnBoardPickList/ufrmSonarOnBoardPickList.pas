unit ufrmSonarOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmSonarOnBoardPickList = class(TForm)
    lbAllSonarOnBoard: TListBox;
    lbAllSonarDef: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllSonarDefClick(Sender: TObject);
    procedure lbAllSonarOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    FAllSonarDefList : TList;
    FAllSonarOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedSonar : TSonar_On_Board;

    procedure UpdateSonarList;

  public
    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var

  frmSonarOnBoardPickList: TfrmSonarOnBoardPickList;

implementation

uses
  uDataModule, ufrmSonarMount;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSonarOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FAllSonarDefList);
  FreeItemsAndFreeList(FAllSonarOnBoardList);

  Action := cafree;
end;

procedure TfrmSonarOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllSonarDefList := TList.Create;
  FAllSonarOnBoardList := TList.Create;
end;

procedure TfrmSonarOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateSonarList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSonarOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllSonarDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmSonarMount) then
    frmSonarMount := TfrmSonarMount.Create(Self);

  try
    with frmSonarMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedSonar := FSelectedSonar;
      Show;
    end;
  finally
  end;

//  UpdateSonarList;
end;

procedure TfrmSonarOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllSonarOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmSonarMount) then
    frmSonarMount := TfrmSonarMount.Create(Self);

  try
    with frmSonarMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedSonar := FSelectedSonar;
      Show;
    end;
  finally
  end;

//  UpdateSonarList;
end;

procedure TfrmSonarOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllSonarOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedSonar.FData do
  begin
    dmINWO.DeleteSonarOnBoard(2, Sonar_Instance_Index);
  end;

  UpdateSonarList;
end;

procedure TfrmSonarOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSonarOnBoardPickList.lbAllSonarDefClick(Sender: TObject);
begin
  if lbAllSonarDef.ItemIndex = -1 then
    Exit;

  FSelectedSonar := TSonar_On_Board(lbAllSonarDef.Items.Objects[lbAllSonarDef.ItemIndex]);
end;

procedure TfrmSonarOnBoardPickList.lbAllSonarOnBoardClick(Sender: TObject);
begin
  if lbAllSonarOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedSonar := TSonar_On_Board(lbAllSonarOnBoard.Items.Objects[lbAllSonarOnBoard.ItemIndex]);
end;

procedure TfrmSonarOnBoardPickList.UpdateSonarList;
var
  i : Integer;
  sonar : TSonar_On_Board;
begin
  lbAllSonarDef.Items.Clear;
  lbAllSonarOnBoard.Items.Clear;

  dmINWO.GetAllSonarDef(FAllSonarDefList);
  dmINWO.GetSonarOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllSonarOnBoardList);

  for i := 0 to FAllSonarDefList.Count - 1 do
  begin
    sonar := FAllSonarDefList.Items[i];
    lbAllSonarDef.Items.AddObject(sonar.FDef.Sonar_Identifier, sonar);
  end;

  for i := 0 to FAllSonarOnBoardList.Count - 1 do
  begin
    sonar := FAllSonarOnBoardList.Items[i];
    lbAllSonarOnBoard.Items.AddObject(sonar.FData.Instance_Identifier, sonar);
  end;
end;

{$ENDREGION}

end.
