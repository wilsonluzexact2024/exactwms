object WebModuleApi: TWebModuleApi
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'WebActionPadrao'
      OnAction = WebModuleApiWebActionPadraoAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 314
  Width = 608
  PixelsPerInch = 120
end
