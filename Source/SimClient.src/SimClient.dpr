program SimClient;

{$DEFINE CLIENT}

uses
  Forms,
  SysUtils,
  uThreadTimer in '..\SimFramework\LibBaseUtils\Counter\uThreadTimer.pas',
  uIniFilesProcs in '..\SimFramework\LibBaseUtils\uIniFilesProcs.pas',
  uStringFunc in '..\SimFramework\LibBaseUtils\StringUtils\uStringFunc.pas',
  uCodecBase64 in '..\SimFramework\LibBaseUtils\StringUtils\uCodecBase64.pas',
  uVirtualTime in '..\SimFramework\LibBaseUtils\Counter\uVirtualTime.pas',
  uSteppers in '..\SimFramework\LibBaseUtils\Counter\uSteppers.pas',
  uBaseSimObjects in '..\SimFramework\LibSims\SimSystem\uBaseSimObjects.pas',
  uSimContainers in '..\SimFramework\LibSims\SimSystem\uSimContainers.pas',
  uSimSettings in '..\SimFramework\LibSims\SimSystem\uSimSettings.pas',
  u2DMover in '..\SimFramework\LibSims\SimsObjects\u2DMover.pas',
  uSimObjects in '..\SimFramework\LibSims\SimSystem\uSimObjects.pas',
  uBaseSimCenter in '..\SimFramework\LibSims\SimSystem\uBaseSimCenter.pas',
  uSimVisuals in '..\LibTTT\LibVisual\uSimVisuals.pas',
  uCompassVisual in '..\LibTTT\LibVisual\uCompassVisual.pas',
  uObjectVisuals in '..\LibTTT\LibVisual\uObjectVisuals.pas',
  uPacketBuffer in '..\SimFramework\LibNets\NetComponent\uPacketBuffer.pas',
  uPacketRegister in '..\SimFramework\LibNets\NetComponent\uPacketRegister.pas',
  uTCPClient in '..\SimFramework\LibNets\NetComponent\uTCPClient.pas',
  uTCPDatatype in '..\SimFramework\LibNets\NetComponent\uTCPDatatype.pas',
  uTCPServer in '..\SimFramework\LibNets\NetComponent\uTCPServer.pas',
  uNetUDPnode in '..\SimFramework\LibNets\NetComponent\uNetUDPnode.pas',
  uNetBaseSocket in '..\SimFramework\LibNets\NetComponent\uNetBaseSocket.pas',
  uBaseNetHandler in '..\SimFramework\LibNets\uBaseNetHandler.pas',
  GmXml in '..\SimFramework\LibComponent\XMLReader\GmXml.pas',
  GmXMLInterface in '..\SimFramework\LibComponent\XMLReader\GmXMLInterface.pas',
  uT3UnitContainer in '..\LibTTT\libUnit\uT3UnitContainer.pas',
  DosCommand in '..\SimFramework\LibComponent\DosCommand\DosCommand.pas',
  uAppUtils in '..\SimFramework\LibBaseUtils\uAppUtils.pas',
  uT3Listener in '..\LibTTT\libUnit\uT3Listener.pas',
  uExecuter in '..\SimFramework\LibComponent\Executor\uExecuter.pas',
  uDataBuffer in '..\SimFramework\LibNets\NetComponent\uDataBuffer.pas',
  uVectorVisual in '..\LibTTT\libVisual\uVectorVisual.pas',
  GDIPAPI in '..\LibTTT\libGDIP\GDIPAPI.pas',
  GdiPlus in '..\LibTTT\libGDIP\GdiPlus.pas',
  GdiPlusHelpers in '..\LibTTT\libGDIP\GdiPlusHelpers.pas',
  GDIPOBJ in '..\LibTTT\libGDIP\GDIPOBJ.pas',
  uConstantaData in '..\LibTTT\LibData\uConstantaData.pas',
  uRecordData in '..\LibTTT\LibData\uRecordData.pas',
  uConsoleData in '..\LibTTT\LibData\uConsoleData.pas',
  uT3ClientEventManager in 'LibClient\uT3ClientEventManager.pas',
  uNetHandle_Client in 'LibClient\uNetHandle_Client.pas',
  uScriptSimClients in 'LibClient\uScriptSimClients.pas',
  uSimMgr_Client in 'LibClient\uSimMgr_Client.pas',
  uBaseCoordSystem in '..\LibTTT\LibData\uBaseCoordSystem.pas',
  uCoordConvertor in '..\LibTTT\LibData\uCoordConvertor.pas',
  uDataTypes in '..\LibTTT\LibData\uDataTypes.pas',
  uNetHandle_TTT in '..\LibTTT\LibNet\uNetHandle_TTT.pas',
  uFormula in '..\LibTTT\LibData\uFormula.pas',
  ufrmDatabaseLogin in '..\LibTTT\LibForms\ufrmDatabaseLogin.pas' {frmDatabaseLogin},
  uDataModule in '..\LibTTT\LibData\uDataModule.pas' {dmINWO: TDataModule},
  uLibSetting in '..\LibTTT\LibData\uLibSetting.pas',
  uMapXData in '..\LibTTT\LibComponent\uMapXData.pas',
  uMapXHandler in '..\LibTTT\LibComponent\uMapXHandler.pas',
  uTMapTouch2 in '..\LibTTT\LibComponent\uTMapTouch2.pas',
  WbemScripting_TLB in '..\LibTTT\LibComponent\WbemScripting_TLB.pas',
  uEventSummary in '..\LibTTT\LibManager\uEventSummary.pas',
  uScriptCommon in '..\LibTTT\LibManager\uScriptCommon.pas',
  uSimManager in '..\LibTTT\LibManager\uSimManager.pas',
  uT3EventManager in '..\LibTTT\LibManager\uT3EventManager.pas',
  uT3SimManager in '..\LibTTT\LibManager\uT3SimManager.pas',
  ufrmTacticalDisplay in '..\LibTTT\LibForms\SimulatorForm\ufrmTacticalDisplay.pas' {frmTacticalDisplay},
  uClassData in '..\LibTTT\LibData\uClassData.pas',
  ufrmDisplayArea in '..\LibTTT\LibForms\SimulatorForm\ufrmDisplayArea.pas' {frmDisplayArea},
  ufrmSituationBoard in '..\LibTTT\LibForms\SimulatorForm\ufrmSituationBoard.pas' {frmSituationBoard},
  ufrmTelegram in '..\LibTTT\LibForms\SimulatorForm\ufrmTelegram.pas' {frmTelegram},
  ufrmVideoConference in '..\LibTTT\LibForms\SimulatorForm\ufrmVideoConference.pas' {frmVideoConference},
  uDBAsset_Countermeasure in '..\LibTTT\LibData\uDBAsset_Countermeasure.pas',
  uDBAsset_Sensor in '..\LibTTT\LibData\uDBAsset_Sensor.pas',
  uDBAsset_Vehicle in '..\LibTTT\LibData\uDBAsset_Vehicle.pas',
  uDBAsset_Weapon in '..\LibTTT\LibData\uDBAsset_Weapon.pas',
  ufrmSummaryUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmSummaryUserRole.pas' {frmSummaryUserRole},
  ufrmCreateTab in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmCreateTab.pas' {frmCreateTab},
  ufrmImageInsert in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmImageInsert.pas' {frmImageInsert},
  ufrmAvailableUserRole in '..\LibTTT\LibForms\DatabaseEditorForm\ufrmAvailableUserRole.pas' {frmAvailableUserRole},
  UfrmMapEditor in '..\LibTTT\LibForms\DatabaseEditorForm\UfrmMapEditor.pas' {frmMapEditor},
  ufrmOverlayTools in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmOverlayTools.pas' {frmOverlayTools},
  ufrmSimbolTaktis in '..\LibTTT\LibForms\SimulatorForm\ufrmSimbolTaktis.pas' {frmSimbolTaktis},
  ufrmMapPreview in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmMapPreview.pas' {frmMapPreview},
  ufrmBrowseMap in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmBrowseMap.pas' {frmBrowseMap},
  ufrmAsset in '..\LibTTT\LibForms\SimulatorForm\ufrmAsset.pas' {frmAsset},
  ufrmRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmRole.pas' {frmSummaryRole},
  ufrmSubRole in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmSubRole.pas' {frmSubRole},
  ufrmSelectSimbolTaktis in '..\LibTTT\LibForms\SimulatorForm\AdditionalForm\ufrmSelectSimbolTaktis.pas' {frmSelectSimbolTaktis},
  ufrmRadarOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmRadarOnBoardPickList.pas' {frmRadarOnBoardPickList},
  ufrmRadarMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmRadarMount.pas' {frmRadarMount},
  ufrmBlindZoneAttachment in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\ufrmBlindZoneAttachment.pas' {frmBlindZonesAttachment},
  ufrmSonarOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmSonarOnBoardPickList.pas' {frmSonarOnBoardPickList},
  ufrmSonarMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmSonarMount.pas' {frmSonarMount},
  uSimbolTaktis in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Additional\uSimbolTaktis.pas' {SimbolTaktis},
  ufrmESMOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmESMOnBoardPickList.pas' {frmESMOnBoardPickList},
  ufrmESMMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmESMMount.pas' {frmESMMount},
  ufrmEODOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmEODOnBoardPickList.pas' {frmEODOnBoardPickList},
  ufrmEODMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmEODMount.pas' {frmEODMount},
  ufrmSonobuoyOnBoardPickList in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\OnBoardPickList\ufrmSonobuoyOnBoardPickList.pas' {frmSonobuoyOnBoardPickList},
  ufrmSonobuoyMount in '..\LibTTT\LibForms\DatabaseEditorForm\Platform\Mount\ufrmSonobuoyMount.pas' {frmSonobuoyMount};

{$R *.res}

var
  SavedDecimalSeparator : char;
//  SavedDateFormat : string;
begin
//  ReportMemoryLeaksOnShutdown := True;

  SavedDecimalSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';

  Application.Initialize;

  //Application.MainFormOnTaskbar := True;

  Application.Title := 'SimClient';
  Application.CreateForm(TdmINWO, dmINWO);
  Application.CreateForm(TfrmTacticalDisplay, frmTacticalDisplay);
  Application.CreateForm(TfrmSituationBoard, frmSituationBoard);
  Application.CreateForm(TfrmOverlayTools, frmOverlayTools);
  Application.CreateForm(TfrmBrowseMap, frmBrowseMap);
  Application.CreateForm(TfrmAsset, frmAsset);
  Application.CreateForm(TfrmSummaryRole, frmSummaryRole);
  Application.CreateForm(TfrmSubRole, frmSubRole);
  Application.CreateForm(TfrmSelectSimbolTaktis, frmSelectSimbolTaktis);
  Application.CreateForm(TfrmRadarOnBoardPickList, frmRadarOnBoardPickList);
  Application.CreateForm(TfrmRadarMount, frmRadarMount);
  Application.CreateForm(TfrmBlindZonesAttachment, frmBlindZonesAttachment);
  Application.CreateForm(TfrmSonarOnBoardPickList, frmSonarOnBoardPickList);
  Application.CreateForm(TfrmSonarMount, frmSonarMount);
  Application.CreateForm(TSimbolTaktis, SimbolTaktis);
  Application.CreateForm(TfrmESMOnBoardPickList, frmESMOnBoardPickList);
  Application.CreateForm(TfrmESMMount, frmESMMount);
  Application.CreateForm(TfrmEODOnBoardPickList, frmEODOnBoardPickList);
  Application.CreateForm(TfrmEODMount, frmEODMount);
  Application.CreateForm(TfrmSonobuoyOnBoardPickList, frmSonobuoyOnBoardPickList);
  Application.CreateForm(TfrmSonobuoyMount, frmSonobuoyMount);
  uScriptSimClients.BeginGame;

  Application.Run;

  uScriptSimClients.EndGame;
  FormatSettings.DecimalSeparator := SavedDecimalSeparator;

end.
