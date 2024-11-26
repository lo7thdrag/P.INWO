unit ufrmRadarOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Sensor, uClassData, uSimContainers ;

type
  TfrmRadarOnBoardPickList = class(TForm)
    lbAllRadarDef: TListBox;
    lbAllRadarOnBoard: TListBox;
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

    procedure lbAllRadarDefClick(Sender: TObject);
    procedure lbAllRadarOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    FAllRadarDefList : TList;
    FAllRadarOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedRadar : TRadar_On_Board;

  public
    procedure UpdateRadarList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmRadarOnBoardPickList: TfrmRadarOnBoardPickList;

implementation

uses
  uDataModule, ufrmRadarMount, ufrmAsset;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmRadarOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllRadarDefList);
//  FreeItemsAndFreeList(FAllRadarOnBoardList);

end;

procedure TfrmRadarOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllRadarDefList := TList.Create;
  FAllRadarOnBoardList := TList.Create;
end;

procedure TfrmRadarOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateRadarList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmRadarOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllRadarDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmRadarMount) then
    frmRadarMount := TfrmRadarMount.Create(Self);

  try
    with frmRadarMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedRadar := FSelectedRadar;
      Show;
    end;
  finally
  end;
end;

procedure TfrmRadarOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllRadarOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmRadarMount) then
    frmRadarMount := TfrmRadarMount.Create(Self);

  try
    with frmRadarMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedRadar := FSelectedRadar;
      Show;
    end;
  finally
  end;
end;

procedure TfrmRadarOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllRadarOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedRadar.FData do
  begin
    dmINWO.DeleteRadarOnBoard(2, Radar_Instance_Index);
  end;

  UpdateRadarList;
end;

procedure TfrmRadarOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateSensorData;
  Close;
end;

procedure TfrmRadarOnBoardPickList.lbAllRadarDefClick(Sender: TObject);
begin
  if lbAllRadarDef.ItemIndex = -1 then
    Exit;

  FSelectedRadar := TRadar_On_Board(lbAllRadarDef.Items.Objects[lbAllRadarDef.ItemIndex]);
end;

procedure TfrmRadarOnBoardPickList.lbAllRadarOnBoardClick(Sender: TObject);
begin
  if lbAllRadarOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedRadar := TRadar_On_Board(lbAllRadarOnBoard.Items.Objects[lbAllRadarOnBoard.ItemIndex]);
end;

procedure TfrmRadarOnBoardPickList.UpdateRadarList;
var
  i : Integer;
  radar : TRadar_On_Board;
begin
  lbAllRadarDef.Items.Clear;
  lbAllRadarOnBoard.Items.Clear;

  dmINWO.GetAllRadarDef(FAllRadarDefList);
  dmINWO.GetRadarOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllRadarOnBoardList);

  for i := 0 to FAllRadarDefList.Count - 1 do
  begin
    radar := FAllRadarDefList.Items[i];
    lbAllRadarDef.Items.AddObject(radar.FDef.Radar_Identifier, radar);
  end;

  for i := 0 to FAllRadarOnBoardList.Count - 1 do
  begin
    radar := FAllRadarOnBoardList.Items[i];
    lbAllRadarOnBoard.Items.AddObject(radar.FData.Instance_Identifier, radar);
  end;
end;

{$ENDREGION}

end.
