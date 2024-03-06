inherited DmeXactWMS: TDmeXactWMS
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  inherited QryTemp: TFDQuery
    Left = 159
    Top = 95
  end
  inherited FDScript1: TFDScript
    Left = 159
    Top = 31
  end
  inherited QryData: TFDQuery
    Connection = ConnRhemaWMS
  end
  inherited RESTClientWMS: TRESTClient
    BaseURL = 'http://192.168.0.165:8200'
  end
  inherited RESTRequestWMS: TRESTRequest
    Timeout = 600000
  end
  inherited RESTRequestCep: TRESTRequest
    Timeout = 300000
  end
  object JvMemoryData1: TJvMemoryData
    FieldDefs = <>
    Left = 344
    Top = 256
  end
end
