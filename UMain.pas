unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  ActiveX,ComObj,HTTPApp;

type
  TFMain = class(TForm)
    OpenFile: TOpenDialog;
    MXml: TMemo;
    GroupBox1: TGroupBox;
    PC: TPageControl;
    TSOpenXml: TTabSheet;
    TSPanel: TTabSheet;
    GBOpenFile: TGroupBox;
    EFileName: TEdit;
    Button1: TButton;
    ELineNumber: TEdit;
    EUsername: TEdit;
    EPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CBDefualt: TCheckBox;
    Button2: TButton;
    IdHTTP: TIdHTTP;
    BConvert: TButton;
    GBButton: TGroupBox;
    BSave: TButton;
    GroupBox2: TGroupBox;
    MXmlToTxt: TMemo;
    procedure FormShow(Sender: TObject);
    procedure CBDefualtClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;
  Exepath,TxtPath,XmlPath:string;
implementation

{$R *.dfm}
function RunURL (urlStr:string):string;
var
  Params: TStringlist;
  resp: TStringStream;
  http: TIdHTTP;
begin
  Result:='';
  try
    resp := TStringStream.Create('');
    http:= TIdHTTP.Create(nil);
    Params := TStringlist.create;
    params.Values['action']:='ver';
    with HTTP do
    begin
      HandleRedirects := True;
      AllowCookies := True;
      Request.ContentType := 'application/x-www-form-urlencoded';//'text/html';
      Request.AcceptCharSet := 'utf-8';
      Request.Connection := 'Keep-Alive';
      Request.ProxyConnection := 'Keep-Alive';
      Request.CacheControl := 'no-cache';
      try
       post(urlStr,params,resp);
      except
        //...
      end;
      //ShowMessage(resp.DataString);
      Result:=resp.DataString;
    end;
  finally
    params.Free;
    resp.Free;
    http.free;
  end;
end;


function URLDecode(const s : string) : string;
begin
  result := Utf8ToAnsi(HTTPDecode(s));
end;

{procedure ClearTempLine (SText:string);
var i:integer;
begin
  for I := 0 to FMain.MXml.Lines.Count do
  begin
    if pos(SText,FMain.MXml.Lines[i]) > 0 then
      FMain.MXml.Lines[i]:='';
  end;
end;  }

{function urlDecode(url: string): string;
var i, s, g: Integer;
begin
  Result :='';

  for i := 1 to Length(url) do
  begin

    if url[i] = '%' then
    begin
      s := StrtoInt('$' + url[i + 1]) * 16;
      g := StrtoInt('$' + url[i + 2]);

      Result := Result + Chr(s + g);
    end
    else if not (((url[i - 1] = '%') and (url[i + 1] <> '%')) or ((url[i - 2] = '%') and (url[i - 1] <> '%') and (url[i + 1] = '%')) or ((url[i - 2] = '%') and (url[i - 1] <> '%') and (url[i + 1] <> '%'))) then
      Result := Result + url[i];
  end;
end;  }

procedure TFMain.Button1Click(Sender: TObject);
var s:string;
begin
  OpenFile.Execute();
  if FileExists(OpenFile.FileName) then
  begin
    EFileName.Text:=OpenFile.FileName;
    MXml.Lines.LoadFromFile(OpenFile.FileName);
    MXml.Lines.Text:=urlDecode(MXml.Lines.Text);
    BConvert.Click;
  //  ClearTempLine('allmessage');
  end
  else
    ShowMessage('File not found.');
end;

procedure TFMain.Button2Click(Sender: TObject);
var s:string;
begin
  MXml.Lines.Text:='';
  if EUsername.Text <> '' then
  begin
    EFileName.Text:='';
    s:=RunURL('http://tsms.ir/url/recived_sms_xml.php?from='+ELineNumber.Text+'&username='+EUsername.Text+'&password='+EPassword.Text+'&user_login=0&credit=what');
    MXml.Text:=urlDecode(s);
    if MXml.Lines.Text <> '' then
    begin
      MXml.Lines.SaveToFile(XmlPath+'Url.xml');
      BConvert.Click;
    end;
  end
  else
    ShowMessage('Invalid Username!');
 // ClearTempLine('allmessage');
end;

procedure TFMain.BConvertClick(Sender: TObject);
const VerXMLDocument = 'Msxml2.DOMDocument.6.0';
var i:integer;
    XmlDoc,Node1,Node2,Node3,Node4:OleVariant;
begin

  MXmlToTxt.Lines.Text:='';
  XmlDoc:=CreateOleObject(VerXMLDocument);
  try
    XmlDoc.Async := False;
    if EFileName.Text <> '' then
      XmlDoc.Load(EFileName.Text)
    else
      XmlDoc.Load(XmlPath+'Url.xml');

    Node1:=XmlDoc.selectNodes('//allmessage/msg/unicid');
    Node2:=XmlDoc.selectNodes('//allmessage/msg/from');
    Node3:=XmlDoc.selectNodes('//allmessage/msg/date');
    Node4:=XmlDoc.selectNodes('//allmessage/msg/text');

    for I := 0 to Node1.length -1 do
    begin
      MXmlToTxt.Lines.Add('');
      MXmlToTxt.Lines.Add('Unicid: '+Node1.Item(i).Text);
      MXmlToTxt.Lines.Add('Form: '+Node2.Item(i).Text);
      MXmlToTxt.Lines.Add('Date: '+Node3.Item(i).Text);
      MXmlToTxt.Lines.Add('Text: '+Node4.Item(i).Text);
    end;

  finally
    XmlDoc :=Unassigned;
  end;

  BSave.Click;
{  for g := 0 to XmlDoc.DocumentElement.ChildNodes.Count-1 do
  begin
    LeaderNode:=XmlDoc.DocumentElement.ChildNodes[g];
    MXmlToTxt.Lines.Add('');
    for i:=0 to LeaderNode.ChildNodes.Count-1 do
    begin
      SubNode:=LeaderNode.ChildNodes[i];
      if i <= Length(SParams) then
      begin
        MXmlToTxt.Lines.Add(SParams[i]+': '+SubNode.Text);
      end;
      LeaderNode:=LeaderNode.NextSibling;
    end;
  end; }
end;

procedure TFMain.BSaveClick(Sender: TObject);
begin
  if MXmlToTxt.Lines.Text <> '' then
  begin
    MXmlToTxt.Lines.SaveToFile(TxtPath+'XmlToTxt.txt');
    ShowMessage('Saved');
  end
  else
    ShowMessage('Unsaved'+#13+'Convert is Empty');
end;

procedure TFMain.CBDefualtClick(Sender: TObject);
begin
  if CBDefualt.Checked = true then
  begin
    ELineNumber.Enabled:=false;
    EUsername.Enabled:=false;
    EPassword.Enabled:=false;
    ELineNumber.Text:='30007227003685';
    EUsername.Text:='rahnamasoft';
    EPassword.Text:='tsms83p83';
  end
  else
  begin
    ELineNumber.Enabled:=true;
    EUsername.Enabled:=true;
    EPassword.Enabled:=true;
    ELineNumber.Text:='';
    EUsername.Text:='';
    EPassword.Text:='';
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  Exepath:=ExtractFilePath(Application.ExeName);
  TxtPath:=Exepath+'Convert\';
  XmlPath:=Exepath+'Xml\';
  if not DirectoryExists(TxtPath) then
    CreateDir(TxtPath);
  if not DirectoryExists(XmlPath) then
    CreateDir(XmlPath);
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  PC.ActivePage:=TSOpenXml;


end;

end.
