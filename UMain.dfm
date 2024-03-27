object FMain: TFMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'XML Reader'
  ClientHeight = 540
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 121
    Width = 602
    Height = 176
    Align = alTop
    Caption = 'GBMXml'
    TabOrder = 0
    object MXml: TMemo
      Left = 2
      Top = 15
      Width = 598
      Height = 159
      Align = alClient
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object PC: TPageControl
    Left = 0
    Top = 0
    Width = 602
    Height = 121
    ActivePage = TSOpenXml
    Align = alTop
    TabOrder = 1
    object TSOpenXml: TTabSheet
      Caption = 'Open XML File'
      object GBOpenFile: TGroupBox
        Left = 0
        Top = 0
        Width = 594
        Height = 41
        Align = alTop
        Caption = 'Open XML File'
        TabOrder = 0
        object EFileName: TEdit
          Left = 2
          Top = 15
          Width = 457
          Height = 24
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          ExplicitHeight = 21
        end
        object Button1: TButton
          Left = 459
          Top = 15
          Width = 133
          Height = 24
          Align = alRight
          Caption = 'Open File'
          TabOrder = 1
          OnClick = Button1Click
        end
      end
    end
    object TSPanel: TTabSheet
      Caption = 'Get XML From SMS Panel'
      ImageIndex = 1
      object Label1: TLabel
        Left = 3
        Top = 3
        Width = 92
        Height = 13
        Caption = 'Panel Line Number:'
      end
      object Label2: TLabel
        Left = 3
        Top = 38
        Width = 52
        Height = 13
        Caption = 'Username:'
      end
      object Label3: TLabel
        Left = 3
        Top = 72
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object ELineNumber: TEdit
        Left = 101
        Top = 0
        Width = 156
        Height = 21
        Alignment = taCenter
        TabOrder = 0
      end
      object EUsername: TEdit
        Left = 101
        Top = 35
        Width = 156
        Height = 21
        Alignment = taCenter
        TabOrder = 1
      end
      object EPassword: TEdit
        Left = 101
        Top = 69
        Width = 156
        Height = 21
        Alignment = taCenter
        PasswordChar = '*'
        TabOrder = 2
      end
      object CBDefualt: TCheckBox
        Left = 272
        Top = 38
        Width = 97
        Height = 17
        Caption = 'Defualt Panel'
        TabOrder = 3
        OnClick = CBDefualtClick
      end
      object Button2: TButton
        Left = 400
        Top = 3
        Width = 129
        Height = 87
        Caption = 'Get XML'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
  end
  object GBButton: TGroupBox
    Left = 0
    Top = 297
    Width = 602
    Height = 64
    Align = alTop
    TabOrder = 2
    object BConvert: TButton
      Left = 145
      Top = 15
      Width = 455
      Height = 47
      Align = alClient
      Caption = 'Convert xml to text'
      TabOrder = 0
      OnClick = BConvertClick
    end
    object BSave: TButton
      Left = 2
      Top = 15
      Width = 143
      Height = 47
      Align = alLeft
      Caption = 'Save'
      TabOrder = 1
      OnClick = BSaveClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 361
    Width = 602
    Height = 179
    Align = alClient
    Caption = 'Convert'
    TabOrder = 3
    object MXmlToTxt: TMemo
      Left = 2
      Top = 15
      Width = 598
      Height = 162
      Align = alClient
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object OpenFile: TOpenDialog
    Filter = 'Extensible Markup Language (XML)|*.xml'
    Left = 552
    Top = 40
  end
  object IdHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 552
    Top = 96
  end
end
