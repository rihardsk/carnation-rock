object Form1: TForm1
  AlignWithMargins = True
  Left = 150
  Top = 105
  Caption = 'Form1'
  ClientHeight = 760
  ClientWidth = 1028
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  DesignSize = (
    1028
    760)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 824
    Top = 200
    Width = 96
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'detalizacijas pakape'
  end
  object Label2: TLabel
    Left = 980
    Top = 534
    Width = 16
    Height = 19
    Anchors = [akTop, akRight]
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 933
    Top = 513
    Width = 72
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Randomnes:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 933
    Top = 557
    Width = 34
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Hight:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 980
    Top = 577
    Width = 16
    Height = 19
    Anchors = [akTop, akRight]
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button2: TButton
    Left = 968
    Top = 400
    Width = 49
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'nodzest'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 944
    Top = 192
    Width = 73
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 1
    Text = '7'
    OnChange = Edit1Change
  end
  object Button3: TButton
    Left = 968
    Top = 249
    Width = 49
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'zime'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 968
    Top = 464
    Width = 49
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'pamazam'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button12: TButton
    Left = 918
    Top = 682
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '>'
    TabOrder = 4
    Visible = False
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 856
    Top = 682
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '<'
    TabOrder = 5
    Visible = False
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 887
    Top = 650
    Width = 25
    Height = 26
    Anchors = [akRight, akBottom]
    Caption = '^'
    TabOrder = 6
    Visible = False
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 887
    Top = 713
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'v'
    TabOrder = 7
    Visible = False
    OnClick = Button15Click
  end
  object Edit2: TEdit
    Left = 544
    Top = 735
    Width = 25
    Height = 21
    Anchors = [akRight, akBottom]
    TabOrder = 8
    Text = '5'
    OnChange = Edit2Change
  end
  object Button16: TButton
    Left = 949
    Top = 682
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '>v'
    TabOrder = 9
    Visible = False
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 825
    Top = 682
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'v<'
    TabOrder = 10
    Visible = False
    OnClick = Button17Click
  end
  object Button5: TButton
    Left = 624
    Top = 734
    Width = 41
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '0,0,0'
    TabOrder = 11
    OnClick = Button5Click
  end
  object Edit3: TEdit
    Left = 968
    Top = 288
    Width = 49
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 12
  end
  object Edit4: TEdit
    Left = 968
    Top = 320
    Width = 49
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 13
  end
  object Edit5: TEdit
    Left = 968
    Top = 352
    Width = 49
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 14
  end
  object Button6: TButton
    Left = 513
    Top = 733
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '+'
    TabOrder = 15
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 575
    Top = 734
    Width = 25
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '-'
    TabOrder = 16
    OnClick = Button7Click
  end
  object ScrollBar1: TScrollBar
    Left = 8
    Top = 725
    Width = 313
    Height = 9
    Anchors = [akLeft, akBottom]
    PageSize = 0
    Position = 40
    TabOrder = 17
    OnChange = ScrollBar1Change
  end
  object ScrollBar2: TScrollBar
    Left = 8
    Top = 733
    Width = 313
    Height = 9
    Anchors = [akLeft, akBottom]
    PageSize = 0
    Position = 50
    TabOrder = 18
    OnChange = ScrollBar2Change
  end
  object ScrollBar3: TScrollBar
    Left = 8
    Top = 740
    Width = 313
    Height = 9
    Anchors = [akLeft, akBottom]
    PageSize = 0
    Position = 20
    TabOrder = 19
    OnChange = ScrollBar3Change
  end
  object Button8: TButton
    Left = 544
    Top = 601
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '^'
    TabOrder = 20
    Visible = False
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 544
    Top = 663
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'v'
    TabOrder = 21
    Visible = False
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 575
    Top = 632
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '>'
    TabOrder = 22
    Visible = False
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 513
    Top = 632
    Width = 25
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '<'
    TabOrder = 23
    Visible = False
    OnClick = Button11Click
  end
  object Edit6: TEdit
    Left = 933
    Top = 535
    Width = 41
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 24
    Text = '70'
    OnChange = Edit6Change
  end
  object Edit7: TEdit
    Left = 933
    Top = 579
    Width = 41
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 25
    Text = '80'
    OnChange = Edit7Change
  end
  object Edit8: TEdit
    Left = 933
    Top = 616
    Width = 41
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 26
    Text = '10'
    OnChange = Edit8Change
  end
  object MainMenu1: TMainMenu
    object File1: TMenuItem
      Caption = 'File'
      object Export1: TMenuItem
        Caption = 'Export'
        OnClick = Export1Click
      end
      object Close1: TMenuItem
        Caption = 'Exit'
        OnClick = Close1Click
      end
      object TMenuItem
      end
    end
    object Options1: TMenuItem
      Caption = 'View'
      object Cameracontrols1: TMenuItem
        Caption = 'Camera controls'
        OnClick = Cameracontrols1Click
      end
      object Rotationcontrols1: TMenuItem
        Caption = 'Rotation controls'
        OnClick = Rotationcontrols1Click
      end
      object Randomnesscontrols1: TMenuItem
        Caption = 'Randomness controls'
        OnClick = Randomnesscontrols1Click
      end
    end
    object Options2: TMenuItem
      Caption = 'Options'
      object Enablebackfaceculling1: TMenuItem
        Caption = 'Toggle back face culling'
        OnClick = Enablebackfaceculling1Click
      end
      object Invertmouse1: TMenuItem
        Caption = 'Invert camera'
        OnClick = Invertmouse1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Readme1: TMenuItem
        Caption = 'Readme'
        OnClick = Readme1Click
      end
    end
  end
end
