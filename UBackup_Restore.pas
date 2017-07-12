unit UBackup_Restore;

interface

uses
  StrUtils, FileCtrl, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvComponent, ExtCtrls, Mask, JvExMask,
  JvToolEdit, ComCtrls, uib;

type
  TFrmBackupRestore = class(TForm)
    btnExecutar: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheetLog: TTabSheet;
    lbEdtServidor: TLabeledEdit;
    lbEdtBanco: TLabeledEdit;
    JvUIBBackup1: TUIBBackup;
    cmbTipoBanco: TComboBox;
    Label1: TLabel;
    EdtBackup: TJvFilenameEdit;
    Label2: TLabel;
    Memo1: TMemo;
    lbEdtUsuario: TLabeledEdit;
    lbEdtSenha: TLabeledEdit;
    Bevel1: TBevel;
    Label3: TLabel;
    JvUIBRestore1: TUIBRestore;
    rdBackup: TRadioButton;
    rdRestore: TRadioButton;
    cbxDataAtual: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EdtBackupAfterDialog(Sender: TObject; var Name: string;
      var Action: Boolean);
    procedure rdRestoreClick(Sender: TObject);
    procedure rdBackupClick(Sender: TObject);
    procedure JvUIBBackup1Verbose(Sender: TObject; Message: string);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipoBancoChange(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure lbEdtServidorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure help_linha_comando;
  function BackupFileNameDateTime(FileName: String; Format: ShortString = 'dd_mm_yyyy'): String;

resourcestring
  usuario = 'SYSDBA';
  senha = 'masterkey';

var
  FrmBackupRestore: TFrmBackupRestore;

implementation

{$R *.dfm}

procedure help_linha_comando;
var
  s: TStringList;
  exe: String;
begin
   exe:= ExtractFileName(Application.ExeName);
   s:= TStringList.Create;
   try
     s.Text := 'Backup/Restore de Banco';
     s.Add('  -b = Backup / -c = Restore');
     s.Add('  tipo_banco = fb10, fb15, ib');
     s.Add('  servidor banco_ou_alias pasta_backup [user] [pass]');
     s.add('  Obs: O usuário e senha só precisam ser informados se forem diferentes do padrão.'#13);
     s.Add('  Ex. backup: ' + exe + ' -b fb15 localhost aposentadoria c:\backup');
     s.Add('  Ex. restore: ' + exe + ' -c fb15 localhost c:\backup\banco.fbk c:\backup\banco.fdb');

     s.Add(#13'Alterar informações de Login do Servidor de Banco de Dados');
     s.Add('  login usuario senha');
     s.Add('  Ex.: ' + exe + ' login adm axldk029');
     Application.MessageBox(pchar(s.text), 'Informação', mb_iconInformation);
   finally
      s.free;
   end;
end;

function BackupFileNameDateTime(FileName: String; Format: ShortString): String;
var ext: string[4];
begin
    ext:= ExtractFileExt(FileName);
    result:=
      ChangeFileExt(FileName, '') + '_' +
      FormatDateTime(Format, now) + ext;
end;

procedure TFrmBackupRestore.lbEdtServidorChange(Sender: TObject);
begin
  btnExecutar.Enabled:=
    (trim(lbEdtServidor.Text) <> '') and
    (trim(lbEdtBanco.Text) <> '') and
    (trim(EdtBackup.Text) <> '') and
    (trim(lbEdtUsuario.Text) <> '') and
    (trim(lbEdtSenha.Text) <> '');
end;

procedure TFrmBackupRestore.btnExecutarClick(Sender: TObject);
var
  service: TUIBBackupRestore;
  dir: String;
begin
  if rdBackup.Checked then
     service:= JvUIBBackup1
  else
  begin
    if (Application.MessageBox('Tem certeza que deseja executar a operação?',
    'Confirmação', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = mrNo) then
       exit;
    service:= JvUIBRestore1;
  end;

  case cmbTipoBanco.ItemIndex of
    0:  service.LibraryName := 'fbclient.dll';
    1:  service.LibraryName := 'gds32.dll';
  end;
  service.Host := lbEdtServidor.Text;
  service.Database := lbEdtBanco.Text;
  EdtBackup.Text:= AnsiReplaceText(EdtBackup.Text, ' ', '_');
  service.BackupFiles.Text := EdtBackup.Text;
  //showmessage(edtbackup.text);
  service.UserName := lbEdtUsuario.Text;
  service.PassWord := lbEdtSenha.Text;

  memo1.clear;
  TabSheetLog.TabVisible:= true;

  try
    btnExecutar.Enabled:= false;
    dir := ExtractFilePath(EdtBackup.FileName);
    if rdBackup.Checked  and (not DirectoryExists(dir)) then
       ForceDirectories(dir);
    service.Run;
    if trim(memo1.Lines.Text) <> '' then
       PageControl1.ActivePage:= TabSheetLog;
  finally
    btnExecutar.Enabled:= true;
    if Active then
    begin
      if rdBackup.Checked then
      begin
        if FileExists(EdtBackup.FileName) then
           Application.MessageBox('Backup concluído com sucesso.', 'Informação', MB_ICONINFORMATION)
        else Application.MessageBox('Erro na criação do backup. Verifique o log acima para informações adicionais.', 'Erro', MB_ICONERROR);
      end
      else
      begin
        if FileExists(lbEdtBanco.Text) then
           Application.MessageBox('Restauração concluída com sucesso.', 'Informação', MB_ICONINFORMATION)
        else Application.MessageBox('Erro na restauração do backup. Verifique o log acima para informações adicionais.', 'Erro', MB_ICONERROR);
      end;
    end;
  end;
end;

procedure TFrmBackupRestore.cmbTipoBancoChange(Sender: TObject);
begin
  case cmbTipoBanco.ItemIndex of
    0: EdtBackup.DefaultExt := '.fbk';
    1: EdtBackup.DefaultExt := '.gbk';
  end;
end;

procedure TFrmBackupRestore.FormCreate(Sender: TObject);
begin
  TabSheetLog.TabVisible:= false;
  PageControl1.ActivePageIndex := 0;
end;

procedure TFrmBackupRestore.JvUIBBackup1Verbose(Sender: TObject; Message: string);
type
  TPalavra = record
    ingles, portugues: ShortString;
  end;

const
  words: array [1..58] of TPalavra = (
    (ingles: 'readied'; portugues: 'lido'),
    (ingles: 'database'; portugues: 'banco de dados'),
    (ingles: 'for'; portugues: 'para'),
    (ingles: 'creating'; portugues: 'criando'),
    (ingles: 'file'; portugues: 'arquivo'),
    (ingles: 'starting'; portugues: 'iniciando'),
    (ingles: 'transaction'; portugues: 'trasação'),
    (ingles: 'has'; portugues: 'tem'),
    (ingles: 'a'; portugues: 'um'),
    (ingles: 'page'; portugues: 'página'),
    (ingles: 'size'; portugues: 'tamanho'),
    (ingles: 'of'; portugues: 'de'),
    (ingles: 'writing'; portugues: 'escrevendo'),
    (ingles: 'domains'; portugues: 'domínios'),
    (ingles: 'domain'; portugues: 'domínio'),
    (ingles: 'files'; portugues: 'arquivos'),
    (ingles: 'shadow'; portugues: 'sombra'),
    (ingles: 'tables'; portugues: 'tabelas'),
    (ingles: 'table'; portugues: 'tabela'),
    (ingles: 'column'; portugues: 'coluna'),
    (ingles: 'functions'; portugues: 'funções'),
    (ingles: 'function'; portugues: 'função'),
    (ingles: 'types'; portugues: 'tipos'),
    (ingles: 'type'; portugues: 'tipo'),
    (ingles: 'filters'; portugues: 'filtros'),
    (ingles: 'filter'; portugues: 'filtro'),
    (ingles: 'id generators'; portugues: 'geradores'),
    (ingles: 'generator'; portugues: 'gerador'),
    (ingles: 'value'; portugues: 'valor'),
    (ingles: 'stored procedures'; portugues: 'procedimentos armazenados'),
    (ingles: 'stored procedure'; portugues: 'procedimento armazenado'),
    (ingles: 'parameter'; portugues: 'parâmetro'),
    (ingles: 'exceptions'; portugues: 'exceções'),
    (ingles: 'exception'; portugues: 'exceção'),
    (ingles: 'character sets'; portugues: 'Conjuntos de Caracteres'),
    (ingles: 'character set'; portugues: 'Conjunto de Caracteres'),
    (ingles: 'collations'; portugues: 'Collations'),
    (ingles: 'index'; portugues: 'índice'),
    (ingles: 'data'; portugues: 'dados'),
    (ingles: 'records'; portugues: 'registro'),
    (ingles: 'written'; portugues: 'escrito'),
    (ingles: 'triggers'; portugues: 'gatilhos'),
    (ingles: 'trigger'; portugues: 'gatilho'),
    (ingles: 'messages'; portugues: 'mensagens'),
    (ingles: 'message'; portugues: 'mensagem'),
    (ingles: 'privilege'; portugues: 'privilégio'),
    (ingles: 'user'; portugues: 'usuário'),
    (ingles: 'constraint'; portugues: 'restrição'),
    (ingles: 'referencial constraints'; portugues: 'restrições referenciais'),
    (ingles: 'referencial constraint'; portugues: 'restrição referencial'),
    (ingles: 'check constraints'; portugues: 'restrições de validação'),
    (ingles: 'check constraint'; portugues: 'restrição de validação'),
    (ingles: 'sql roles'; portugues: 'regras'),
    (ingles: 'sql role'; portugues: 'regra'),
    (ingles: 'closing'; portugues: 'fechando'),
    (ingles: 'committing'; portugues: 'confirmando'),
    (ingles: 'and'; portugues: 'e'),
    (ingles: 'finishing'; portugues: 'finalizando')
  );

var
  p, i: integer;
  aux: string;
begin

  p:= pos('gbak: ', message);
  if p > 0 then
     delete(message, 1, 6);

  {for i:= 1 to 58 do
  begin
    p:= pos(words[i].ingles, AnsiLowerCase(message));
    if p > 0 then
    begin
      aux:= copy(message, 1, p-1);
      aux:= aux + words[i].portugues;
      aux:= copy(message, p + length(words[i].ingles) + 1, length(message));
      message:= aux;
    end;
  end;   }
  memo1.lines.add(message);
end;

procedure TFrmBackupRestore.rdBackupClick(Sender: TObject);
begin
  lbEdtUsuario.Text := usuario;
  lbEdtSenha.Text := senha;
  cbxDataAtual.Enabled := true;
end;

procedure TFrmBackupRestore.rdRestoreClick(Sender: TObject);
begin
  lbEdtUsuario.clear;
  lbEdtSenha.clear;
  cbxDataAtual.Enabled := false;
end;

procedure TFrmBackupRestore.EdtBackupAfterDialog(Sender: TObject;
  var Name: string; var Action: Boolean);
begin
  if cbxDataAtual.Enabled and cbxDataAtual.Checked then
     Name:= BackupFileNameDateTime(Name, 'dd_mm_yyyy_hh_nn_ss"h"');
end;

procedure TFrmBackupRestore.BitBtn1Click(Sender: TObject);
begin
Application.MessageBox(pchar('Manoel Campos da Silva Filho'#13 +
 'Software Engineer'#13 +
 'Professor do Instituto Federal do Tocantins (IFTO)'), 'Backup FB/IB', MB_ICONINFORMATION);
end;

procedure TFrmBackupRestore.FormShow(Sender: TObject);
begin
  rdBackupClick(rdBackup);
end;

procedure TFrmBackupRestore.BitBtn2Click(Sender: TObject);
begin
  help_linha_comando;
end;

end.
